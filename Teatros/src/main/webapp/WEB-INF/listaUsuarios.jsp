<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.teatro.modelo.Usuario" %>
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
    <title>Gestión de Usuarios - Admin</title>
	<link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; background: #333; color: white; padding: 15px 30px; border-radius: 8px; margin-bottom: 20px;}
        .btn-add { background: #28a745; color: white; text-decoration: none; padding: 10px 15px; border-radius: 5px; font-weight: bold; }
        .btn-back { background: #dc3545; color: white; text-decoration: none; padding: 10px 15px; border-radius: 5px; font-weight: bold; }
        
        details { background: white; margin-bottom: 15px; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        summary { padding: 15px; font-size: 1.2em; font-weight: bold; cursor: pointer; background: #007bff; color: white; list-style: none; }
        summary::-webkit-details-marker { display: none; }
        
		table { width: 100%; border-collapse: collapse; background: white; table-layout: fixed; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        tr:hover { background-color: #f9f9f9; }
        .actions a { text-decoration: none; color: #007bff; margin-right: 10px; font-weight: bold; }
    </style>
</head>
<body>

<div class="header">
    <h1>Administración de Usuarios</h1>
    <div class="header-actions">
        <a href="nuevoUsuario.jsp" class="btn-add">+ Nuevo Usuario</a>
        <a href="adminDashboard" class="btn-back">Volver</a>
    </div>
</div>

<% 
    List<Usuario> lista = (List<Usuario>) request.getAttribute("listaUsuarios"); 
    if (lista != null) { 
%>

    <details open>
        <summary>🛡️ Administradores del Sistema</summary>
        <table>
            <tr><th>Nombre</th><th>Email</th><th>Telefono</th><th>Documento</th><th>Acciones</th></tr>
            <% for (Usuario u : lista) { 
                if (u.getRol() != null && u.getRol().toString().equals("admin")) { %>
                <tr>
                    <td><%= u.getNombre() %> <%= u.getApellido() %></td>
                    <td><%= u.getMail() %></td>
                    <td><%= u.getTelefono() %></td>
                    <td><%= u.getDocumento() %></td>
                    <td class="actions">
                        <a href="editarUsuario?id=<%= u.getId() %>">✏️</a>
                        <a href="eliminarUsuario?id=<%= u.getId() %>" style="color:red;">🗑️</a>
                    </td>
                </tr>
            <% } } %>
        </table>
    </details>

<details>
    <summary>🎭 Empleados por Teatro</summary>
    <table>
        <tr>
            <th>Nombre</th>
            <th>Email</th>
            <th>Telefono</th>
            <th>Teatro Asignado</th>
            <th>Acciones</th>
        </tr>
        <% for (Usuario u : lista) { 
            if (u.getRol() != null && u.getRol().toString().equals("empleado")) { %>
            <tr>
                <td><%= u.getNombre() %> <%= u.getApellido() %></td>
                <td><%= u.getMail() %></td>
                <td><%= u.getTelefono() %></td>
                <td>
                    <% if (u.getNombreTeatro() != null) { %>
                        <span style="color: #28a745; font-weight: bold;">
                            <%= u.getNombreTeatro() %>
                        </span> 
                        <small>(ID: <%= u.getTeatroID() %>)</small>
                    <% } else { %>
                        <span style="color: #888;">Sin asignar</span>
                    <% } %>
                </td>
                <td class="actions">
                    <a href="editarUsuario?id=<%= u.getId() %>">✏️</a>
                    <a href="eliminarUsuario?id=<%= u.getId() %>" style="color:red;">🗑️</a>
                </td>
            </tr>
        <% } } %>
    </table>
</details>

    <details>
        <summary>👤 Clientes Registrados</summary>
        <table>
            <tr><th>Nombre</th><th>Email</th><th>Teléfono</th><th>Documento</th><th>Acciones</th></tr>
            <% for (Usuario u : lista) { 
                if (u.getRol() != null && u.getRol().toString().equals("cliente")) { %>
                <tr>
                    <td><%= u.getNombre() %> <%= u.getApellido() %></td>
                    <td><%= u.getMail() %></td>
                    <td><%= (u.getTelefono() != null) ? u.getTelefono() : "-" %></td>
                    <td><%= (u.getDocumento() != null) ? u.getDocumento() : "-" %></td>
                    <td class="actions">
                        <a href="editarUsuario?id=<%= u.getId() %>">✏️</a>
                        <a href="eliminarUsuario?id=<%= u.getId() %>" style="color:red;">🗑️</a>
                    </td>
                </tr>
            <% } } %>
        </table>
    </details>

<% } else { %>
    <p>No se pudo cargar la lista de usuarios.</p>
<% } %>

</body>
</html>