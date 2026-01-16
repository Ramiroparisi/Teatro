package com.teatro.controlador;

import com.teatro.data.ObraDAO;
import com.teatro.data.TeatroDAO;
import com.teatro.modelo.Obra;
import com.teatro.modelo.Teatro;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/nuevaObra")
@MultipartConfig(maxFileSize = 16177215) 
public class NuevaObraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            TeatroDAO tdao = new TeatroDAO();
            List<Teatro> lista = tdao.getAll();
            request.setAttribute("listaTeatros", lista);
            
            request.getRequestDispatcher("/WEB-INF/nuevaObra.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener teatros");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            Obra o = new Obra();
            o.setNombre(request.getParameter("nombre"));
            o.setDescripcion(request.getParameter("descripcion"));
            o.setDuracion(Integer.parseInt(request.getParameter("duracion")));
            
            String tId = request.getParameter("teatroID");
            if (tId != null && !tId.isEmpty()) {
                o.setTeatroID(Integer.parseInt(tId));
            }

            String eId = request.getParameter("empleadoID");
            if (eId != null && !eId.isEmpty()) {
                o.setEmpleadoID(Integer.parseInt(eId));
            } else {
                o.setEmpleadoID(null);
            }

            Part filePart = request.getPart("foto");
            if (filePart != null && filePart.getSize() > 0) {
                o.setFoto(filePart.getInputStream());
            }

            ObraDAO odao = new ObraDAO();
            odao.add(o);
            
            response.sendRedirect("listaObras");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
}