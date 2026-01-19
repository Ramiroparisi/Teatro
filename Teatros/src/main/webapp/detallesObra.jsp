<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Obra" %>
<%
    Obra obra = (Obra) request.getAttribute("obra");
    if (obra == null) {
        response.sendRedirect("inicio");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= obra.getNombre() %> - Detalles</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f8f9fa; font-family: 'Montserrat', sans-serif; }
        .navbar { background-color: #2c3e50 !important; }
        .btn-primary { background-color: #1abc9c; border-color: #1abc9c; }
        .btn-primary:hover { background-color: #16a085; border-color: #16a085; }
        
        .detalle-container { margin-top: 120px; margin-bottom: 50px; }
        .obra-img { 
            width: 100%; 
            border-radius: 15px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            max-height: 600px;
            object-fit: cover;
        }
        .info-card { 
            background: white; 
            padding: 40px; 
            border-radius: 15px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            height: 100%;
        }
        .divider-custom {
            margin: 1.25rem 0 1.5rem;
            width: 100%;
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }
        .divider-custom-line {
            width: 100%;
            max-width: 7rem;
            height: 0.25rem;
            background-color: #2c3e50;
            border-radius: 1rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top text-uppercase">
        <div class="container">
            <a class="navbar-brand text-white" href="inicio">Rosario en cartel</a>
            <a href="inicio" class="btn btn-outline-light btn-sm">
                <i class="fas fa-arrow-left me-2"></i>Volver a Cartelera
            </a>
        </div>
    </nav>

    <div class="container detalle-container">
        <div class="row g-5">
            <div class="col-lg-5">
                <img src="verImagen?id=<%= obra.getId() %>" class="obra-img" alt="<%= obra.getNombre() %>">
            </div>

            <div class="col-lg-7">
                <div class="info-card">
                    <h1 class="text-uppercase fw-bold text-secondary mb-0"><%= obra.getNombre() %></h1>
                    
                    <div class="divider-custom">
                        <div class="divider-custom-line"></div>
                        <div class="mx-3"><i class="fas fa-theater-masks fa-2x"></i></div>
                        <div class="divider-custom-line"></div>
                    </div>

                    <div class="mb-4">
                        <span class="badge bg-info text-dark px-3 py-2 rounded-pill me-2">
                            <i class="far fa-clock me-1"></i> <%= obra.getDuracion() %> min
                        </span>
                        <span class="badge bg-secondary px-3 py-2 rounded-pill">
                            <i class="fas fa-landmark me-1"></i> <%= (obra.getNombreTeatro() != null) ? obra.getNombreTeatro() : "Teatro Rosario" %>
                        </span>
                    </div>

                    <h5 class="fw-bold text-uppercase text-muted small mb-3">Descripción de la obra:</h5>
                    <p class="lead text-dark" style="text-align: justify; line-height: 1.8;">
                        <%= obra.getDescripcion() != null ? obra.getDescripcion() : "No hay descripción disponible para esta obra." %>
                    </p>

                    <div class="mt-5 pt-4 border-top">
                        <p class="text-muted">¿Te interesa esta obra?</p>
                        <a href="inicio#obras" class="btn btn-primary btn-lg rounded-pill px-5 shadow">
                            <i class="fas fa-ticket-alt me-2"></i>VER FUNCIONES
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="text-center py-4 bg-secondary text-white">
        <small>Rosario en Cartel &copy; 2026</small>
    </footer>

</body>
</html>