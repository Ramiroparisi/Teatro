package com.teatro.controlador;

import com.teatro.data.UsuarioDAO;
import com.teatro.modelo.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
		request.setCharacterEncoding("UTF-8");
		
	    String identificador = request.getParameter("txtUsuario");
	    String pass = request.getParameter("txtPassword");
	    
	    UsuarioDAO udao = new UsuarioDAO();
	    Usuario u = udao.login(identificador, pass);
	    
	    if (u != null) {
	        HttpSession session = request.getSession();
	        session.setAttribute("usuarioLogueado", u);
	        
	        if (u.getRol() != null && u.getRol().toString().equalsIgnoreCase("admin")) {
	            response.sendRedirect("adminDashboard.jsp");
	        } 
	        else  if (u.getRol() != null && u.getRol().toString().equalsIgnoreCase("cliente")) { 
	            response.sendRedirect("index.jsp");
	        }
	        
	    } else {
	        request.setAttribute("error", "Credenciales incorrectas.");
	        request.getRequestDispatcher("login.jsp").forward(request, response);
	    }
	}
}