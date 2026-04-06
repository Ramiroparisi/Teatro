<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ingreso - Teatros</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
	<link rel="icon" type="image/png" href="images/icons8-teatro-48.png" />
    <link rel="stylesheet" href="css/style.css">

	<style>
    body {background: linear-gradient(135deg, #800000 0%, #000000 100%) !important; font-family: 'Montserrat', sans-serif; display: flex; flex-direction: column; min-height: 100vh; margin: 0;}
    
    .main {flex: 1; display: flex; align-items: center; justify-content: center; background: transparent !important;}

    .sign-in {background: transparent !important; padding: 0 !important; width: 100%;}

    .sign-in .container {background-color: #FDFCF0 !important; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); border: 2px solid #D9C202; padding: 40px !important; max-width: 900px !important; margin: 0 auto !important;}

    .signin-content {background: transparent !important; box-shadow: none !important; border: none !important; padding: 0 !important;}

    .form-title {font-family: 'Playfair Display', serif;color: #D9C202 !important; text-transform: uppercase; font-weight: 700; letter-spacing: 2px; border-bottom: 2px solid #800000; padding-bottom: 15px;display: flex; align-items: center; justify-content: center; gap: 10px;}
        
    .form-title::before { content: '🎭'; font-size: 1.5rem;}

    .form-group label i { color: #800000 !important; }
    
    input {border-bottom: 2px solid #D9C202 !important; font-family: 'Montserrat', sans-serif; color: #2c3e50;}

    .form-submit {background-color: #D9C202 !important; color: #000000 !important; font-weight: bold; border: 2px solid #800000 !important; border-radius: 10px; text-transform: uppercase; transition: 0.3s; cursor: pointer;}
    
    .form-submit:hover { transform: scale(1.05); background-color: #f1e05a !important; }

	footer.footer {background-color: #2c3e50 !important; color: white !important; padding: 4rem 0 !important; width: 100%; margin-top: auto; border: none !important; display: flex; align-items: center; justify-content: center;}

    footer.footer .container {background: transparent !important; background-color: transparent !important; border: none !important; box-shadow: none !important; padding: 0 !important; max-width: 100% !important; text-align: center !important;}
    
	footer.footer .lead {font-size: 1.4rem !important; font-family: 'Montserrat', sans-serif; font-weight: 400; margin: 0; color: white !important;}
	
	.registration-success-banner {background-color: #D9C202 !important; color: #4a0000 !important; border: 2px solid #800000; padding: 15px; border-radius: 12px; margin-bottom: 25px; display: flex; align-items: center; font-size: 0.95rem; box-shadow: 0 4px 10px rgba(0,0,0,0.2);}

    .registration-success-banner i { font-size: 1.5rem; color: #800000;}
	</style>

</head>
<body>
    <div class="main">
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure><img src="images/teatro.jpg" alt="teatro" style="border-radius: 20px"></figure>
                        <a href="registration.jsp" class="signup-image-link"; >Crear una cuenta</a>
                    </div>

                    <div class="signin-form">
                    <% String status = request.getParameter("status");
    				if ("registration_success".equals(status)) {%>
    						<div class="registration-success-banner">
        						<i class="fas fa-star me-2"></i>
        					<div>
            					<strong>¡Bienvenido!</strong><br>
            					Tu cuenta ha sido creada. Ya puedes iniciar sesión.
        					</div>
    					</div> <% } %>
    					
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
    <footer class="footer text-center">
        <div class="container">
        	<p class="lead mb-0">Rosario en Cartel &copy; 2026</p>
        </div>
    </footer>
</body>
</html>