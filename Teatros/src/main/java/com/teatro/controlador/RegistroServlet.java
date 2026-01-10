package com.teatro.controlador;

import com.teatro.data.UsuarioDAO;
import com.teatro.modelo.Usuario;
import com.teatro.modelo.RolUsuario;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        Usuario u = new Usuario();
        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setMail(request.getParameter("email"));
        u.setDocumento(request.getParameter("documento"));
        u.setContrasena(request.getParameter("pass"));
        u.setTipoDoc("DNI");
        u.setRol(RolUsuario.cliente); 
        u.setTeatroID(null);

        UsuarioDAO udao = new UsuarioDAO();
        try {
            udao.add(u);
            response.sendRedirect("login.jsp?success=reg");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("usuarioFallido", u); 
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
    }
}