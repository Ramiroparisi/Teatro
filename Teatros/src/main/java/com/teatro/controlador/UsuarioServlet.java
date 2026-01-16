package com.teatro.controlador;

import com.teatro.data.UsuarioDAO;
import com.teatro.modelo.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/listaUsuarios") 
public class UsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null || user.getRol() == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        UsuarioDAO udao = new UsuarioDAO();
        List<Usuario> lista = udao.getAll();
        
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("/WEB-INF/listaUsuarios.jsp").forward(request, response);
    }
}