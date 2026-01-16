package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.modelo.Obra;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/listaObras")
public class ObraServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            ObraDAO odao = new ObraDAO();
            List<Obra> lista = odao.getAllWithFunciones(); 
            
            if (lista == null || lista.isEmpty()) {
                System.out.println("DEBUG: No se encontraron obras o la lista es nula");
            }

            request.setAttribute("listaObras", lista);
            request.getRequestDispatcher("/WEB-INF/listaObras.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error en el Servlet: " + e.getMessage());
        }
    }
}