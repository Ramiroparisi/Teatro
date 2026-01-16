<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.teatro.modelo.Teatro, com.teatro.modelo.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Teatros - Admin</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { max-width: 1100px; margin: auto; } /* Aumenté un poco el ancho para las nuevas columnas */
        .header { display: flex; justify-content: space-between; align-items: center; background: #2c3e50; color: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        .btn { padding: 8px 16px; border-radius: 4px; text-decoration: none; font-weight: bold; color: white; transition: 0.3s; font-size: 0.9rem; }
        .btn-primary { background: #3498db; }
        .btn-success { background: #27ae60; }
        .btn-back { background: #95a5a6; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #333; text-transform: uppercase; font-size: 0.85rem; }
        tr:hover { background: #fcfcfc; }
        .badge { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; background: #e8f4fd; color: #2980b9; font-weight: bold; }
        .location-text { color: #7f8c8d; font-size: 0.9rem; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1><i class="fas fa-landmark"></i> Gestión de Teatros</h1>
        <div>
            <a href="nuevoTeatro" class="btn btn-success"><i class="fas fa-plus"></i> Nuevo</a>
            <a href="adminDashboard" class="btn btn-back">Volver</a>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Dirección</th>
                <th>Ciudad</th>
                <th>País</th>
                <th>Capacidad</th>
                <th style="text-align: center;">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Teatro> lista = (List<Teatro>) request.getAttribute("listaTeatros");
                if (lista != null && !lista.isEmpty()) {
                    for (Teatro t : lista) {
            %>
                <tr>
                    <td>#<%= t.getId() %></td>
                    <td><strong><%= t.getNombre() %></strong></td>
                    <td class="location-text"><%= (t.getDireccion() != null) ? t.getDireccion() : "-" %></td>
                    <td class="location-text"><%= (t.getCiudad() != null) ? t.getCiudad() : "-" %></td>
                    <td class="location-text"><%= (t.getPais() != null) ? t.getPais() : "-" %></td>
                    <td><span class="badge"><i class="fas fa-chair"></i> <%= t.getCapacidad() %></span></td>
                    <td style="text-align: center; white-space: nowrap;">
                        <a href="diagramarTeatro?id=<%= t.getId() %>" class="btn btn-primary" title="Configurar Plano">
                            <i class="fas fa-th"></i> Plano
                        </a>
                        <a href="editarTeatro?id=<%= t.getId() %>" style="color: #f39c12; margin-left: 12px;" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="eliminarTeatro?id=<%= t.getId() %>" style="color: #e74c3c; margin-left: 12px;" title="Eliminar" 
                           onclick="return confirm('¿Está seguro de eliminar el teatro <%= t.getNombre() %>?')">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            <% 
                    }
                } else { 
            %>
                <tr>
                    <td colspan="7" style="text-align: center; padding: 40px; color: #999;">
                        <i class="fas fa-info-circle"></i> No hay teatros registrados en la base de datos.
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>