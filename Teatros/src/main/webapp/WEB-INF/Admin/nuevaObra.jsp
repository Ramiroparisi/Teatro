<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Teatro" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nueva Obra | Panel Admin</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f0f2f5; padding: 30px; }
        .card { background: white; padding: 25px; border-radius: 10px; max-width: 500px; margin: auto; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { border-bottom: 2px solid #007bff; padding-bottom: 10px; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; color: #555; }
        input, select, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .btn-submit { background: #28a745; color: white; border: none; padding: 12px; width: 100%; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 10px; }
        .btn-submit:hover { background: #218838; }
        .error { color: #721c24; background: #f8d7da; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
    </style>
</head>
<body>

<div class="card">
    <h2>🎭 Registrar Obra</h2>

    <% if(request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="nuevaObra" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label>Seleccionar Teatro (Sede)</label>
            <select name="teatroID" required>
                <option value="">-- Elija un teatro --</option>
                <% 
                    List<Teatro> teatros = (List<Teatro>) request.getAttribute("listaTeatros");
                    if(teatros != null) {
                        for(Teatro t : teatros) {
                %>
                    <option value="<%= t.getId() %>">ID: <%= t.getId() %> - <%= t.getNombre() %></option>
                <%      }
                    } 
                %>
            </select>
        </div>

        <div class="form-group">
            <label>Nombre de la Obra</label>
            <input type="text" name="nombre" required placeholder="Ej: Los Miserables">
        </div>

        <div class="form-group">
            <label>Duración (en minutos)</label>
            <input type="number" name="duracion" required placeholder="120">
        </div>

        <div class="form-group">
            <label>Imagen de Portada</label>
            <input type="file" name="foto" accept="image/*">
        </div>

        <div class="form-group">
            <label>ID Empleado Responsable (Opcional)</label>
            <input type="number" name="empleadoID" placeholder="Dejar vacío si no aplica">
        </div>

        <div class="form-group">
            <label>Descripción / Sinopsis</label>
            <textarea name="descripcion" rows="3" placeholder="Breve resumen de la trama..."></textarea>
        </div>

        <button type="submit" class="btn-submit">Guardar Obra</button>
        <div style="text-align: center; margin-top: 15px;">
            <a href="listaObras" style="color: #666; text-decoration: none; font-size: 14px;">← Cancelar y volver</a>
        </div>
    </form>
</div>

</body>
</html>