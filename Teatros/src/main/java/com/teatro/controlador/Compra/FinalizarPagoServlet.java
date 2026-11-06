package com.teatro.controlador.Compra;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.payment.PaymentClient;
import com.mercadopago.resources.payment.Payment;
import com.teatro.data.EntradaDAO;
import com.teatro.modelo.Entrada;
import com.teatro.modelo.EstadoEntrada;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/finalizarPago")
public class FinalizarPagoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setStatus(HttpServletResponse.SC_OK);

        try {
            String mpToken = System.getenv("MP_ACCESS_TOKEN");
            
            if (mpToken == null || mpToken.trim().isEmpty()) {
                System.err.println("Error Crítico Webhook: La variable de entorno MP_ACCESS_TOKEN no está configurada.");
                return; 
            }
            
            MercadoPagoConfig.setAccessToken(mpToken);

            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String jsonPayload = sb.toString();

            Pattern pattern = Pattern.compile("\"data\"\\s*:\\s*\\{\\s*\"id\"\\s*:\\s*\"?(\\d+)\"?\\s*\\}");
            Matcher matcher = pattern.matcher(jsonPayload);
            
            String idPagoStr = null;
            if (matcher.find()) {
                idPagoStr = matcher.group(1);
            } else {
                idPagoStr = request.getParameter("data.id");
            }

            if (idPagoStr != null) {
                PaymentClient client = new PaymentClient();
                Payment payment = client.get(Long.parseLong(idPagoStr));

                if (payment != null && "approved".equalsIgnoreCase(payment.getStatus())) {
                    
                    String externalRef = payment.getExternalReference();
                    if (externalRef != null && externalRef.contains("_")) {
                        String[] partes = externalRef.split("_");
                        int idUsuario = Integer.parseInt(partes[0]);
                        int idFuncion = Integer.parseInt(partes[1]);
                        String[] asientosArray = partes[2].split(",");

                        EntradaDAO edao = new EntradaDAO();

                        for (String idAsientoStr : asientosArray) {
                            String idLimpio = idAsientoStr.trim();
                            if (!idLimpio.isEmpty()) {
                                Entrada nueva = new Entrada();
                                nueva.setFuncionID(idFuncion);
                                nueva.setAsientoID(Integer.parseInt(idLimpio));
                                nueva.setClienteID(idUsuario);
                                nueva.setEstado(EstadoEntrada.Pagada);
                                
                                edao.registrarCompra(nueva);
                            }
                        }
                        System.out.println("Webhook procesado exitosamente: Entradas registradas para el usuario " + idUsuario);
                    }
                } else {
                    System.out.println("Webhook recibido pero el pago no está aprobado o no existe. ID: " + idPagoStr);
                }
            }

        } catch (Exception e) {
            System.err.println("Error procesando el Webhook de Mercado Pago:");
            e.printStackTrace();
        }
    }
}