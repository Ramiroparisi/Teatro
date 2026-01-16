package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.modelo.Obra;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/inicio")
public class InicioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ObraDAO odao = new ObraDAO();
        
        try {
            List<Obra> listaObras = odao.getAllWithFunciones();
            request.setAttribute("obrasCartelera", listaObras);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace(); 
            request.setAttribute("error", "Lo sentimos, la cartelera no está disponible en este momento.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}