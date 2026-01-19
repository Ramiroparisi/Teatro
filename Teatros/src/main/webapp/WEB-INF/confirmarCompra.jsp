<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.*, java.util.List" %>
<%
    List<Asiento> seleccionados = (List<Asiento>) request.getAttribute("asientosDetalle");
    Funcion funcion = (Funcion) session.getAttribute("funcion_actual");
    Double total = (Double) session.getAttribute("monto_total");
    String preferenceId = (String) session.getAttribute("preferenceId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmar Pago - Teatro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://sdk.mercadopago.com/js/v2"></script>
    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 15px; border: none; }
        .resumen-header { background-color: #007bff; color: white; border-radius: 15px 15px 0 0; padding: 20px; }
        #wallet_container { min-height: 50px; }
        .asiento-item { font-size: 0.95rem; }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow">
                <div class="resumen-header text-center">
                    <h4 class="mb-0">Resumen de Compra</h4>
                </div>
                <div class="card-body p-4">
                    <% if (funcion != null && seleccionados != null && preferenceId != null) { %>
                        
                        <div class="mb-4">
                            <label class="text-muted small text-uppercase fw-bold">Función</label>
                            <p class="h5 mb-1">Obra ID: #<%= funcion.getObraID() %></p>
                            <p class="text-secondary mb-0">
                                📅 <%= funcion.getFecha() %> | ⏰ <%= funcion.getHora().toString().substring(0,5) %> hs
                            </p>
                        </div>

                        <label class="text-muted small text-uppercase fw-bold">Ubicaciones</label>
                        <ul class="list-group list-group-flush mb-4">
                            <% for(Asiento a : seleccionados) { %>
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 asiento-item">
                                    <span>Fila <%= a.getFilaNombre() %> - Asiento <%= a.getNumero() %></span>
                                    <span class="fw-bold">$<%= funcion.getPrecio() %></span>
                                </li>
                            <% } %>
                        </ul>

                        <div class="d-flex justify-content-between align-items-center mb-4 pt-3 border-top">
                            <span class="h5 mb-0">Total</span>
                            <span class="h3 mb-0 text-primary fw-bold">$<%= total %></span>
                        </div>

                        <div id="wallet_container"></div>

                        <div class="text-center mt-4">
                            <a href="seleccionarAsientos?funcionId=<%= funcion.getId() %>" class="btn btn-link text-muted btn-sm text-decoration-none">
                                ← Volver y cambiar asientos
                            </a>
                        </div>

                    <% } else { %>
                        <div class="text-center py-4">
                            <p class="text-danger">La sesión de compra ha expirado o es inválida.</p>
                            <a href="inicio" class="btn btn-primary rounded-pill">Ir a Cartelera</a>
                        </div>
                    <% } %>
                </div>
            </div>
            
            <p class="text-center text-muted mt-4 small">
                Pago procesado de forma segura por Mercado Pago
            </p>
        </div>
    </div>
</div>

<script>
    const mp = new MercadoPago('TEST-c94d1f56-d317-446b-bd12-49cde491943f', {
        locale: 'es-AR'
    });

    mp.bricks().create("wallet", "wallet_container", {
        initialization: {
            preferenceId: '<%= preferenceId %>',
            redirectMode: "self" 
        },
        customization: {
            texts: {
                valueProp: 'smart_option',
                action: 'pay'
            },
            
            visual: {
                buttonBackground: 'default',
                borderRadius: '10px',
            },
            checkout: {
                theme: {
                    elementsColor: "#007bff",
                    headerColor: "#007bff",
                }
            }
        },
        callbacks: {
            onReady: () => {
                console.log("Wallet Brick listo para procesar pago.");
            },
            onError: (error) => {
                console.error("Error en el Brick de Pago:", error);
            }
        }
    });
</script>
</body>
</html>