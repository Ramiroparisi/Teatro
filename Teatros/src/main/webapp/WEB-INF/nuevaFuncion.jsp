<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Obra" %>
<%@ page import="com.teatro.modelo.Teatro" %>
<%@ page import="java.util.List" %>
<%
    List<Obra> obras = (List<Obra>) request.getAttribute("listaObras");
    List<Teatro> teatros = (List<Teatro>) request.getAttribute("listaTeatros");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Función - Panel de Administración</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; padding: 40px; }
        .form-card { background: white; padding: 30px; border-radius: 12px; max-width: 550px; margin: auto; box-shadow: 0 8px 24px rgba(0,0,0,0.1); }
        h2 { color: #1a73e8; margin-top: 0; border-bottom: 2px solid #e8f0fe; padding-bottom: 10px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        select, input { width: 100%; padding: 12px; border: 1px solid #dadce0; border-radius: 6px; box-sizing: border-box; font-size: 15px; }
        select:focus, input:focus { border-color: #1a73e8; outline: none; box-shadow: 0 0 0 2px rgba(26,115,232,0.2); }
        .btn-submit { background-color: #1a73e8; color: white; border: none; padding: 14px; width: 100%; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; transition: background 0.2s; }
        .btn-submit:hover { background-color: #1557b0; }
        .error-banner { background-color: #fce8e6; color: #d93025; padding: 12px; border-radius: 6px; margin-bottom: 20px; font-size: 14px; border: 1px solid #fad2cf; }
        .back-link { display: block; text-align: center; margin-top: 20px; color: #5f6368; text-decoration: none; font-size: 14px; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="form-card">
    <h2>📅 Programar Función</h2>

    <% if (error != null) { %>
        <div class="error-banner">
            <strong>Error:</strong> <%= error %>
        </div>
    <% } %>

    <form action="nuevaFuncion" method="POST">
        
        <div class="form-group">
            <label for="idObra">Obra Teatral</label>
            <select name="idObra" id="idObra" required>
                <option value="">-- Seleccione una obra --</option>
                <% if (obras != null) { 
                    for (Obra o : obras) { %>
                        <option value="<%= o.getId() %>"><%= o.getNombre() %> (ID: <%= o.getId() %>)</option>
                <% } } %>
            </select>
        </div>

        <div class="form-group">
            <label for="idTeatro">Teatro / Sede</label>
            <select name="idTeatro" id="idTeatro" required>
                <option value="">-- Seleccione un teatro --</option>
                <% if (teatros != null) { 
                    for (Teatro t : teatros) { %>
                        <option value="<%= t.getId() %>"><%= t.getNombre() %> (ID: <%= t.getId() %>)</option>
                <% } } %>
            </select>
        </div>

        <div class="form-group">
            <label for="fechaHora">Fecha y Hora de inicio</label>
            <input type="datetime-local" name="fechaHora" id="fechaHora" required>
        </div>

        <div class="form-group">
            <label for="precio">Precio de la Entrada ($)</label>
            <input type="number" name="precio" id="precio" step="0.01" min="0" placeholder="Ej: 1500.50" required>
        </div>

        <button type="submit" class="btn-submit">Crear Función</button>
        
        <a href="listaObras" class="back-link">← Volver a la lista de obras</a>
    </form>
</div>

</body>
</html>