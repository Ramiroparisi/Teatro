package com.teatro.controlador;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.preference.*;
import com.mercadopago.resources.preference.Preference;
import com.teatro.modelo.Funcion;
import com.teatro.modelo.Usuario;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/prepararPago")
public class PrepararPagoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. CONFIGURACIÓN DE CREDENCIALES
        // Reemplaza "PROD_ACCESS_TOKEN" por tu Access Token de Mercado Pago (empieza con APP_USR-...)
        MercadoPagoConfig.setAccessToken("TU_ACCESS_TOKEN_AQUÍ");

        // 2. RECUPERAR DATOS DE LA SESIÓN (guardados por ConfirmarCompraServlet)
        Funcion funcion = (Funcion) session.getAttribute("funcion_actual");
        Double total = (Double) session.getAttribute("monto_total");
        String idsAsientos = (String) session.getAttribute("asientos_seleccionados_ids");

        if (funcion == null || total == null) {
            response.sendRedirect("listaObras");
            return;
        }

        try {
            // 3. CREAR LA PREFERENCIA DE PAGO
            PreferenceClient client = new PreferenceClient();

            // Configuramos el ítem (lo que el usuario verá en el ticket de MP)
            PreferenceItemRequest item = PreferenceItemRequest.builder()
                    .id(String.valueOf(funcion.getId()))
                    .title("Entradas de Teatro - Función #" + funcion.getId())
                    .description("Asientos seleccionados: " + idsAsientos)
                    .quantity(1)
                    .currencyId("ARS") // O tu moneda local
                    .unitPrice(new BigDecimal(total))
                    .build();

            List<PreferenceItemRequest> items = new ArrayList<>();
            items.add(item);

            // 4. CONFIGURAR BACK URLS (Retorno automático tras pagar)
            // Importante: Aquí es donde MP devuelve al usuario para que grabes en la DB
            PreferenceBackUrlsRequest backUrls = PreferenceBackUrlsRequest.builder()
                    .success("http://localhost:8080/Teatros/finalizarPago") // Tu Servlet de éxito
                    .pending("http://localhost:8080/Teatros/misEntradas")
                    .failure("http://localhost:8080/Teatros/seleccionarAsientos?funcionId=" + funcion.getId())
                    .build();

            PreferenceRequest preferenceRequest = PreferenceRequest.builder()
                    .items(items)
                    .backUrls(backUrls)
                    .autoReturn("approved") // Vuelve solo si el pago se aprobó
                    .build();

            // 5. GENERAR PREFERENCIA
            Preference preference = client.create(preferenceRequest);

            // 6. GUARDAR EL ID PARA EL JSP Y REDIRIGIR
            session.setAttribute("preferenceId", preference.getId());
            response.sendRedirect("confirmarCompra.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("confirmarCompra.jsp?error=mp_api");
        }
    }
}