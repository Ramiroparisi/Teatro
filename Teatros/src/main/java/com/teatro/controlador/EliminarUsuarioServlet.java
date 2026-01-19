package com.teatro.controlador;

import com.teatro.data.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/eliminarUsuario")
public class EliminarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        String status = "";

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("listaUsuarios");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            UsuarioDAO udao = new UsuarioDAO();

            if (udao.tieneCompras(id)) {
                status = "error_compras";
            } else {
                udao.delete(id);
                status = "success";
            }

        } catch (NumberFormatException e) {
            status = "invalid_id";
        } catch (SQLException e) {
            e.printStackTrace();
            status = "error_db";
        } catch (Exception e) {
            e.printStackTrace();
            status = "error_gen";
        }
        response.sendRedirect("listaUsuarios?status=" + status);
    }
}