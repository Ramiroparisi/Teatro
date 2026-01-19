<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.*, java.util.List, java.text.SimpleDateFormat" %>
<%
    List<Entrada> misTickets = (List<Entrada>) request.getAttribute("misTickets");
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    
    if (user == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Entradas | Teatro Central</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        .ticket {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            display: flex;
            margin-bottom: 30px;
            overflow: hidden;
            border: none;
            transition: transform 0.3s;
        }
        .ticket:hover { transform: scale(1.02); }

        .ticket-main {
            padding: 25px;
            flex: 3;
            border-right: 2px dashed #e0e0e0;
            position: relative;
        }

        .ticket-stub {
            padding: 25px;
            flex: 1;
            background-color: #2c3e50;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .obra-titulo {
            color: #1a1a1a;
            font-size: 1.5rem;
            font-weight: 800;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .label {
            font-size: 0.7rem;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 2px;
        }

        .value {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }

        .status-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 0.75rem;
            padding: 5px 12px;
            border-radius: 20px;
        }

        .qr-placeholder {
            font-size: 3.5rem;
            margin-bottom: 10px;
        }

        .ticket-main::before, .ticket-main::after {
            content: '';
            position: absolute;
            right: -10px;
            width: 20px;
            height: 20px;
            background-color: #f0f2f5;
            border-radius: 50%;
        }
        .ticket-main::before { top: -10px; }
        .ticket-main::after { bottom: -10px; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row mb-5 align-items-center">
        <div class="col-md-6">
            <h1 class="fw-bold m-0 text-primary">Mis Entradas</h1>
            <p class="text-muted">Hola, <%= user.getNombre() %>. Aquí tienes tus accesos para las próximas funciones.</p>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="inicio" class="btn btn-outline-primary rounded-pill px-4">Volver a Cartelera</a>
        </div>
    </div>

    <% if (misTickets == null || misTickets.isEmpty()) { %>
        <div class="card text-center p-5 border-0 shadow-sm">
            <div class="display-1 text-muted mb-4">🎫</div>
            <h3 class="text-secondary">Aún no tienes tickets</h3>
            <p class="mb-4">Tus próximas compras aparecerán aquí.</p>
            <div>
                <a href="inicio" class="btn btn-primary btn-lg px-5 rounded-pill">Explorar Obras</a>
            </div>
        </div>
    <% } else { %>
        <div class="row">
            <% for (Entrada t : misTickets) { %>
            <div class="col-xl-6">
                <div class="ticket">
                    <div class="ticket-main">
                        <span class="badge bg-success status-badge">
                            <%= t.getEstado() != null ? t.getEstado() : "CONFIRMADO" %>
                        </span>
                        
                        <div class="obra-titulo">
                            <%= t.getNombreObra() != null ? t.getNombreObra() : "Obra #" + t.getFuncionID() %>
                        </div>
                        
                        <div class="row mt-4">
<% 

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
    String fechaFormateada = (t.getFecha() != null) ? sdf.format(t.getFecha()) : "Sin fecha";
%>
                            <div class="col-6">
                                <div class="label">Fecha de Función</div>
                                <div class="value">📅 <%= fechaFormateada %></div>
                            </div>
                            <div class="col-6">
                                <div class="label">Horario</div>
                                <div class="value">⏰ <%= t.getHora() != null ? t.getHora().toString().substring(0, 5) : "00:00" %> hs</div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-4">
                                <div class="label">Fila</div>
                                <div class="value">💺 <%= t.getFilaNombre() != null ? t.getFilaNombre() : "-" %></div>
                            </div>
                            <div class="col-4">
                                <div class="label">Asiento</div>
                                <div class="value">#<%= t.getAsientoNum() > 0 ? t.getAsientoNum() : t.getAsientoID() %></div>
                            </div>
                            <div class="col-4 text-end">
                                <div class="label">Ticket ID</div>
                                <div class="value text-muted">#<%= t.getId() %></div>
                            </div>
                        </div>
                    </div>

                    <div class="ticket-stub">
                        <div class="qr-placeholder">🔳</div>
                        <div class="small fw-bold">SCAN QR</div>
                        <div class="mt-3 small" style="opacity: 0.7;">Presentar este código en la entrada</div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>