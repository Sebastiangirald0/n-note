<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registro - N-Note</title>
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
      background-color: #000;
      border: 3px solid #3A8E8C;
      border-radius: 12px;
      box-shadow: 0 0 20px #3A8E8C;
      padding: 40px;
      width: 380px;
      text-align: center;
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

    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 15px;
      background-color: #000;
      border: 2px solid #3A8E8C;
      border-radius: 10px;
      color: #fff;
      font-family: 'Orbitron', sans-serif;
      font-size: 1rem;
      outline: none;
      transition: box-shadow 0.3s;
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus {
      box-shadow: 0 0 10px #3A8E8C;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #000;
      color: #3A8E8C;
      border: 2px solid #3A8E8C;
      border-radius: 8px 20px 8px 20px;
      cursor: pointer;
      font-size: 1.1rem;
      text-shadow: 0 0 5px #3A8E8C;
      transition: 0.3s ease;
    }

    button:hover {
      background-color: #3A8E8C;
      color: black;
      box-shadow: 0 0 15px #3A8E8C;
    }

    .login-link {
      margin-top: 15px;
      display: block;
      text-decoration: none;
      color: #3A8E8C;
      font-size: 0.9rem;
      font-weight: bold;
      transition: color 0.2s;
    }

    .login-link:hover {
      color: #66fffa;
    }

    /* Contenedor común para los errores */
    .error-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 15px;
    }

    .error, .password-error {
      color: red;
      font-size: 0.9rem;
      margin-bottom: 10px;
    }

    .password-error {
      display: none;
    }

    /* Estilo para los campos de autocompletado */
    input:-webkit-autofill {
      background-color: #000 !important;
      color: #fff !important;
      font-family: 'Orbitron', sans-serif !important;
    }
  </style>
</head>
<body>

  <div class="logo">N-Note</div>

  <div class="form-container">
    <h2>REGISTRO</h2>

    <!-- Contenedor para los mensajes de error -->
    <div class="error-container">
      <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
      <% } %>
      <span id="password-error" class="password-error">Las contraseñas no coinciden</span>
    </div>

    <form action="SvRegistro" method="post" onsubmit="return validatePasswords()" autocomplete="off">
      <input type="text" name="nombre" placeholder="Nombre de usuario" required autocomplete="off" />
      <input type="email" name="correo" placeholder="Correo electrónico" required autocomplete="off" />
      <input type="password" id="clave" name="clave" placeholder="Contraseña" required autocomplete="new-password" />
      <input type="password" id="confirmar" name="confirmar" placeholder="Confirmar contraseña" required autocomplete="new-password" />
      <button type="submit">REGISTRARSE</button>
    </form>

    <a href="index.jsp" class="login-link">¿Ya tienes cuenta? Inicia sesión</a>
  </div>

  <script>
    function validatePasswords() {
      var password = document.getElementById("clave").value;
      var confirmPassword = document.getElementById("confirmar").value;
      var errorMessage = document.getElementById("password-error");

      if (password !== confirmPassword) {
        errorMessage.style.display = "block";
        return false;
      } else {
        errorMessage.style.display = "none";
        return true;
      }
    }
  </script>

</body>
</html>
