package com.teatro.controlador;

import com.teatro.data.FuncionDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/eliminarFuncion")
public class EliminarFuncionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        String status = "";

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("listaObras");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            FuncionDAO fdao = new FuncionDAO();

            if (fdao.tieneEntradasVendidas(id)) {
                status = "error_entradas";
            } else {
                fdao.delete(id);
                status = "success_delete_funcion";
            }

        } catch (NumberFormatException e) {
            status = "invalid_id";
        } catch (SQLException e) {
            e.printStackTrace();
            status = "error_db";
        }

        response.sendRedirect("listaObras?status=" + status);
    }
}