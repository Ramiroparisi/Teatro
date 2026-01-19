package com.teatro.controlador;

import com.teatro.data.TeatroDAO;
import com.teatro.modelo.Teatro;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/nuevoTeatro")
public class NuevoTeatroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Admin/nuevoTeatro.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String pais = request.getParameter("pais");
        String ciudad = request.getParameter("ciudad");
        int capacidad = Integer.parseInt(request.getParameter("capacidad"));
        Teatro nuevoTeatro = new Teatro(nombre, direccion, pais, ciudad, capacidad);
        TeatroDAO tdao = new TeatroDAO();
        try {
            tdao.add(nuevoTeatro);
            response.sendRedirect("listaTeatros");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al guardar el teatro");
        }
    }
}