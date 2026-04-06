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
    <title>Registro - Rosario en Cartel</title>
    <link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    
    <style>
    body {background: linear-gradient(135deg, #800000 0%, #000000 100%) !important; font-family: 'Montserrat', sans-serif; display: flex; flex-direction: column; min-height: 100vh; margin: 0;}

     .main {flex: 1; display: flex; align-items: center; justify-content: center; background: transparent !important;}

     .signup {background: transparent !important; padding: 0 !important; width: 100%;}

     .signup .container {background-color: #FDFCF0 !important; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); border: 2px solid #D9C202; padding: 40px !important; max-width: 1000px !important; margin: 40px auto !important;}

     .signup-content {background: transparent !important; box-shadow: none !important; border: none !important;}

     .form-title {font-family: 'Playfair Display', serif; color: #D9C202 !important; text-transform: uppercase; font-weight: 700; letter-spacing: 2px; border-bottom: 2px solid #800000; padding-bottom: 10px; margin-bottom: 30px; text-align: center;}
     
     .form-group label i { color: #800000 !important; }
        
     input {border-bottom: 2px solid #D9C202 !important; font-family: 'Montserrat', sans-serif; color: #2c3e50; background: transparent !important;}
     
     input:focus { border-bottom: 2px solid #800000 !important; }

     .form-submit {background-color: #D9C202 !important; color: #000000 !important; font-weight: bold; border: 2px solid #800000 !important; border-radius: 10px; text-transform: uppercase; padding: 12px 30px; cursor: pointer; transition: 0.3s;}
     
     .form-submit:hover { transform: scale(1.05); background-color: #f1e05a !important; }

     .signup-image-link {color: #800000 !important; font-weight: bold; text-decoration: none; display: block; margin-top: 20px; text-align: center;}
     
     .signup-image-link:hover { color: #D9C202 !important; text-decoration: underline; }

     .error-banner {background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 8px; border: 1px solid #f5c6cb; margin-bottom: 20px; font-weight: bold;}

     footer.footer {background-color: #2c3e50 !important; color: white !important; padding: 3rem 0 !important; width: 100%; margin-top: auto; text-align: center;}
     
     footer.footer .container-footer {background: transparent !important; border: none !important; box-shadow: none !important;}
     
     footer.footer .lead {font-size: 1.4rem !important; font-family: 'Montserrat', sans-serif; color: white !important; margin: 0;}
    
    </style>
</head>

<body>
    <div class="main">
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Crear Cuenta</h2>

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
                            <p id="error-msg-js" style="color: #800000; font-weight: bold; display: none; margin-bottom: 15px;">
                                ⚠️ Las contraseñas no coinciden.
                            </p>
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Confirmar Registro" />
                            </div>
                        </form>
                    </div>
                    
                    <div class="signup-image">
                        <figure><img id="registro" src="images/Registro imagen.jpg" alt="registro" style="border-radius: 15px; border: 2px solid #D9C202;"></figure>
                        <a href="login.jsp" class="signup-image-link">¿Ya tienes cuenta? Inicia sesión</a>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <footer class="footer">
        <div class="container-footer">
            <p class="lead">Rosario en Cartel &copy; 2026</p>
        </div>
    </footer>

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