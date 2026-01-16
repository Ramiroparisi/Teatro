<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null || !user.getRol().toString().equalsIgnoreCase("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Teatro Central</title>
    <link href="css/index-styles.css" rel="stylesheet" />
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { height: 100vh; background: #2c3e50; color: white; padding-top: 20px; position: fixed; }
        .sidebar a { color: rgba(255,255,255,0.8); text-decoration: none; display: block; padding: 12px 20px; transition: 0.3s; }
        .sidebar a:hover { background: #34495e; color: white; padding-left: 30px; }
        .sidebar a.active { background: #1abc9c; color: white; }
        .admin-card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: 0.3s; }
        .admin-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        main { margin-left: 16.666667%; } /* Compensa el ancho de la sidebar col-md-2 */
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block sidebar">
                <div class="text-center mb-4">
                    <i class="fas fa-user-shield fa-3x text-info"></i>
                    <h5 class="mt-2">Panel Admin</h5>
                    <small class="text-muted text-uppercase"><%= user.getRol() %></small>
                </div>
                <hr class="bg-light">
                
                <a href="adminDashboard" class="active"><i class="fas fa-home me-2"></i> Inicio</a>
                <a href="listaObras"><i class="fas fa-theater-masks me-2"></i> Obras</a>
                <a href="listaUsuarios"><i class="fas fa-users me-2"></i> Usuarios</a>
                <a href="reporteVentas"><i class="fas fa-chart-line me-2"></i> Ventas</a>
				<a href="listaTeatros"><i class="fas fa-landmark me-2"></i> Teatros</a>
                
                <hr class="bg-light">
                <a href="inicio"><i class="fas fa-eye me-2"></i> Ver Sitio Público</a>
                <a href="logout" class="text-warning"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a>
            </nav>

            <main class="col-md-10 px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Bienvenido, <%= user.getNombre() %></h1>
                    <div class="text-muted"><i class="far fa-calendar-alt me-2"></i> 16 de Enero, 2026</div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card admin-card bg-primary text-white h-100">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title text-uppercase opacity-75">Obras Activas</h6>
                                    <h2 class="mb-0">12</h2>
                                </div>
                                <i class="fas fa-play-circle fa-3x opacity-25"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card admin-card bg-success text-white h-100">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title text-uppercase opacity-75">Ventas Hoy</h6>
                                    <h2 class="mb-0">$ 45.000</h2>
                                </div>
                                <i class="fas fa-cash-register fa-3x opacity-25"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card admin-card bg-info text-white h-100">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title text-uppercase opacity-75">Nuevos Clientes</h6>
                                    <h2 class="mb-0">8</h2>
                                </div>
                                <i class="fas fa-user-plus fa-3x opacity-25"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card admin-card mt-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 text-secondary">Últimas Ventas Realizadas</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Cliente</th>
                                        <th>Fecha</th>
                                        <th>Total</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><strong>#1024</strong></td>
                                        <td>Juan Pérez</td>
                                        <td>08/01/2026</td>
                                        <td class="text-success fw-bold">$ 3.500</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-3">Detalle</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>