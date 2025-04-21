<%-- 
    Document   : InicioSecion
    Created on : 17/04/2025, 6:39:11 p. m.
    Author     : NAISHA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Inicio de sesión - N-note</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f0f0f0;
      font-family: Arial, sans-serif;
      color: #3A8E8C;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }

    .logo {
      position: absolute;
      top: 20px;
      left: 20px;
      font-style: italic;
      font-size: 24px;
      font-weight: bold;
    }

    .form-container {
      background-color: #ffffff;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      text-align: center;
      width: 300px;
    }

    h2 {
      margin-bottom: 20px;
    }

    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 2px solid #3A8E8C;
      border-radius: 20px;
      font-size: 14px;
      outline: none;
    }

    button {
      width: 100%;
      padding: 10px;
      background-color: #3A8E8C;
      color: white;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      font-size: 16px;
      margin-top: 10px;
      transition: background 0.3s;
    }

    button:hover {
      background-color: #316f6d;
    }

    .forgot,
    .register {
      margin-top: 15px;
      display: block;
      text-decoration: none;
      color: #3A8E8C;
      font-size: 14px;
    }

    .register {
      font-weight: bold;
    }
  </style>
</head>
<body>
  <div class="logo">N-note</div>

  <div class="form-container">
    <h2>Inicio de sesión</h2>
    
    <% if (request.getAttribute("error") != null) {%>
    <p style="color:red;"><%= request.getAttribute("error")%></p>
    <% }%>

    <form action="SvInicioSesion" method="post">
      <input type="email" name="correo" placeholder="correo" required />
      <input type="password" name="clave" placeholder="contraseña" required />
      <button type="submit">Iniciar</button>
    </form>
    <a href="#" class="forgot">¿Olvidaste tu contraseña?</a>
    <a href="Registro.jsp" class="register">Ir a registro</a>
  </div>
</body>
</html>
