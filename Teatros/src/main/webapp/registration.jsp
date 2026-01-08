<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Teatros</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="main">
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Registro de Cliente</h2>
                        <form method="POST" action="registro" class="register-form" id="register-form" onsubmit="return validarPassword()">
                            <div class="form-group">
                                <label for="nombre"><i class="zmdi zmdi-account"></i></label>
                                <input type="text" name="nombre" placeholder="Nombre" required/>
                            </div>
                            <div class="form-group">
                                <label for="apellido"><i class="zmdi zmdi-account"></i></label>
                                <input type="text" name="apellido" placeholder="Apellido" required/>
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" placeholder="Correo Electrónico" required/>
                            </div>
                            <div class="form-group">
                                <label for="doc"><i class="zmdi zmdi-assignment-account"></i></label>
                                <input type="text" name="documento" placeholder="Número de Documento" required/>
                            </div>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pass" id="pass" placeholder="Contraseña" required/>
                            </div>
                            <div class="form-group">
                                <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="re_pass" id="re_pass" placeholder="Repetir contraseña" required/>
                            </div>
                            
                            <p id="error-msg" style="color: red; font-size: 13px; display: none; margin-top: -15px; margin-bottom: 15px;">
                                Las contraseñas no coinciden.
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
            var alertMsg = document.getElementById("error-msg");

            if (pass !== re_pass) {
                alertMsg.style.display = "block"; 
                return false;
            }
            return true; 
        }
    </script>
</body>
</html>