<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.teatro.modelo.Usuario" %>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; background: #333; color: white; padding: 15px 30px; border-radius: 8px; margin-bottom: 20px;}
        .btn-back { background: #dc3545; color: white; text-decoration: none; padding: 10px 15px; border-radius: 5px; font-weight: bold; }
        .btn-back:hover { color: white; opacity: 0.9; }
        
        details { background: white; margin-bottom: 15px; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        summary { padding: 15px; font-size: 1.2em; font-weight: bold; cursor: pointer; background: #007bff; color: white; list-style: none; }
        
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        tr:hover { background-color: #f9f9f9; }
        .actions a { text-decoration: none; font-size: 1.2rem; margin-right: 10px; }
    </style>
</head>
<body>

<div class="header shadow">
    <h1 class="h3 mb-0">Administración de Usuarios</h1>
    <div class="header-actions">
        <a href="adminDashboard" class="btn-back">Volver al Panel</a>
    </div>
</div>

<div class="container-fluid px-0">
    <%
        String status = request.getParameter("status");
        if ("success".equals(status)) { %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <strong>¡Eliminado!</strong> El usuario ha sido borrado correctamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
    <%  } else if ("error_compras".equals(status)) { %>
            <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
                <strong>No se puede eliminar:</strong> El usuario tiene compras realizadas. No se pueden borrar clientes con entradas asignadas.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
    <%  } else if (status != null) { %>
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <strong>Error:</strong> El usuario tiene compras realizadas. No se pueden borrar clientes con entradas asignadas.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
    <%  } %>

    <% 
        List<Usuario> lista = (List<Usuario>) request.getAttribute("listaUsuarios"); 
        if (lista != null) { 
    %>
        <details open>
            <summary>🛡️ Administradores del Sistema</summary>
            <table>
                <thead class="table-light"><tr><th>Nombre</th><th>Email</th><th>Documento</th><th>Acciones</th></tr></thead>
                <% for (Usuario u : lista) { 
                    if ("admin".equalsIgnoreCase(u.getRol().toString())) { %>
                    <tr>
                        <td><%= u.getNombre() %> <%= u.getApellido() %></td>
                        <td><%= u.getMail() %></td>
                        <td><%= u.getDocumento() %></td>
                        <td class="actions">
                            <a href="editarUsuario?id=<%= u.getId() %>" title="Editar">✏️</a>
                            <a href="eliminarUsuario?id=<%= u.getId() %>" onclick="return confirm('¿Eliminar admin: <%=u.getNombre()%>?')" style="color:red;" title="Eliminar">🗑️</a>
                        </td>
                    </tr>
                <% } } %>
            </table>
        </details>

        <details>
            <summary>🎭 Empleados por Teatro</summary>
            <table>
                <thead class="table-light"><tr><th>Nombre</th><th>Email</th><th>Teatro Asignado</th><th>Acciones</th></tr></thead>
                <% for (Usuario u : lista) { 
                    if ("empleado".equalsIgnoreCase(u.getRol().toString())) { %>
                    <tr>
                        <td><%= u.getNombre() %> <%= u.getApellido() %></td>
                        <td><%= u.getMail() %></td>
                        <td><%= (u.getNombreTeatro() != null) ? u.getNombreTeatro() : "Sin asignar" %></td>
                        <td class="actions">
                            <a href="editarUsuario?id=<%= u.getId() %>">✏️</a>
                            <a href="eliminarUsuario?id=<%= u.getId() %>" onclick="return confirm('¿Eliminar empleado?')" style="color:red;">🗑️</a>
                        </td>
                    </tr>
                <% } } %>
            </table>
        </details>

        <details>
            <summary>👤 Clientes Registrados</summary>
            <table>
                <thead class="table-light"><tr><th>Nombre</th><th>Email</th><th>Documento</th><th>Acciones</th></tr></thead>
                <% for (Usuario u : lista) { 
                    if ("cliente".equalsIgnoreCase(u.getRol().toString())) { %>
                    <tr>
                        <td><%= u.getNombre() %> <%= u.getApellido() %></td>
                        <td><%= u.getMail() %></td>
                        <td><%= (u.getDocumento() != null) ? u.getDocumento() : "-" %></td>
                        <td class="actions">
                            <a href="editarUsuario?id=<%= u.getId() %>">✏️</a>
                            <a href="eliminarUsuario?id=<%= u.getId() %>" onclick="return confirm('¿Eliminar cliente: <%=u.getNombre()%>?')" style="color:red;">🗑️</a>
                        </td>
                    </tr>
                <% } } %>
            </table>
        </details>
    <% } else { %>
        <div class="alert alert-secondary text-center mt-5">No se pudo cargar la lista de usuarios.</div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>