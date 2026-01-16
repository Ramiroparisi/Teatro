<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario" %>
<%@ page import="com.teatro.modelo.RolUsuario" %>
<%
    // Recuperamos el objeto enviado por el Servlet
    Usuario u = (Usuario) request.getAttribute("usuarioAEmitir");
    
    // Verificación de seguridad básica en la vista
    if (u == null) {
        response.sendRedirect("listaUsuarios");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario - Admin</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f4f4; padding: 40px; }
        .form-container { background: white; padding: 30px; border-radius: 8px; max-width: 600px; margin: auto; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .form-header { border-bottom: 2px solid #007bff; margin-bottom: 20px; padding-bottom: 10px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .button-group { margin-top: 25px; display: flex; gap: 10px; }
        .btn-save { background: #28a745; color: white; border: none; padding: 12px 25px; cursor: pointer; border-radius: 4px; font-weight: bold; flex: 1; }
        .btn-cancel { background: #dc3545; color: white; text-decoration: none; padding: 12px 25px; border-radius: 4px; font-weight: bold; flex: 1; text-align: center; }
        .btn-save:hover { background: #218838; }
    </style>
</head>
<body>

<div class="form-container">
    <div class="form-header">
        <h2>✏️ Editar Usuario: <%= u.getNombre() %> <%= u.getApellido() %></h2>
    </div>

    <form action="editarUsuario" method="POST">
        <input type="hidden" name="id" value="<%= u.getId() %>">

        <div class="form-group">
            <label>Nombre</label>
            <input type="text" name="nombre" value="<%= u.getNombre() %>" required>
        </div>

        <div class="form-group">
            <label>Apellido</label>
            <input type="text" name="apellido" value="<%= u.getApellido() %>" required>
        </div>

        <div class="form-group">
            <label>Correo Electrónico</label>
            <input type="email" name="mail" value="<%= u.getMail() %>" required>
        </div>
        
        <div class="form-group">
			<input type="hidden" name="contrasena" value="<%= u.getContrasena() %>">
		</div>

		<div class="form-group">
    		<label>Tipo de Documento</label>
    		<select name="tipoDoc" required>
        		<option value="DNI" <%= u.getTipoDoc() != null && u.getTipoDoc().equals("DNI") ? "selected" : "" %>>DNI</option>
        		<option value="Pasaporte" <%= u.getTipoDoc() != null && u.getTipoDoc().equals("Pasaporte") ? "selected" : "" %>>Pasaporte</option>
        		<option value="LC" <%= u.getTipoDoc() != null && u.getTipoDoc().equals("LC") ? "selected" : "" %>>Libreta Cívica</option>
    		</select>
		</div>

        <div class="form-group">
            <label>Documento</label>
            <input type="text" name="documento" value="<%= u.getDocumento() != null ? u.getDocumento() : "" %>">
        </div>

        <div class="form-group">
            <label>Teléfono</label>
            <input type="text" name="telefono" value="<%= u.getTelefono() != null ? u.getTelefono() : "" %>">
        </div>

        <div class="form-group">
            <label>Rol del Usuario</label>
            <select name="rol" required>
                <option value="admin" <%= u.getRol().toString().equalsIgnoreCase("admin") ? "selected" : "" %>>Administrador</option>
                <option value="empleado" <%= u.getRol().toString().equalsIgnoreCase("empleado") ? "selected" : "" %>>Empleado</option>
                <option value="cliente" <%= u.getRol().toString().equalsIgnoreCase("cliente") ? "selected" : "" %>>Cliente</option>
            </select>
        </div>

        <div class="form-group" id="group-teatro">
            <label>ID del Teatro (Solo para empleados)</label>
            <input type="number" name="teatroID" value="<%= u.getTeatroID() != null ? u.getTeatroID() : "" %>">
        </div>

        <div class="button-group">
            <button type="submit" class="btn-save">Guardar Cambios</button>
            <a href="listaUsuarios" class="btn-cancel">Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>