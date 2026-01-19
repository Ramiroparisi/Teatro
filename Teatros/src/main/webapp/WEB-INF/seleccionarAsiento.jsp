<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.*, java.util.List" %>
<%
    Funcion funcion = (Funcion) request.getAttribute("funcion");
    Obra obra = (Obra) request.getAttribute("obra");
    List<Asiento> asientos = (List<Asiento>) request.getAttribute("asientos");

    int maxC = 0;
    if (asientos != null) {
        for(Asiento a : asientos) {
            if(a.getColCoord() > maxC) maxC = a.getColCoord();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Selección de Asientos - <%= obra.getNombre() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f8f9fa; }
        .grid-asientos { 
            display: grid; 
            grid-template-columns: repeat(<%= maxC %>, 35px); 
            gap: 8px; 
            justify-content: center;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .seat { 
            width: 35px; height: 35px; border-radius: 4px; 
            display: flex; align-items: center; justify-content: center; 
            font-size: 10px; font-weight: bold; cursor: pointer; transition: 0.2s;
        }
        .disponible { background-color: #27ae60; color: white; border: none; }
        .disponible:hover { background-color: #2ecc71; transform: scale(1.1); }
        .ocupado { background-color: #2d3436; color: #636e72; cursor: not-allowed; }
        .seleccionado { background-color: #3498db !important; transform: scale(1.1); box-shadow: 0 0 10px #3498db; }
        
        .escenario { 
            width: 80%; height: 15px; background: #34495e; 
            margin: 0 auto 30px; border-radius: 4px;
            color: white; font-size: 12px; text-transform: uppercase;
            letter-spacing: 2px;
        }

        .panel-fijo {
            position: sticky;
            top: 20px;
            background: white;
            padding: 25px;
            border-radius: 15px;
            border: 1px solid #dee2e6;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="text-center mb-4">
                <h2 class="fw-bold text-dark"><%= obra.getNombre() %></h2>
                <div class="escenario">Escenario</div>
            </div>

            <div class="grid-asientos mb-5">
                <% if (asientos != null) { 
                    for(Asiento a : asientos) { %>
                    <div id="asiento_<%= a.getId() %>" 
                         class="seat <%= a.isOcupado() ? "ocupado" : "disponible" %>"
                         title="Fila <%= a.getFilaNombre() %> Asiento <%= a.getNumero() %>"
                         onclick="<%= a.isOcupado() ? "" : "toggleAsiento(this, " + a.getId() + ")" %>">
                        <%= a.getFilaNombre() %><%= a.getNumero() %>
                    </div>
                <% } } %>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="panel-fijo">
                <h4 class="fw-bold mb-4 border-bottom pb-2">Resumen de Compra</h4>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">1. Cantidad de entradas</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-ticket-alt"></i></span>
                        <input type="number" id="inputMax" class="form-control form-control-lg" value="1" min="1" max="10" onchange="resetSeleccion()">
                    </div>
                    <div class="form-text mt-2">
                        Seleccionado: <span id="count" class="badge bg-primary">0</span> de <span id="limitDisplay">1</span>
                    </div>
                </div>

                <div class="bg-light p-3 rounded mb-4">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Precio Unitario:</span>
                        <span class="fw-bold">$<%= funcion.getPrecio() %></span>
                    </div>
                    <div class="d-flex justify-content-between border-top pt-2">
                        <span class="fs-5">Total:</span>
                        <span class="fs-5 fw-bold text-success">$<span id="total">0.00</span></span>
                    </div>
                </div>

                <form action="confirmarCompra" method="POST">
                    <input type="hidden" name="idFuncion" value="<%= funcion.getId() %>">
                    <input type="hidden" name="idsAsientos" id="idsAsientos">
                    
                    <button type="submit" id="btnConfirmar" class="btn btn-primary btn-lg w-100 shadow-sm" disabled>
                        <i class="fas fa-shopping-cart me-2"></i>Confirmar Compra
                    </button>
                </form>
                
                <p class="text-muted small mt-3 text-center">
                    <i class="fas fa-info-circle me-1"></i> Haga clic en las butacas para seleccionarlas.
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    let seleccionados = [];
    const precioUnidad = <%= funcion.getPrecio() %>;

    function toggleAsiento(elemento, id) {
        const maxEntradas = parseInt(document.getElementById('inputMax').value);

        if (seleccionados.includes(id)) {
            seleccionados = seleccionados.filter(item => item !== id);
            elemento.classList.remove('seleccionado');
        } else {
            if (seleccionados.length < maxEntradas) {
                seleccionados.push(id);
                elemento.classList.add('seleccionado');
            } else {
                alert("Has alcanzado el límite de " + maxEntradas + " entradas seleccionadas.");
            }
        }
        actualizarResumen();
    }

    function actualizarResumen() {
        const total = seleccionados.length * precioUnidad;
        document.getElementById('count').innerText = seleccionados.length;
        document.getElementById('total').innerText = total.toFixed(2);
        document.getElementById('idsAsientos').value = seleccionados.join(',');
        document.getElementById('btnConfirmar').disabled = (seleccionados.length === 0);
        document.getElementById('limitDisplay').innerText = document.getElementById('inputMax').value;
    }

    function resetSeleccion() {
        seleccionados = [];
        document.querySelectorAll('.seat.seleccionado').forEach(s => s.classList.remove('seleccionado'));
        actualizarResumen();
    }
</script>
</body>
</html>