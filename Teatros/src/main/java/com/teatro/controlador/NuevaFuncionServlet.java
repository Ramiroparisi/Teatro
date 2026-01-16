package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.data.TeatroDAO;
import com.teatro.data.FuncionDAO;
import com.teatro.modelo.Funcion;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/nuevaFuncion")
public class NuevaFuncionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ObraDAO odao = new ObraDAO();
            request.setAttribute("listaObras", odao.getAllWithFunciones()); 
            
            request.setAttribute("listaTeatros", new TeatroDAO().getAll());
            request.getRequestDispatcher("/WEB-INF/nuevaFuncion.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Error de base de datos al cargar el formulario");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            Funcion f = new Funcion();
            f.setObraID(Integer.parseInt(request.getParameter("idObra")));
            f.setPrecio(new BigDecimal(request.getParameter("precio")));

            String fechaHoraRaw = request.getParameter("fechaHora");
            if (fechaHoraRaw != null && !fechaHoraRaw.isEmpty()) {
                LocalDateTime ldt = LocalDateTime.parse(fechaHoraRaw);
                f.setFecha(Date.valueOf(ldt.toLocalDate()));
                f.setHora(Time.valueOf(ldt.toLocalTime()));
            }

            new FuncionDAO().add(f);
            response.sendRedirect("listaObras"); 
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al crear función: " + e.getMessage());
            doGet(request, response);
        }
    }
}