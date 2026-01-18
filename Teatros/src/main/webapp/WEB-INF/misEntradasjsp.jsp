<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.*, com.teatro.data.EntradaDAO, java.util.List" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    EntradaDAO edao = new EntradaDAO();
    // Este método debe retornar una lista de Entradas con datos de Obra y Asiento cargados
    List<Entrada> misTickets = edao.getEntradasPorUsuario(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mis Entradas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .ticket { border-left: 5px solid #3498db; background: white; padding: 20px; border-radius: 10px; margin-bottom: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .ticket-status { font-weight: bold; color: #27ae60; text-transform: uppercase; font-size: 0.8rem; }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="fw-bold mb-4"><i class="fas fa-ticket-alt me-2"></i>Mis Entradas</h2>
        
        <% if (misTickets == null || misTickets.isEmpty()) { %>
            <div class="alert alert-info">Aún no tienes entradas compradas. <a href="listaObras">¡Ver cartelera!</a></div>
        <% } else { %>
            <div class="row">
                <% for (Entrada t : misTickets) { %>
                <div class="col-md-6">
                    <div class="ticket d-flex justify-content-between align-items-center">
                        <div>
                            <span class="ticket-status">● Pagado</span>
                            <h5 class="mb-1 mt-1">Obra ID: <%= t.getFuncionID() %></h5> <p class="mb-0 text-muted small">
                                Asiento: <strong><%= t.getAsientoID() %></strong> | 
                                Fecha: <%= t.getEstado() %> </p>
                        </div>
                        <div class="text-end">
                            <i class="fas fa-qrcode fa-3x text-dark"></i>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>