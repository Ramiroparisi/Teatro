package com.teatro.controlador;

import com.teatro.data.EntradaDAO;
import com.teatro.modelo.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/finalizarPago")
public class FinalizarPagoServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        String idsAsientos = (String) session.getAttribute("asientos_seleccionados_ids");
        Funcion funcion = (Funcion) session.getAttribute("funcion_actual");
        String status = request.getParameter("status");

        if (status != null && status.equalsIgnoreCase("approved") && user != null && idsAsientos != null) {
            try {
                EntradaDAO edao = new EntradaDAO();
                String[] arrayIds = idsAsientos.split(",");

                for (String idAsientoStr : arrayIds) {
                    Entrada nueva = new Entrada();
                    nueva.setFuncionID(funcion.getId());
                    nueva.setAsientoID(Integer.parseInt(idAsientoStr.trim()));
                    nueva.setClienteID(user.getId());
                    nueva.setEstado(EstadoEntrada.Pagada); 

                    edao.registrarCompra(nueva);
                }
                session.removeAttribute("asientos_seleccionados_ids");
                session.removeAttribute("preferenceId");

                response.sendRedirect("misEntradas.jsp?exito=true");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp?msg=error_guardando_entrada");
            }
        } else {
            response.sendRedirect("seleccionarAsientos?funcionId=" + (funcion != null ? funcion.getId() : "") + "&error=pago_cancelado");
        }
    }
}