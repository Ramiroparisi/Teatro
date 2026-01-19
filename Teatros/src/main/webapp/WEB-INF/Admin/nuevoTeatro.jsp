<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario" %>
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
    <title>Nuevo Teatro - Administración</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card-form { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .header-form { background: #2c3e50; color: white; border-radius: 15px 15px 0 0; padding: 20px; }
        .btn-save { background-color: #27ae60; color: white; font-weight: bold; border: none; padding: 12px; }
        .btn-save:hover { background-color: #219150; color: white; }
        .form-label { font-weight: 600; color: #34495e; }
        .input-group-text { background-color: #f8f9fa; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card card-form">
                <div class="header-form text-center">
                    <h3 class="mb-0"><i class="fas fa-landmark me-2"></i>Registrar Nuevo Teatro</h3>
                    <small class="opacity-75">Complete la información para dar de alta la sala</small>
                </div>
                
                <div class="card-body p-4">
                    <form action="nuevoTeatro" method="POST">
                        
                        <div class="mb-4">
                            <label for="nombre" class="form-label">Nombre del Teatro</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-font"></i></span>
                                <input type="text" class="form-control" id="nombre" name="nombre" 
                                       placeholder="Ej: Teatro Gran Rex" required>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-12 mb-3">
                                <label for="direccion" class="form-label">Dirección</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <input type="text" class="form-control" id="direccion" name="direccion" 
                                           placeholder="Calle y número" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="ciudad" class="form-label">Ciudad</label>
                                <input type="text" class="form-control" id="ciudad" name="ciudad" 
                                       placeholder="Ej: Buenos Aires" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="pais" class="form-label">País</label>
                                <input type="text" class="form-control" id="pais" name="pais" 
                                       placeholder="Ej: Argentina" required>
                            </div>
                        </div>

                        <div class="card bg-light border-0 mb-4">
                            <div class="card-body">
                                <label for="capacidad" class="form-label">Capacidad de Espectadores</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-users"></i></span>
                                    <input type="number" class="form-control form-control-lg" id="capacidad" name="capacidad" 
                                           min="1" max="1000" placeholder="Ej: 150" required>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-save shadow-sm">
                                <i class="fas fa-check-circle me-1"></i> Guardar Teatro
                            </button>
                            <a href="listaTeatros" class="btn btn-link text-muted">Cancelar y volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>