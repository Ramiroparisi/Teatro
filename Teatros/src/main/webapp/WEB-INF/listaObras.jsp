<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.teatro.modelo.Obra, com.teatro.modelo.Funcion, com.teatro.modelo.Usuario, java.text.SimpleDateFormat" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    SimpleDateFormat sdfFecha = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Obras - Panel Admin</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .header-admin { background: #2c3e50; color: white; padding: 25px; border-radius: 12px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .card-obra { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); overflow: hidden; transition: 0.3s; background: white; height: 100%; display: flex; flex-direction: column; }
        .card-obra:hover { transform: translateY(-5px); }
        .img-container { height: 180px; overflow: hidden; position: relative; }
        .card-img-top { width: 100%; height: 100%; object-fit: cover; }
        .badge-teatro { position: absolute; top: 10px; right: 10px; background: rgba(26, 188, 156, 0.9); color: white; padding: 5px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: bold; }
        .funciones-container { background: #f8f9fa; border-radius: 10px; padding: 10px; margin-top: 15px; flex-grow: 1; }
        .funcion-row { 
            display: flex; justify-content: space-between; align-items: center; 
            padding: 8px 12px; margin-bottom: 5px; background: white; 
            border: 1px solid #eee; border-radius: 8px; transition: 0.2s;
            text-decoration: none; color: #2c3e50;
        }
        .funcion-row:hover { background: #e8f4fd; border-color: #3498db; transform: scale(1.02); }
        .btn-ver-mapa { font-size: 0.75rem; font-weight: bold; color: #3498db; }
        .card-footer-actions { background: #fff; padding: 15px; border-top: 1px solid #f1f1f1; display: flex; justify-content: space-around; }
        .action-link { text-decoration: none; font-weight: bold; font-size: 0.9rem; }
    </style>
</head>
<body>

<div class="container py-4">
    <div class="header-admin shadow">
        <div>
            <h1 class="h3 mb-0"><i class="fas fa-theater-masks me-2"></i>Panel de Administración</h1>
            <small class="opacity-75 text-uppercase">Control de Cartelera y Funciones</small>
        </div>
        <div class="d-flex gap-2">
            <a href="nuevaObra" class="btn btn-success"><i class="fas fa-plus-circle me-1"></i> Nueva Obra</a>
            <a href="nuevaFuncion" class="btn btn-info text-white"><i class="fas fa-calendar-plus me-1"></i> Nueva Función</a>
            <a href="adminDashboard" class="btn btn-outline-light"><i class="fas fa-arrow-left"></i></a>
        </div>
    </div>

    <%
        String status = request.getParameter("status");
        if (status != null) {
            if (status.equals("success")) { %>
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fas fa-check-circle me-2"></i> <strong>¡Éxito!</strong> La obra ha sido eliminada correctamente.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (status.equals("updated")) { %>
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fas fa-sync-alt me-2"></i> <strong>¡Actualizado!</strong> Los cambios se guardaron correctamente.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (status.equals("created")) { %>
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fas fa-plus-circle me-2"></i> <strong>¡Creado!</strong> La nueva obra se añadió a la cartelera.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (status.equals("conflict")) { %>
                <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> <strong>No se puede eliminar:</strong> Esta obra tiene funciones asociadas. Elimina primero las funciones.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else { %>
                <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fas fa-times-circle me-2"></i> <strong>Error:</strong> No se pudo completar la operación (Código: <%= status %>).
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% }
        }
    %>

    <div class="row">
        <% 
            List<Obra> lista = (List<Obra>) request.getAttribute("listaObras"); 
            if (lista != null && !lista.isEmpty()) {
                for (Obra obra : lista) { 
        %>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card-obra">
                    <div class="img-container">
                        <img src="verImagen?id=<%= obra.getId() %>" class="card-img-top" alt="<%= obra.getNombre() %>">
                        <span class="badge-teatro shadow-sm">
                            <i class="fas fa-landmark me-1"></i> <%= (obra.getNombreTeatro() != null) ? obra.getNombreTeatro() : "Teatro Principal" %>
                        </span>
                    </div>
                    
                    <div class="card-body">
                        <h5 class="card-title fw-bold text-uppercase mb-1"><%= obra.getNombre() %></h5>
                        <p class="text-muted small mb-3">ID: <%= obra.getId() %> | <%= obra.getDuracion() %> min</p>
                        
                        <label class="small fw-bold text-secondary mb-2">FUNCIONES ACTIVAS:</label>
                        <div class="funciones-container">
                            <% 
                                List<Funcion> funciones = obra.getFunciones();
                                if (funciones != null && !funciones.isEmpty()) {
                                    for (Funcion f : funciones) { 
                            %>
                                <a href="verEstadoFuncion?id=<%= f.getId() %>" class="funcion-row shadow-sm" title="Ver mapa de asientos">
                                    <div class="small">
                                        <i class="far fa-calendar-alt text-primary me-1"></i> <%= sdfFecha.format(f.getFecha()) %><br>
                                        <i class="far fa-clock text-primary me-1"></i> <%= sdfHora.format(f.getHora()) %> hs
                                    </div>
                                    <div class="btn-ver-mapa">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </a>
                            <% 
                                    }
                                } else { 
                            %>
                                <p class="text-center text-muted small py-2 mb-0">No hay funciones.</p>
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="card-footer-actions">
                        <a href="editarObra?id=<%= obra.getId() %>" class="action-link text-warning">
                            <i class="fas fa-edit"></i> EDITAR
                        </a>
                        <a href="eliminarObra?id=<%= obra.getId() %>" 
                           class="action-link text-danger" 
                           onclick="return confirm('¿Estás seguro de que deseas eliminar la obra: <%= obra.getNombre() %>?')">
                            <i class="fas fa-trash"></i> ELIMINAR
                        </a>
                    </div>
                </div>
            </div>
        <% 
                } 
            } else { 
        %>
            <div class="col-12 text-center py-5">
                <i class="fas fa-folder-open fa-4x text-muted mb-3"></i>
                <h3>No se encontraron obras</h3>
                <p class="text-muted">Comienza agregando una nueva obra al sistema.</p>
                <a href="nuevaObra" class="btn btn-primary mt-2">Crear Obra</a>
            </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>