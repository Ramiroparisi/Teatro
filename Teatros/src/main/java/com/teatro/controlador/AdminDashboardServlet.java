package com.teatro.controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.teatro.modelo.Usuario;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/adminDashboard.jsp").forward(request, response);
    }
}