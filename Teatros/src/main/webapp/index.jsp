<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario, com.teatro.modelo.Obra, com.teatro.modelo.Funcion, java.util.List, java.text.SimpleDateFormat" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

    if (user != null && user.getRol() != null && user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect("adminDashboard.jsp");
        return; 
    }
    List<Obra> obras = (List<Obra>) request.getAttribute("obrasCartelera");
    
    SimpleDateFormat sdfFecha = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Rosario en Cartel - Inicio</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" />
    <link href="css/index-styles.css" rel="stylesheet" />
    <style>
        .obra-card { transition: all 0.3s ease; border: none; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .obra-card:hover { transform: translateY(-8px); box-shadow: 0 12px 24px rgba(0,0,0,0.15); }
        .card-img-top { height: 320px; object-fit: cover; }
        .badge-teatro { background-color: #1abc9c; color: white; font-size: 0.8rem; border-radius: 50px; padding: 6px 14px; }
        .funciones-container { max-height: 160px; overflow-y: auto; padding-right: 5px; }
        .btn-funcion { transition: all 0.2s; font-size: 0.85rem; border: 1px solid #dee2e6; }
        .btn-funcion:hover { background-color: #f8f9fa; border-color: #1abc9c; color: #1abc9c !important; }
        .masthead { padding-top: calc(6rem + 74px); padding-bottom: 6rem; }
    </style>
</head>
<body id="page-top">
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="inicio">Rosario en cartel</a>
            <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive">
                Menú <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#obras">Cartelera</a></li>
                    <% if (user != null) { %>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="mis-entradas">Mis Compras</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="logout" style="color: #ffc107;">Salir</a></li>
                    <% } else { %>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="login.jsp" style="color: #6dabe4; font-weight: bold;">Iniciar Sesión</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="masthead bg-primary text-white text-center">
        <div class="container d-flex align-items-center flex-column">
            <img class="masthead-avatar mb-5" src="assets/img/avataaars.svg" alt="..." style="width: 180px;" />
            <h1 class="masthead-heading text-uppercase mb-0">
                <%= (user != null) ? "Bienvenido, " + user.getNombre() : "Bienvenido al Teatro" %>
            </h1>
            <div class="divider-custom divider-light">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-theater-masks"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <p class="masthead-subheading font-weight-light mb-0">La cartelera completa de Rosario en un solo lugar</p>
        </div>
    </header>

    <section class="page-section" id="obras">
        <div class="container">
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">Cartelera Actual</h2>
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                <div class="divider-custom-line"></div>
            </div>

            <div class="row justify-content-center">
                <% if (obras != null && !obras.isEmpty()) { 
                    for (Obra o : obras) { %>
                    <div class="col-md-6 col-lg-4 mb-5">
                        <div class="card h-100 obra-card">
                            <img class="card-img-top" src="verImagen?id=<%= o.getId() %>" alt="<%= o.getNombre() %>">
                            
                            <div class="card-body text-center d-flex flex-column">
                                <div class="mb-2">
                                    <span class="badge-teatro">
                                        <i class="fas fa-landmark"></i> <%= (o.getNombreTeatro() != null) ? o.getNombreTeatro() : "Teatro Rosario" %>
                                    </span>
                                </div>
                                <h4 class="card-title text-uppercase mt-2"><%= o.getNombre() %></h4>
                                <p class="text-muted small"><%= o.getDuracion() %> min. de duración</p>
                                
                                <hr>
                                <h6 class="text-muted mb-3">Funciones Disponibles:</h6>
                                <div class="funciones-container mb-3">
                                    <% 
                                    if (o.getFunciones() != null && !o.getFunciones().isEmpty()) {
                                        for (Funcion f : o.getFunciones()) { 
                                            String fechaFmt = sdfFecha.format(f.getFecha());
                                            String horaFmt = sdfHora.format(f.getHora());
                                    %>
                                        <a href="seleccionarAsientos?funcionId=<%= f.getId() %>" 
                                           class="btn btn-light btn-funcion d-block mb-2 text-decoration-none text-dark py-2">
                                           <i class="far fa-calendar-alt me-1"></i> <%= fechaFmt %> | 
                                           <i class="far fa-clock me-1"></i> <%= horaFmt %>hs 
                                        </a>
                                    <% 
                                        }
                                    } else { 
                                    %>
                                        <p class="small text-danger italic">Sin funciones próximas</p>
                                    <% } %>
                                </div>
                                
                                <div class="mt-auto">
                                    <a href="detallesObra?id=<%= o.getId() %>" class="btn btn-outline-secondary btn-sm w-100 rounded-pill">
                                        Más información
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } 
                } else { %>
                    <div class="col-12 text-center py-5">
                        <p class="lead text-muted">No hay obras disponibles en este momento.</p>
                        <a href="inicio" class="btn btn-primary rounded-pill">Recargar Página</a>
                    </div>
                <% } %>
            </div>
        </div>
    </section>

    <footer class="footer text-center">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h4 class="text-uppercase mb-4">Rosario en Cartel</h4>
                    <p class="lead mb-0">Tu entrada al teatro, más fácil que nunca.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>