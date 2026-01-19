package com.teatro.controlador;

import com.teatro.data.EntradaDAO;
import com.teatro.modelo.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/finalizarPago")
public class FinalizarPagoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        String idsAsientos = (String) session.getAttribute("asientos_seleccionados_ids");
        Funcion funcion = (Funcion) session.getAttribute("funcion_actual");
        
        String status = request.getParameter("status"); 
        String collectionStatus = request.getParameter("collection_status");

        boolean esAprobado = "approved".equalsIgnoreCase(status) || "approved".equalsIgnoreCase(collectionStatus);

        System.out.println("Finalizando Pago - Status: " + status + " | User: " + (user != null ? user.getNombre() : "null"));

        if (esAprobado && user != null && idsAsientos != null && funcion != null) {
            try {
                EntradaDAO edao = new EntradaDAO();
                String[] arrayIds = idsAsientos.split(",");

                for (String idAsientoStr : arrayIds) {
                    String idLimpio = idAsientoStr.trim();
                    if (!idLimpio.isEmpty()) {
                        Entrada nueva = new Entrada();
                        nueva.setFuncionID(funcion.getId());
                        nueva.setAsientoID(Integer.parseInt(idLimpio));
                        nueva.setClienteID(user.getId());
                        nueva.setEstado(EstadoEntrada.Pagada); 
                        edao.registrarCompra(nueva);
                    }
                }
                
                session.removeAttribute("asientos_seleccionados_ids");
                session.removeAttribute("monto_total");
                session.removeAttribute("preferenceId");
                
                response.sendRedirect("misEntradas?exito=true");

            } catch (Exception e) {
                System.err.println("Error crítico en el guardado de base de datos:");
                e.printStackTrace(); 
                response.sendRedirect("seleccionarAsientos?funcionId=" + funcion.getId() + "&error=db_finalizar");
            }
        } else {
            int fId = (funcion != null) ? funcion.getId() : 0;
            response.sendRedirect("seleccionarAsientos?funcionId=" + fId + "&error=pago_incompleto");
        }
    }
}