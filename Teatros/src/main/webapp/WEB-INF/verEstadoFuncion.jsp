<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.*, java.util.List" %>
<%
    Funcion funcion = (Funcion) request.getAttribute("funcion");
    Obra obra = (Obra) request.getAttribute("obra");
    List<Asiento> asientos = (List<Asiento>) request.getAttribute("asientos");

    int maxF = 0, maxC = 0;
    if (asientos != null) {
        for(Asiento a : asientos) {
            if(a.getFilaCoord() > maxF) maxF = a.getFilaCoord();
            if(a.getColCoord() > maxC) maxC = a.getColCoord();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Estado de Función - <%= (obra != null) ? obra.getNombre() : "" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .grid { 
            display: grid; 
            /* La cantidad de columnas depende del teatro */
            grid-template-columns: repeat(<%= (maxC > 0) ? maxC : 1 %>, 38px); 
            gap: 7px; justify-content: center; padding: 20px;
        }
        .seat { 
            width: 38px; height: 38px; border-radius: 6px; 
            display: flex; align-items: center; justify-content: center;
            font-size: 10px; font-weight: bold; color: white;
        }
		.disponible { 
    		background-color: #27ae60; /* Verde */
		} 
		.ocupado { 
    		background-color: #2d3436; /* Gris Oscuro */
    		color: #b2bec3; /* Texto gris claro para que se lea */
		}
        
        .pasillo { width: 38px; height: 38px; }
        .escenario { 
            width: 70%; max-width: 500px; height: 30px; background: #34495e; 
            color: white; margin: 20px auto; text-align: center; line-height: 30px; 
            border-radius: 0 0 15px 15px; font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="card shadow border-0 p-4">
        <h2 class="text-center text-dark"><%= (obra != null) ? obra.getNombre() : "Mapa de Sala" %></h2>
        <p class="text-center text-muted">Estado actual de ocupación</p>

        <div class="escenario">ESCENARIO</div>

        <div class="grid">
            <% 
            if(asientos != null && !asientos.isEmpty()) {
                for(int f=1; f<=maxF; f++) { 
                    for(int c=1; c<=maxC; c++) {
                        Asiento actual = null;
                        for(Asiento a : asientos) {
                            if(a.getFilaCoord() == f && a.getColCoord() == c) { 
                                actual = a; 
                                break; 
                            }
                        }
                        
                        if(actual != null) { %>
                            <div class="seat <%= actual.isOcupado() ? "ocupado" : "disponible" %>" 
                                 title="Fila <%= actual.getFilaNombre() %> - Asiento <%= actual.getNumero() %>">
                                <%= actual.getFilaNombre() %><%= actual.getNumero() %>
                            </div>
                        <% } else { %>
                            <div class="pasillo"></div>
                        <% } 
                    }
                }
            } else { %>
                <div class="alert alert-warning text-center w-100">
                    No hay asientos configurados para este teatro. <br>
                    Por favor, ve a <strong>Gestión de Teatros > Plano</strong> para crearlos.
                </div>
            <% } %>
        </div>

        <div class="mt-4 d-flex justify-content-center gap-4">
            <div><span class="badge" style="background:#27ae60"> </span> Disponible</div>
            <div><span class="badge" style="background:#2d3436"> </span> Ocupado</div>
        </div>

        <div class="text-center mt-5">
            <a href="listaObras" class="btn btn-outline-secondary px-4">Volver a Obras</a>
        </div>
    </div>
</div>
</body>
</html>