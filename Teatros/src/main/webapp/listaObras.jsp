<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.teatro.modelo.Obra" %>
<%@ page import="com.teatro.modelo.Usuario" %>
<%@ page import="com.teatro.modelo.RolUsuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Obras - Admin</title>
   	<link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }
		.header { display: flex; justify-content: space-between; align-items: center; background: #333; color: white; padding: 15px 30px; border-radius: 8px;}
		.header-actions {display: flex; gap: 15px;}
        .btn-add { background: green; color: white; text-decoration: none; padding: 10px 15px; border-radius: 5px; font-weight: bold; }
        .btn-back { background: red; color: white; text-decoration: none; padding: 10px 15px; border-radius: 5px; font-weight: bold; }
        .grid-obras { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-top: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); padding: 20px; border-top: 5px solid #007bff; }
        .card h3 { margin-top: 0; color: #333; }
        .info { color: #666; font-size: 0.9em; margin-bottom: 10px; }
        .actions { margin-top: 15px; padding-top: 10px; border-top: 1px solid #eee; }
        .actions a { text-decoration: none; color: #007bff; font-weight: bold; margin-right: 15px; }
        .no-data { text-align: center; padding: 50px; color: #888; }
    </style>
</head>
<body>

<div class="header">
    <h1>Administración de Obras</h1>
    
    <div class="header-actions">
        <a href="nuevaObra.jsp" class="btn-add">+ Cargar Nueva Obra</a>
        <a href="adminDashboard.jsp" class="btn-back">Volver</a>
    </div>
</div>

    <div class="grid-obras">
        <% 
            List<Obra> lista = (List<Obra>) request.getAttribute("listaObras"); 
            
            if (lista != null && !lista.isEmpty()) {
                for (Obra obra : lista) { 
        %>
            <div class="card">
                <h3><%= obra.getNombre() %></h3>
                <div class="info">
                    <strong>ID:</strong> <%= obra.getId() %> | 
                    <strong>Duración:</strong> <%= obra.getDuracion() %> min.
                </div>
                <p><%= (obra.getDescripcion() != null) ? obra.getDescripcion() : "Sin descripción disponible." %></p>
                
                <div class="actions">
                    <a href="funciones?obraId=<%= obra.getId() %>">📅 Ver Funciones</a>
                    <a href="editarObra?id=<%= obra.getId() %>">✏️ Editar</a>
                    <a href="eliminarObra?id=<%= obra.getId() %>" style="color:red;" onclick="return confirm('¿Seguro?')">🗑️ Borrar</a>
                </div>
            </div>
        <% 
                } 
            } else { 
        %>
            </div> <div class="no-data">
                <h2>No hay obras registradas</h2>
            </div>
        <% } %>

</body>
</html>