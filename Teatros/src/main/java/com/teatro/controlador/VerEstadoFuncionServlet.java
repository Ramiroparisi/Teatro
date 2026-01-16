package com.teatro.controlador;

import com.teatro.data.AsientoDAO;
import com.teatro.data.FuncionDAO;
import com.teatro.data.ObraDAO;
import com.teatro.modelo.Asiento;
import com.teatro.modelo.Funcion;
import com.teatro.modelo.Obra;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/verEstadoFuncion")
public class VerEstadoFuncionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("listaObras");
            return;
        }

        try {
            int funcionId = Integer.parseInt(idParam);
            FuncionDAO fdao = new FuncionDAO();
            Funcion funcion = fdao.getByID(funcionId);
            if (funcion == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "La función no existe.");
                return;
            }

            ObraDAO odao = new ObraDAO();
            Obra obra = odao.getByID(funcion.getObraID());
            if (obra == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "La obra asociada no existe.");
                return;
            }

            int teatroId = obra.getTeatroID();
            AsientoDAO adao = new AsientoDAO();
            List<Asiento> asientos = adao.getEstadoAsientos(teatroId, funcionId);
            if (asientos.isEmpty()) {
                adao.generarAsientosDeTeatro(teatroId);
                asientos = adao.getEstadoAsientos(teatroId, funcionId);
            }
            
            request.setAttribute("funcion", funcion);
            request.setAttribute("obra", obra);
            request.setAttribute("asientos", asientos);
            
            request.getRequestDispatcher("/WEB-INF/verEstadoFuncion.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
}