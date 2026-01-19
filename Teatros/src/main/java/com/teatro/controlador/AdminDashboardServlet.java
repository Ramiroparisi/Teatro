package com.teatro.controlador;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.teatro.data.ObraDAO;
import com.teatro.data.UsuarioDAO;
import com.teatro.modelo.Usuario;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            ObraDAO odao = new ObraDAO();
            UsuarioDAO udao = new UsuarioDAO();

            int cantObrasActivas = odao.getCountObrasConFunciones();
            int cantClientes = udao.getCountClientes();

            request.setAttribute("cantObras", cantObrasActivas);
            request.setAttribute("cantClientes", cantClientes);
            request.getRequestDispatcher("/WEB-INF/Admin/adminDashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al conectar con la base de datos");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Ocurrió un error inesperado");
        }
    }
}