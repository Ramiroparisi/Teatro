<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.*, java.util.List" %>
<%
    List<Asiento> seleccionados = (List<Asiento>) request.getAttribute("listaSeleccionados");
    Funcion funcion = (Funcion) session.getAttribute("funcion_pendiente");
    Double total = (Double) session.getAttribute("monto_total");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmar Pago</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://sdk.mercadopago.com/js/v2"></script>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0">Resumen Final de Compra</h4>
                </div>
                <div class="card-body p-4">
                    <h5>Detalles de la Función</h5>
                    <p class="text-muted mb-4">Fecha: <%= funcion.getFecha() %> | Hora: <%= funcion.getHora() %></p>
                    
                    <h6>Asientos seleccionados:</h6>
                    <ul class="list-group mb-4">
                        <% for(Asiento a : seleccionados) { %>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Fila <%= a.getFilaNombre() %> - Asiento <%= a.getNumero() %>
                                <span class="badge bg-secondary rounded-pill">$<%= funcion.getPrecio() %></span>
                            </li>
                        <% } %>
                    </ul>

                    <div class="d-flex justify-content-between align-items-center border-top pt-3 mb-4">
                        <span class="h4">Total a pagar:</span>
                        <span class="h3 text-success fw-bold">$<%= total %></span>
                    </div>

                    <div id="wallet_container"></div>

                    <div class="text-center mt-3">
                        <a href="seleccionarAsientos?funcionId=<%= funcion.getId() %>" class="text-muted small">
                            <i class="fas fa-arrow-left"></i> Volver y cambiar asientos
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    const mp = new MercadoPago('APP_USR-388cc432-bd05-489c-adfc-d75af58d751d', {
        locale: 'es-AR'
    });

    mp.bricks().create("wallet", "wallet_container", {
        initialization: {
            preferenceId: "PREFERENCE_ID_GENERADO", 
            redirectMode: "self"
        },
        customization: {
            texts: {
                valueProp: 'smart_option',
            },
        },
    });
</script>
</body>
</html>