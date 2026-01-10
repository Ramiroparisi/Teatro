<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Usuario" %>
<%

    Usuario uErr = (Usuario) request.getAttribute("usuarioFallido");
    
    String nombre = (uErr != null) ? uErr.getNombre() : "";
    String apellido = (uErr != null) ? uErr.getApellido() : "";
    String email = (uErr != null) ? uErr.getMail() : "";
    String doc = (uErr != null) ? uErr.getDocumento() : "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Teatros</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <link rel="stylesheet" href="css/style.css">
    <style>
        .error-banner {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            border: 1px solid #f5c6cb;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="main">
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Registro de Cliente</h2>


                        <% if (request.getAttribute("error") != null) { %>
                            <div class="error-banner">
                                <i class="zmdi zmdi-alert-circle"></i>
                                <span><%= request.getAttribute("error") %></span>
                            </div>
                        <% } %>

                        <form method="POST" action="registro" class="register-form" id="register-form" onsubmit="return validarPassword()">
                            
                            <div class="form-group">
                                <label for="nombre"><i class="zmdi zmdi-account"></i></label>
                                <input type="text" name="nombre" id="nombre" placeholder="Nombre" value="<%= nombre %>" required/>
                            </div>
                            
                            <div class="form-group">
                                <label for="apellido"><i class="zmdi zmdi-account"></i></label>
                                <input type="text" name="apellido" id="apellido" placeholder="Apellido" value="<%= apellido %>" required/>
                            </div>
                            
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Correo Electrónico" value="<%= email %>" required/>
                            </div>
                            
                            <div class="form-group">
                                <label for="documento"><i class="zmdi zmdi-assignment-account"></i></label>
                                <input type="text" name="documento" id="documento" placeholder="Número de Documento" value="<%= doc %>" required/>
                            </div>
                            
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pass" id="pass" placeholder="Contraseña" required/>
                            </div>
                            
                            <div class="form-group">
                                <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="re_pass" id="re_pass" placeholder="Repetir contraseña" required/>
                            </div>
                            
                            <p id="error-msg-js" style="color: red; font-size: 13px; display: none; margin-top: -15px; margin-bottom: 15px;">
                                ⚠️ Las contraseñas no coinciden.
                            </p>

                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Registrarse" />
                            </div>
                        </form>
                    </div>
                    
                    <div class="signup-image">
                        <figure><img id="registro" src="images/Registro imagen.jpg" alt="registro"></figure>
                        <a href="login.jsp" class="signup-image-link">Ya soy miembro</a>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <script>

        function validarPassword() {
            var pass = document.getElementById("pass").value;
            var re_pass = document.getElementById("re_pass").value;
            var errorMsg = document.getElementById("error-msg-js");

            if (pass !== re_pass) {
                errorMsg.style.display = "block"; 
                return false; 
            }
            return true; 
        }
    </script>
</body>
</html>