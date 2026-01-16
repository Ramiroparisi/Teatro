package com.teatro.controlador;

import com.teatro.data.AsientoDAO;
import com.teatro.data.TeatroDAO;
import com.teatro.modelo.Asiento;
import com.teatro.modelo.Teatro;
import com.teatro.modelo.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/diagramarTeatro")
public class DiagramadorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("listaTeatros");
            return;
        }

        try {
            int teatroId = Integer.parseInt(idStr);
            Teatro teatro = new TeatroDAO().getById(teatroId);
            List<Asiento> asientosExistentes = new AsientoDAO().getByTeatro(teatroId);

            request.setAttribute("teatro", teatro);
            request.setAttribute("asientos", asientosExistentes);
            
            request.getRequestDispatcher("/WEB-INF/diagramador.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int teatroId = Integer.parseInt(request.getParameter("teatroId"));
            String[] filasCoord = request.getParameterValues("filaCoord[]");
            String[] colsCoord = request.getParameterValues("colCoord[]");
            String[] nombresFila = request.getParameterValues("nombreFila[]");
            String[] numeros = request.getParameterValues("numeroAsiento[]");

            List<Asiento> listaNuevosAsientos = new ArrayList<>();
            if (filasCoord != null) {
                for (int i = 0; i < filasCoord.length; i++) {
                    Asiento a = new Asiento();
                    a.setFilaCoord(Integer.parseInt(filasCoord[i]));
                    a.setColCoord(Integer.parseInt(colsCoord[i]));
                    a.setFilaNombre(nombresFila[i]);
                    a.setNumero(Integer.parseInt(numeros[i]));
                    a.setTeatroID(teatroId);
                    listaNuevosAsientos.add(a);
                }
            }

            new AsientoDAO().saveDiagrama(teatroId, listaNuevosAsientos);
            response.sendRedirect("listaTeatros?success=diagrama");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al guardar");
        }
    }
}