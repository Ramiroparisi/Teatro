package com.teatro.controlador;

import com.teatro.data.AsientoDAO;
import com.teatro.data.FuncionDAO;
import com.teatro.modelo.Asiento;
import com.teatro.modelo.Funcion;
import com.teatro.modelo.Usuario;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.preference.PreferenceClient;

@WebServlet("/confirmarCompra")
public class ConfirmarCompraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

        if (user == null) {
            response.sendRedirect("login.jsp?error=sesion_expirada");
            return;
        }

        String idsAsientosStr = request.getParameter("idsAsientos");
        String idFuncionStr = request.getParameter("idFuncion");

        if (idsAsientosStr == null || idsAsientosStr.isEmpty() || idFuncionStr == null) {
            response.sendRedirect("listaObras");
            return;
        }

        try {
            int idFuncion = Integer.parseInt(idFuncionStr);
            FuncionDAO fdao = new FuncionDAO();
            Funcion funcion = fdao.getByID(idFuncion);
            AsientoDAO adao = new AsientoDAO();
            List<Asiento> listaAsientos = new ArrayList<>();
            String[] arrayIds = idsAsientosStr.split(",");

            for (String idStr : arrayIds) {
                if (!idStr.trim().isEmpty()) {
                    Asiento a = adao.getById(Integer.parseInt(idStr.trim()));
                    if (a != null) {
                        listaAsientos.add(a);
                    }
                }
            }

            double precioUnidad = funcion.getPrecio().doubleValue();
            double totalPagar = precioUnidad * listaAsientos.size();
            session.setAttribute("asientos_seleccionados_ids", idsAsientosStr);
            session.setAttribute("funcion_actual", funcion);
            session.setAttribute("monto_total", totalPagar);
            request.setAttribute("asientosDetalle", listaAsientos);
            request.setAttribute("total", totalPagar);
            
            request.getRequestDispatcher("/prepararPago").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("seleccionarAsientos?funcionId=" + idFuncionStr + "&error=procesamiento");
        }
    }
}