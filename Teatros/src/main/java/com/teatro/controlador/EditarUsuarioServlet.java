package com.teatro.controlador;

import com.teatro.data.UsuarioDAO; 
import com.teatro.modelo.Usuario;
import com.teatro.modelo.RolUsuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/editarUsuario")
public class EditarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario admin = (Usuario) session.getAttribute("usuarioLogueado");
        if (admin == null || !admin.getRol().toString().equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            UsuarioDAO udao = new UsuarioDAO();
            Usuario u = udao.getByID(id); 
            
            if (u != null) {
                request.setAttribute("usuarioAEmitir", u);
                request.getRequestDispatcher("WEB-INF/Admin/editarUsuario.jsp").forward(request, response);
            } else {
                response.sendRedirect("listaUsuarios");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("listaUsuarios");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        UsuarioDAO udao = new UsuarioDAO();
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        Usuario usuarioOriginal = udao.getByID(id); 

        Usuario u = new Usuario();
        u.setId(id);
        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setMail(request.getParameter("mail"));
        u.setContrasena(request.getParameter("contrasena"));
        u.setTipoDoc(request.getParameter("tipoDoc"));
        u.setDocumento(request.getParameter("documento"));
        u.setTelefono(request.getParameter("telefono"));
        
        if (usuarioOriginal != null) {
            u.setContrasena(usuarioOriginal.getContrasena());
        }

        String rolStr = request.getParameter("rol");
        if (rolStr != null) u.setRol(RolUsuario.valueOf(rolStr.toLowerCase().trim()));

        String teatroIdStr = request.getParameter("teatroID");
        if (teatroIdStr != null && !teatroIdStr.isEmpty()) {
            u.setTeatroID(Integer.parseInt(teatroIdStr));
        }

        udao.put(u); 
        response.sendRedirect("listaUsuarios");
    }
}