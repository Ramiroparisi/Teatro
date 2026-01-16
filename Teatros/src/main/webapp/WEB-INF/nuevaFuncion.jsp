<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.teatro.modelo.Obra, com.teatro.modelo.Teatro, com.teatro.modelo.Usuario" %>
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
    <title>Programar Nueva Función</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f4f7f6; }
        .card-custom { border: none; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .header-gradient { 
            background: linear-gradient(45deg, #2c3e50, #4ca1af); 
            color: white; border-radius: 15px 15px 0 0; padding: 25px; 
        }
        .form-label { font-weight: 600; color: #2c3e50; }
        .btn-primary-custom { background-color: #3498db; border: none; padding: 12px; font-weight: bold; }
        .btn-primary-custom:hover { background-color: #2980b9; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card card-custom">
                <div class="header-gradient text-center">
                    <h2 class="mb-0"><i class="far fa-calendar-plus me-2"></i>Programar Función</h2>
                    <small>Asigne obra, sede y horario</small>
                </div>
                
                <div class="card-body p-4">
                    <form action="nuevaFuncion" method="POST">
                        
                        <div class="mb-3">
                            <label class="form-label">Seleccionar Obra</label>
                            <select name="idObra" class="form-select form-select-lg" required>
                                <option value="" disabled selected>Escoja una obra...</option>
                                <% 
                                    List<Obra> obras = (List<Obra>) request.getAttribute("listaObras");
                                    if(obras != null) {
                                        for(Obra o : obras) { %>
                                            <option value="<%= o.getId() %>"><%= o.getNombre() %></option>
                                <%      } 
                                    } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Teatro / Sede</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-landmark"></i></span>
                                <select name="idTeatro" class="form-select" required>
                                    <option value="" disabled selected>¿En qué teatro será?</option>
                                    <% 
                                        List<Teatro> teatros = (List<Teatro>) request.getAttribute("listaTeatros");
                                        if(teatros != null) {
                                            for(Teatro t : teatros) { %>
                                                <option value="<%= t.getId() %>"><%= t.getNombre() %> (Cap: <%= t.getCapacidad() %>)</option>
                                    <%      } 
                                        } %>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-5 mb-3">
                                <label class="form-label">Precio de Entrada</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" name="precio" step="0.01" class="form-control" placeholder="0.00" required>
                                </div>
                            </div>
                            
                            <div class="col-md-7 mb-3">
                                <label class="form-label">Fecha y Hora</label>
                                <input type="datetime-local" name="fechaHora" class="form-control" required>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary-custom text-white shadow-sm">
                                <i class="fas fa-save me-2"></i>Confirmar Programación
                            </button>
                            <a href="listaObras" class="btn btn-light">Cancelar</a>
                        </div>
                    </form>
                </div>
            </div>
            
            <p class="text-center mt-4 text-muted small">
                <i class="fas fa-info-circle me-1"></i> 
                Recuerde que no puede haber dos funciones en el mismo teatro a la misma hora.
            </p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>