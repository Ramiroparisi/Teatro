<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ingreso - Teatros</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="main">
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure><img src="images/signin-image.jpg" alt="teatro"></figure>
                        <a href="registration.jsp" class="signup-image-link">Crear una cuenta</a>
                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Iniciar Sesión</h2>
                        <form method="POST" action="${pageContext.request.contextPath}/login" class="register-form" id="login-form">
							<div class="form-group">
    							<label for="username"><i class="zmdi zmdi-account material-icons-name"></i></label>
    							<input type="text" name="txtUsuario" id="username" placeholder="Email o DNI" required/>
							</div>
                            <div class="form-group">
                                <label for="password"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="txtPassword" id="password" placeholder="Contraseña" required/>
                            </div>
                            
                            <% if(request.getAttribute("error") != null) { %>
                                <p style="color: red; font-size: 12px;"><%= request.getAttribute("error") %></p>
                            <% } %>

                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Entrar" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>