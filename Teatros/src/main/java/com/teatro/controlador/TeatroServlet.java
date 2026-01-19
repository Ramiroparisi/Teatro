package com.teatro.controlador;

import com.teatro.data.TeatroDAO;
import com.teatro.modelo.Teatro;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/listaTeatros") 
public class TeatroServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            TeatroDAO tdao = new TeatroDAO();
            List<Teatro> lista = tdao.getAll();
            
            request.setAttribute("listaTeatros", lista);
            request.getRequestDispatcher("/WEB-INF/Admin/listaTeatros.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al cargar la lista de teatros");
        }
    }
}