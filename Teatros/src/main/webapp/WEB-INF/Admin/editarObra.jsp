<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Obra" %>
<%
    Obra obra = (Obra) request.getAttribute("obra");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Obra - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark">
                        <h3 class="mb-0">Editar Obra: <%= obra.getNombre() %></h3>
                    </div>
                    <div class="card-body">
                        <form action="editarObra" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="<%= obra.getId() %>">

                            <div class="mb-3">
                                <label class="form-label">Nombre de la Obra</label>
                                <input type="text" name="nombre" class="form-control" value="<%= obra.getNombre() %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Descripción</label>
                                <textarea name="descripcion" class="form-control" rows="3" required><%= obra.getDescripcion() %></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Duración (minutos)</label>
                                    <input type="number" name="duracion" class="form-control" value="<%= obra.getDuracion() %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">ID Teatro</label>
                                    <input type="number" name="teatroID" class="form-control" value="<%= obra.getTeatroID() %>" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Imagen (Dejar vacío para mantener la actual)</label>
                                <input type="file" name="foto" class="form-control" accept="image/*">
                                <div class="mt-2 text-muted small">Imagen actual:</div>
                                <img src="verImagen?id=<%= obra.getId() %>" style="height: 100px; border-radius: 5px;">
                            </div>

                            <div class="d-flex justify-content-between mt-4">
                                <a href="listaObras" class="btn btn-secondary">Cancelar</a>
                                <button type="submit" class="btn btn-warning fw-bold">Guardar Cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>tml>