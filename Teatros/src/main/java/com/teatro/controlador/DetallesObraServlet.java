package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.modelo.Obra;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/detallesObra")
public class DetallesObraServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                ObraDAO odao = new ObraDAO();
                Obra obra = odao.getByID(id); 
                
                if (obra != null) {
                    request.setAttribute("obra", obra);
                    request.getRequestDispatcher("/detallesObra.jsp").forward(request, response);
                } else {
                    response.sendRedirect("inicio");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("inicio");
            }
        } else {
            response.sendRedirect("inicio");
        }
    }
}