<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario, com.teatro.modelo.Obra, com.teatro.modelo.Funcion, java.util.*, java.text.SimpleDateFormat" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

    if (user != null && user.getRol() != null && user.getRol().toString().equalsIgnoreCase("admin")) {
       response.sendRedirect("adminDashboard"); 
       return;
    }
    
    if (request.getAttribute("obrasCartelera") == null) {
        response.sendRedirect("inicio");
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
        .btn-funcion { transition: all 0.2s; font-size: 0.85rem; border: 1px solid #dee2e6; }
        .btn-funcion:hover { background-color: #f8f9fa; border-color: #1abc9c; color: #1abc9c !important; }
        .filter-section { background: #f8f9fa; border-radius: 20px; padding: 30px; margin-bottom: 50px; border: 1px solid #e9ecef; }
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
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="misEntradas">Mis Compras</a></li>
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
            <h1 class="masthead-heading text-uppercase mb-0">
                <%= (user != null) ? "Bienvenido, " + user.getNombre() : "Rosario en cartel" %>
            </h1>
            <div class="divider-custom divider-light">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-theater-masks"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <p class="masthead-subheading font-weight-light mb-0">Encuentra tu próxima función favorita</p>
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

            <div class="filter-section shadow-sm">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-muted small">TEATRO</label>
                        <select id="filterTeatro" class="form-select border-0 shadow-sm">
                            <option value="all">Todos los teatros</option>
                            <% 
                               Set<String> teatros = new HashSet<>();
                               if(obras != null) for(Obra o : obras) teatros.add(o.getNombreTeatro());
                               for(String t : teatros) { 
                            %>
                                <option value="<%= t %>"><%= t %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold text-muted small">FECHA DESDE</label>
                        <input type="date" id="filterDesde" class="form-control border-0 shadow-sm">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold text-muted small">FECHA HASTA</label>
                        <input type="date" id="filterHasta" class="form-control border-0 shadow-sm">
                    </div>
                    <div class="col-md-2">
                        <button onclick="limpiarFiltros()" class="btn btn-secondary w-100">Limpiar</button>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center" id="contenedorObras">
                <% if (obras != null && !obras.isEmpty()) { 
                    for (Obra o : obras) { 
                        StringBuilder fechasStr = new StringBuilder();
                        if(o.getFunciones() != null) {
                            for(Funcion f : o.getFunciones()) fechasStr.append(f.getFecha().toString()).append(",");
                        }
                %>
                    <div class="col-md-6 col-lg-4 mb-5 obra-item" 
                         data-teatro="<%= o.getNombreTeatro() %>" 
                         data-fechas="<%= fechasStr.toString() %>">
                        
                        <div class="card h-100 obra-card">
                            <img class="card-img-top" src="verImagen?id=<%= o.getId() %>" alt="<%= o.getNombre() %>">
                            <div class="card-body text-center d-flex flex-column">
                                <div class="mb-2">
                                    <span class="badge-teatro"><i class="fas fa-landmark"></i> <%= o.getNombreTeatro() %></span>
                                </div>
                                <h4 class="card-title text-uppercase mt-2"><%= o.getNombre() %></h4>
                                <hr>
                                <div class="funciones-list mb-3">
                                    <% if (o.getFunciones() != null) {
                                        for (Funcion f : o.getFunciones()) { %>
                                            <a href="seleccionarAsientos?funcionId=<%= f.getId() %>" 
                                               class="btn btn-light btn-funcion d-block mb-2 text-dark py-2">
                                               <%= sdfFecha.format(f.getFecha()) %> | <%= sdfHora.format(f.getHora()) %>hs 
                                            </a>
                                    <% } } %>
                                </div>
                                <div class="mt-auto">
                                    <a href="detallesObra?id=<%= o.getId() %>" class="btn btn-outline-secondary btn-sm w-100 rounded-pill">Más info</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } } %>
            </div>
            
            <div id="noResults" class="text-center py-5 d-none">
                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                <p class="lead text-muted">No se encontraron funciones para los filtros seleccionados.</p>
            </div>
        </div>
    </section>

    <footer class="footer text-center">
        <div class="container"><p class="lead mb-0">Rosario en Cartel &copy; 2026</p></div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    function filtrar() {
        const teatro = document.getElementById('filterTeatro').value;
        const desde = document.getElementById('filterDesde').value;
        const hasta = document.getElementById('filterHasta').value;
        const items = document.querySelectorAll('.obra-item');
        let visibles = 0;

        items.forEach(item => {
            const itemTeatro = item.getAttribute('data-teatro');
            const itemFechas = item.getAttribute('data-fechas').split(',').filter(f => f !== "");
            
            const matchTeatro = (teatro === 'all' || itemTeatro === teatro);
            
            let matchFecha = true;
            if (desde || hasta) {
                matchFecha = itemFechas.some(f => {
                    if (desde && hasta) return f >= desde && f <= hasta;
                    if (desde) return f >= desde;
                    if (hasta) return f <= hasta;
                    return true;
                });
            }

            if (matchTeatro && matchFecha) {
                item.classList.remove('d-none');
                visibles++;
            } else {
                item.classList.add('d-none');
            }
        });

        document.getElementById('noResults').classList.toggle('d-none', visibles > 0);
    }

    function limpiarFiltros() {
        document.getElementById('filterTeatro').value = 'all';
        document.getElementById('filterDesde').value = '';
        document.getElementById('filterHasta').value = '';
        filtrar();
    }

    document.getElementById('filterTeatro').addEventListener('change', filtrar);
    document.getElementById('filterDesde').addEventListener('change', filtrar);
    document.getElementById('filterHasta').addEventListener('change', filtrar);
    </script>
</body>
</html>