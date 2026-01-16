<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.teatro.modelo.Obra, com.teatro.modelo.Funcion, com.teatro.modelo.Usuario, java.text.SimpleDateFormat" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    SimpleDateFormat sdfFecha = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Control - Gestión de Obras</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; margin: 0; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; background: #2c3e50; color: white; padding: 20px 40px; border-radius: 10px; margin-bottom: 30px; }
        .header-actions { display: flex; gap: 10px; }
        
        .btn { padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: 600; transition: 0.2s; border: none; cursor: pointer; }
        .btn-add { background: #27ae60; color: white; }
        .btn-add:hover { background: #2ecc71; }
        .btn-back { background: #e74c3c; color: white; }
        
        .grid-obras { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px; }
        .card { background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.08); display: flex; flex-direction: column; border-top: 6px solid #3498db; }
        
        .card-img { width: 100%; height: 180px; object-fit: cover; background: #ecf0f1; }
        .card-body { padding: 20px; flex-grow: 1; }
        .card-title { margin: 0 0 10px; color: #2c3e50; font-size: 1.25rem; text-transform: uppercase; }
        .badge-teatro { background: #16a085; color: white; padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; display: inline-block; margin-bottom: 12px; }
        .meta-info { font-size: 0.85rem; color: #7f8c8d; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 8px; }
        
        /* Contenedor de funciones en la card de admin */
        .admin-funciones-list { background: #fdfdfd; border: 1px inset #eee; border-radius: 8px; padding: 10px; max-height: 130px; overflow-y: auto; font-size: 0.85rem; margin-top: 10px; }
        .funcion-item { display: flex; justify-content: space-between; padding: 6px 0; border-bottom: 1px solid #f0f0f0; }
        .funcion-item:last-child { border-bottom: none; }
        
        .actions { background: #f8f9fa; padding: 15px; display: flex; justify-content: space-around; border-top: 1px solid #eee; }
        .actions a { text-decoration: none; font-size: 0.9rem; font-weight: bold; }
        .btn-edit { color: #f39c12; }
        .btn-delete { color: #c0392b; }
        .btn-func { color: #2980b9; }
        
        .no-data { text-align: center; width: 100%; padding: 60px; color: #95a5a6; grid-column: 1 / -1; }
    </style>
</head>
<body>

<div class="header">
    <h1>Gestión de Obras y Funciones</h1>
    <div class="header-actions">
        <a href="nuevaObra" class="btn btn-add"><i class="fas fa-plus"></i> Cargar Obra</a>
        <a href="nuevaFuncion" class="btn btn-add"><i class="fas fa-calendar-plus"></i> Cargar Función</a>
        <a href="adminDashboard" class="btn btn-back">Volver</a>
    </div>
</div>

<div class="grid-obras">
    <% 
        List<Obra> lista = (List<Obra>) request.getAttribute("listaObras"); 
        if (lista != null && !lista.isEmpty()) {
            for (Obra obra : lista) { 
    %>
        <div class="card">
            <img src="verImagen?id=<%= obra.getId() %>" class="card-img" alt="Foto">
            
            <div class="card-body">
                <span class="badge-teatro"><i class="fas fa-landmark"></i> <%= (obra.getNombreTeatro() != null) ? obra.getNombreTeatro() : "Sin Teatro" %></span>
                <h3 class="card-title"><%= obra.getNombre() %></h3>
                
                <div class="meta-info">
                    <strong>ID:</strong> <%= obra.getId() %> | <strong>Duración:</strong> <%= obra.getDuracion() %> min
                </div>
                
                <p class="text-muted small mb-1"><strong>Cronograma de Funciones:</strong></p>
                <div class="admin-funciones-list">
                    <% 
                        List<Funcion> funciones = obra.getFunciones();
                        if (funciones != null && !funciones.isEmpty()) {
                            for (Funcion f : funciones) { 
                    %>
                        <div class="funcion-item">
                            <span><i class="far fa-calendar-alt text-primary"></i> <%= sdfFecha.format(f.getFecha()) %></span>
                            <span><i class="far fa-clock text-primary"></i> <%= sdfHora.format(f.getHora()) %>hs</span>
                            <span class="text-success fw-bold">$<%= f.getPrecio() %></span>
                        </div>
                    <% 
                            }
                        } else { 
                    %>
                        <p class="text-center text-danger m-0 py-2" style="font-size: 0.75rem;">No hay funciones cargadas para esta obra.</p>
                    <% } %>
                </div>
            </div>
            
            <div class="actions">
                <a href="funciones?obraId=<%= obra.getId() %>" class="btn-func" title="Ver detalle completo">📅 Gestionar</a>
                <a href="editarObra?id=<%= obra.getId() %>" class="btn-edit">✏️ Editar</a>
                <a href="eliminarObra?id=<%= obra.getId() %>" class="btn-delete" onclick="return confirm('¿Está seguro de eliminar esta obra? Se borrarán también todas sus funciones.')">🗑️ Borrar</a>
            </div>
        </div>
    <% 
            } 
        } else { 
    %>
        <div class="no-data">
            <i class="fas fa-folder-open fa-3x mb-3"></i>
            <h2>No se encontraron obras registradas en el sistema.</h2>
            <p>Utilice el botón "Cargar Obra" para comenzar.</p>
        </div>
    <% } %>
</div>

</body>
</html>