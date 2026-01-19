package com.teatro.controlador;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.preference.*;
import com.mercadopago.resources.preference.Preference;
import com.teatro.modelo.Funcion;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/prepararPago")
public class PrepararPagoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        MercadoPagoConfig.setAccessToken("TEST-2136096941352102-011819-c00a9cd50479f814c1b73a523c597802-588563969");

        Funcion funcion = (Funcion) session.getAttribute("funcion_actual");
        Double total = (Double) session.getAttribute("monto_total");
        String idsAsientos = (String) session.getAttribute("asientos_seleccionados_ids");

        if (funcion == null || total == null) {
            response.sendRedirect("listaObras");
            return;
        }

        try {
            PreferenceClient client = new PreferenceClient();
            PreferenceItemRequest item = PreferenceItemRequest.builder()
                    .id("FUNC-" + funcion.getId())
                    .title("Entradas Teatro - Función #" + funcion.getId())
                    .description("Asientos: " + idsAsientos)
                    .quantity(1)
                    .currencyId("ARS")
                    .unitPrice(new BigDecimal(total).setScale(2, RoundingMode.HALF_UP))
                    .build();

            List<PreferenceItemRequest> items = new ArrayList<>();
            items.add(item);

            String urlSuccess = "http://localhost:8080/Teatros/finalizarPago";
            String urlFailure = "http://localhost:8080/Teatros/seleccionarAsientos?funcionId=" + funcion.getId();
            String urlPending = "http://localhost:8080/Teatros/misEntradas";

            PreferenceBackUrlsRequest backUrls = PreferenceBackUrlsRequest.builder()
                    .success(urlSuccess)
                    .failure(urlFailure)
                    .pending(urlPending)
                    .build();

            PreferenceRequest preferenceRequest = PreferenceRequest.builder()
                    .items(items)
                    .backUrls(backUrls) 
                   // .autoReturn("approved")
                    .binaryMode(true)
                    .build();

            Preference preference = client.create(preferenceRequest);
            session.setAttribute("preferenceId", preference.getId());

            request.getRequestDispatcher("/WEB-INF/confirmarCompra.jsp").forward(request, response);

        } catch (com.mercadopago.exceptions.MPApiException apiEx) {
            System.err.println("Error API Mercado Pago: " + apiEx.getApiResponse().getContent());
            response.sendRedirect("seleccionarAsientos?funcionId=" + funcion.getId() + "&error=mp_api");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("seleccionarAsientos?funcionId=" + funcion.getId() + "&error=generico");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}