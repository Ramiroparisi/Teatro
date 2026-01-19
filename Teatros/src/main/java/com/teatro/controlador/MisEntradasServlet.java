package com.teatro.controlador;

import com.teatro.data.EntradaDAO;
import com.teatro.modelo.Entrada;
import com.teatro.modelo.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/misEntradas")
public class MisEntradasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null) {
            response.sendRedirect("login.jsp?error=sesion_expirada");
            return;
        }

        try {
            EntradaDAO edao = new EntradaDAO();
            List<Entrada> lista = edao.getEntradasDetalladasPorUsuario(user.getId());
            
            request.setAttribute("misTickets", lista);
            request.getRequestDispatcher("/WEB-INF/misEntradas.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h2>Error al recuperar tus entradas</h2>");
            response.getWriter().println("<p>" + e.getMessage() + "</p>");
        }
    }
}