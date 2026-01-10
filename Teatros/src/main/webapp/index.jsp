<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario" %>
<%

    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

    if (user != null && user.getRol() != null && user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect("adminDashboard.jsp");
        return; 
    }
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Teatro - Inicio</title>
	<link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" />
    <link href="css/index-styles.css" rel="stylesheet" />
</head>
<body id="page-top">
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Rosario en cartel</a>
            <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive">
                Menú <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#obras">Cartelera</a></li>
                    
                    <% if (user != null) { %>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="mis-entradas">Mis Compras</a></li>
                        <li class="nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded" href="logout" style="color: #ffc107;">
                                Salir
                            </a>
                        </li>
                    <% } else { %>
                        <li class="nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded" href="login.jsp" style="color: #6dabe4; font-weight: bold;">
                                Iniciar Sesión
                            </a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="masthead bg-primary text-white text-center">
        <div class="container d-flex align-items-center flex-column">
            <img class="masthead-avatar mb-5" src="assets/img/avataaars.svg" alt="..." />
            
            <h1 class="masthead-heading text-uppercase mb-0">
                <%= (user != null) ? "Bienvenido, " + user.getNombre() : "Bienvenido al Teatro" %>
            </h1>
            
            <div class="divider-custom divider-light">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-theater-masks"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <p class="masthead-subheading font-weight-light mb-0">Vive la mejor experiencia teatral en nuestra sala</p>
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
                <p class="text-center">Selecciona una obra para ver las funciones disponibles.</p>
                </div>
        </div>
    </section>

    <footer class="footer text-center">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h4 class="text-uppercase mb-4">Sobre Nosotros</h4>
                    <p class="lead mb-0">Gestión de entradas y cartelera oficial del Teatro Central.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>