package com.teatro.controlador;

import com.teatro.data.AsientoDAO;
import com.teatro.data.FuncionDAO;
import com.teatro.data.ObraDAO;
import com.teatro.modelo.Asiento;
import com.teatro.modelo.Funcion;
import com.teatro.modelo.Obra;
import com.teatro.modelo.Usuario;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/seleccionarAsientos")
public class SeleccionarAsientosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Usuario user = (Usuario) request.getSession().getAttribute("usuarioLogueado");
        if (user == null) {
            response.sendRedirect("login.jsp?msg=debe_iniciar_sesion");
            return;
        }

        String idParam = request.getParameter("funcionId");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("listaObras");
            return;
        }

        try {
            int funcionId = Integer.parseInt(idParam);
            FuncionDAO fdao = new FuncionDAO();
            Funcion funcion = fdao.getByID(funcionId);
            
            if (funcion == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "La función solicitada no existe.");
                return;
            }
            ObraDAO odao = new ObraDAO();
            Obra obra = odao.getByID(funcion.getObraID());
            AsientoDAO adao = new AsientoDAO();
            List<Asiento> asientos = adao.getEstadoAsientos(funcion.getTeatroID(), funcionId);
            request.setAttribute("funcion", funcion);
            request.setAttribute("obra", obra);
            request.setAttribute("asientos", asientos);
            
            request.getRequestDispatcher("/WEB-INF/seleccionarAsiento.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cargar el mapa: " + e.getMessage());
        }
    }
}