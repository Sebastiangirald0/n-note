<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Inicio de sesión - N-Note</title>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">

  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      padding: 0;
      background-color: #000;
      font-family: 'Orbitron', sans-serif;
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
      font-size: 28px;
      font-weight: bold;
      text-shadow: 0 0 8px #3A8E8C;
    }

    .form-container {
      background-color: #000; /* Cambiado a negro puro */
      border: 3px solid #3A8E8C;
      border-radius: 12px;
      box-shadow: 0 0 20px #3A8E8C;
      padding: 40px;
      width: 380px;
      text-align: center;
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    h2 {
      margin: 0 0 20px 0;
      font-size: 1.8rem;
      color: #3A8E8C;
      text-shadow: 0 0 10px #3A8E8C;
    }

    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 15px;
      background-color: #000; /* Negro puro */
      border: 2px solid #3A8E8C;
      border-radius: 10px;
      color: #fff;
      font-family: 'Orbitron', sans-serif;
      font-size: 1rem;
      outline: none;
      transition: box-shadow 0.3s;
    }

    input[type="email"]:focus,
    input[type="password"]:focus {
      box-shadow: 0 0 10px #3A8E8C;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #000; /* Negro puro */
      color: #3A8E8C;
      border: 2px solid #3A8E8C;
      border-radius: 8px 20px 8px 20px;
      cursor: pointer;
      font-size: 1.1rem;
      text-shadow: 0 0 5px #3A8E8C;
      transition: 0.3s ease;
      font-family: 'Orbitron', sans-serif;
    }

    button:hover {
      background-color: #3A8E8C;
      color: black;
      box-shadow: 0 0 15px #3A8E8C;
    }

    .forgot,
    .register {
      display: block;
      margin-top: 12px;
      color: #3A8E8C;
      font-size: 0.9rem;
      text-decoration: none;
      transition: color 0.2s;
    }

    .register {
      font-weight: bold;
    }

    .forgot:hover,
    .register:hover {
      color: #66fffa;
    }

    .error {
      color: red;
      margin-bottom: 10px;
    }

    /* Estilo para los campos de autocompletado */
    input:-webkit-autofill {
      background-color: #000 !important;
      color: #fff !important;
      font-family: 'Orbitron', sans-serif !important;
      box-shadow: 0 0 5px #3A8E8C !important;
    }

    /* Estilos adicionales para el fondo blanco de los campos autocompletados */
    input:-webkit-autofill:focus {
      background-color: #000 !important;
      color: #fff !important;
    }
  </style>
</head>
<body>

  <div class="logo">N-Note</div>

  <div class="form-container">
    <h2>INICIO DE SESIÓN</h2>

    <% if (request.getAttribute("error") != null) {%>
    <p class="error"><%= request.getAttribute("error")%></p>
    <% }%>

    <!-- Agregar el atributo autocomplete="off" al formulario -->
    <form action="SvInicioSesion" method="post" autocomplete="off">
      <input type="email" name="correo" placeholder="Correo" required autocomplete="off" />
      <input type="password" name="clave" placeholder="Contraseña" required autocomplete="off" />
      <button type="submit">INICIAR</button>
    </form>

    <a href="Recuperar.jsp" class="forgot">¿Olvidaste tu contraseña?</a>
    <a href="Registro.jsp" class="register">Ir a registro</a>
  </div>

</body>
</html>
