package com.teatro.controlador.Compra;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.preference.*;
import com.mercadopago.resources.preference.Preference;
import com.teatro.modelo.Funcion;
import com.teatro.modelo.Usuario;
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
        
        String mpToken = System.getenv("MP_ACCESS_TOKEN");
        
        if (mpToken == null || mpToken.trim().isEmpty()) {
            System.err.println("Error Crítico: La variable de entorno MP_ACCESS_TOKEN no está configurada.");
            response.sendRedirect("listaObras?error=config_pagos");
            return;
        }
        
        MercadoPagoConfig.setAccessToken(mpToken);

        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        Funcion funcion = (Funcion) session.getAttribute("funcion_actual");
        Double total = (Double) session.getAttribute("monto_total");
        String idsAsientos = (String) session.getAttribute("asientos_seleccionados_ids");

        if (user == null || funcion == null || total == null) {
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

            String baseUrl = "https://morally-scooter-chirpy.ngrok-free.dev/Teatros";
            
            String urlSuccess = baseUrl + "/misEntradas?exito=true";
            String urlFailure = baseUrl + "/seleccionarAsientos?funcionId=" + funcion.getId() + "&error=pago_rechazado";
            String urlPending = baseUrl + "/misEntradas?pendiente=true";

            PreferenceBackUrlsRequest backUrls = PreferenceBackUrlsRequest.builder()
                    .success(urlSuccess)
                    .failure(urlFailure)
                    .pending(urlPending)
                    .build();

            String externalRef = user.getId() + "_" + funcion.getId() + "_" + idsAsientos;

            PreferenceRequest preferenceRequest = PreferenceRequest.builder()
                    .items(items)
                    .backUrls(backUrls) 
                    .autoReturn("approved")
                    .notificationUrl(baseUrl + "/finalizarPago")
                    .externalReference(externalRef) 
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