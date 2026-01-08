<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario" %>
<%
    // 1. Protección de Seguridad: Solo ADMINS
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
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        .sidebar { height: 100vh; background: #2c3e50; color: white; padding-top: 20px; }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px 20px; }
        .sidebar a:hover { background: #34495e; }
        .admin-card { border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: 0.3s; }
        .admin-card:hover { transform: translateY(-5px); }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block sidebar">
                <div class="text-center mb-4">
                    <i class="fas fa-user-shield fa-3x"></i>
                    <h5 class="mt-2">Panel Admin</h5>
                </div>
                <hr>
                <a href="adminDashboard.jsp"><i class="fas fa-home me-2"></i> Inicio</a>
                <a href="gestionarObras"><i class="fas fa-theater-masks me-2"></i> Obras</a>
                <a href="gestionarUsuarios"><i class="fas fa-users me-2"></i> Usuarios</a>
                <a href="reporteVentas"><i class="fas fa-chart-line me-2"></i> Ventas</a>
                <a href="index.jsp"><i class="fas fa-eye me-2"></i> Ver Sitio Público</a>
                <hr>
                <a href="logout" class="text-warning"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a>
            </nav>

            <main class="col-md-10 ms-sm-auto px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Bienvenido, <%= user.getNombre() %></h1>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <div class="card admin-card bg-primary text-white mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Obras Activas</h5>
                                <p class="card-text fs-2">12</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card admin-card bg-success text-white mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Ventas Hoy</h5>
                                <p class="card-text fs-2">$ 45.000</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card admin-card bg-info text-white mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Nuevos Clientes</h5>
                                <p class="card-text fs-2">8</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <h3>Últimas Ventas</h3>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mt-3">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Cliente</th>
                                    <th>Fecha</th>
                                    <th>Total</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#1024</td>
                                    <td>Juan Pérez</td>
                                    <td>08/01/2026</td>
                                    <td>$ 3.500</td>
                                    <td><button class="btn btn-sm btn-outline-primary">Detalle</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>