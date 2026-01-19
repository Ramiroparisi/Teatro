package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.modelo.Obra;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/editarObra")
@MultipartConfig(maxFileSize = 16177215)
public class EditarObraServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ObraDAO odao = new ObraDAO();
            Obra obra = odao.getByID(id);
            
            if (obra != null) {
                request.setAttribute("obra", obra);
                request.getRequestDispatcher("/WEB-INF/editarObra.jsp").forward(request, response);
            } else {
                response.sendRedirect("listaObras?status=not_found");
            }
        } catch (Exception e) {
            response.sendRedirect("listaObras?status=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            int duracion = Integer.parseInt(request.getParameter("duracion"));
            int teatroID = Integer.parseInt(request.getParameter("teatroID"));

            ObraDAO odao = new ObraDAO();
            Obra obra = odao.getByID(id); 
            
            obra.setNombre(nombre);
            obra.setDescripcion(descripcion);
            obra.setDuracion(duracion);
            obra.setTeatroID(teatroID);

            Part filePart = request.getPart("foto");
            if (filePart != null && filePart.getSize() > 0) {
                obra.setFoto(filePart.getInputStream());
            }

            odao.update(obra);
            response.sendRedirect("listaObras?status=updated");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("listaObras?status=error_update");
        }
    }
}