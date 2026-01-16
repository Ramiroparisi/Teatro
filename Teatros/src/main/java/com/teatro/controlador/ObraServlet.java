package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.modelo.Obra;
import java.io.IOException;
import java.sql.SQLException; // ESTA IMPORTACIÓN FALTA
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/listaObras") 
public class ObraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ObraDAO odao = new ObraDAO();
        try {
            List<Obra> lista = odao.getAllWithFunciones(); 
            
            request.setAttribute("listaObras", lista);
            request.getRequestDispatcher("/WEB-INF/listaObras.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cargar la lista de obras.");
        }
    }
}