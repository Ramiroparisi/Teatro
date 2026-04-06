<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario, com.teatro.modelo.Obra, com.teatro.modelo.Funcion, java.util.*, java.text.SimpleDateFormat" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");

  /*  if (user != null && user.getRol() != null && user.getRol().toString().equalsIgnoreCase("admin")) {
       response.sendRedirect("adminDashboard"); 
       return;
    }
    */
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
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" />
    <link href="css/index-styles.css" rel="stylesheet" />
    
    <style>
    	#mainNav {background: linear-gradient(135deg, #800000 0%, #000000 100%) !important;}
    	
    	.masthead {background: radial-gradient(circle at center, #960303 0%, #4a0000 70%, #200000 100%) !important; padding-top: calc(8rem + 74px); padding-bottom: 8rem; position: relative;}
    	
    	.masthead-heading {text-shadow: 0 0 20px rgba(217, 194, 2, 0.4); letter-spacing: 2px;}
    	
    	.divider-custom .divider-custom-line {background-color: #D9C202 !important;}
        
        .divider-custom .divider-custom-icon {color: #D9C202 !important;}
        
         body { background-color: #FDFCF0 !important; font-family: 'Montserrat', sans-serif; }
        
         h1, h2, .navbar-brand {font-family: 'Playfair Display', serif;}
        
        .obra-card {transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); border: 1px solid #e0dcc5; border-radius: 20px; overflow: hidden; background-color: #ffffff; box-shadow: 0 10px 20px rgba(0,0,0,0.05);}
		
		.card-title { color: #800000; font-weight: 700; min-height: 50px; display: flex; align-items: center; justify-content: center; }
        
        .obra-card:hover {transform: translateY(-12px); box-shadow: 0 20px 40px rgba(128,0,0,0.25); border-color: #D9C202;}
        
        .card-img-top { height: 320px; object-fit: cover; }
        
        .badge-teatro {background-color: #2c3e50; color: #D9C202; font-size: 0.8rem; border-radius: 4px; padding: 6px 12px; border: 1px solid #D9C202; text-transform: uppercase;font-weight: bold;}
        
        .btn-funcion { background-color: #D9C202 !important; color: #000 !important; border: 2px #800000 !important; font-weight: 800; box-shadow: 3px 3px 0px #4a0000; margin-bottom: 12px; border-radius: 8px;}
        
        .btn-funcion:hover {background-color: #f1e05a !important; transform: scale(1.03); box-shadow: 1px 1px 0px #4a0000;}
        
        .filter-section {background: #ffffff; border-radius: 15px; padding: 30px; margin-bottom: 50px; border: 2px solid #D9C202; box-shadow: 0 5px 15px rgba(0,0,0,0.1);}
		
		.btn-outline-secondary { color: #800000; border-color: #800000; font-weight: bold; text-transform: uppercase; letter-spacing: 1px; }
    	
    	.btn-outline-secondary:hover { background-color: #800000; color: #D9C202; }
    	
    	.alerta-admin {background-color: #FF0000; color: #000; text-align: center; padding: 12px; font-weight: bold; position: sticky; top: 0; z-index: 2000; font-family: 'Montserrat', sans-serif;}

		.btn-volver-admin { background-color: #ffffff; color: black !important; padding: 5px 15px; border-radius: 20px; margin-left: 15px; font-size: 0.8rem;}
		
		.btn-volver-admin:hover {background-color: #BFBFBF;
    </style>
    
</head>

<body id="page-top">
	<% if (user != null && user.getRol() != null && user.getRol().toString().equalsIgnoreCase("admin")) { %>
    	<div class="alerta-admin">
        	MODO VISTA PREVIA (ADMINISTRADOR)
        	<a href="adminDashboard" class="btn-volver-admin">VOLVER AL PANEL</a>
    	</div> <% } %>
    	
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="inicio" style="color: #D9C202;">Rosario en cartel</a>
            <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" style="color: #D9C202 !important; background-color: #000000 !important;">
                Menú <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#obras" style="color: #D9C202 !important;" >Cartelera</a></li>
                    <% if (user != null) { %>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="misEntradas" style="color: #D9C202 !important;">Mis Compras</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="logout" style="color: #ffffff;">Salir</a></li>
                    <% } else { %>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="login.jsp" style="color: #ffffff; font-weight: bold;">Iniciar Sesión</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="masthead bg-primary text-white text-center">
        <div class="container d-flex align-items-center flex-column">
            <h1 class="masthead-heading text-uppercase mb-0" style="color: #D9C202 !important;">
                <%= (user != null) ? "Bienvenido, " + user.getNombre() : "Rosario en cartel" %>
            </h1>
            <div class="divider-custom divider-light">
                <div class="divider-custom-line style=" ></div>
                <div class="divider-custom-icon"><i class="fas fa-theater-masks" ></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <p class="masthead-subheading font-weight-light mb-0" style="color: #D9C202 !important;">Encuentra tu próxima función favorita</p>
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
                        <button onclick="limpiarFiltros()" class="btn btn-secondary w-100" >Limpiar</button>
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
        <div class="container">
        	<p class="lead mb-0">Rosario en Cartel &copy; 2026</p>
        </div>
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