<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Restablecer Contraseña - N-Note</title>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">
  <style>
    /* Mismos estilos base que en registro.jsp */
    * { box-sizing: border-box; }
    body {
      margin: 0; padding: 0; background-color: #000;
      font-family: 'Orbitron', sans-serif; color: #3A8E8C;
      display: flex; flex-direction: column; align-items: center;
      justify-content: center; height: 100vh;
    }
    .logo { position: absolute; top: 20px; left: 20px; font-size: 28px; font-weight: bold; text-shadow: 0 0 8px #3A8E8C; }
    .form-container {
      background-color: #000; border: 3px solid #3A8E8C; border-radius: 12px;
      box-shadow: 0 0 20px #3A8E8C; padding: 40px; width: 380px; text-align: center;
      display: flex; flex-direction: column; align-items: center;
    }
    h2 { margin-bottom: 20px; font-size: 1.8rem; color: #3A8E8C; text-shadow: 0 0 10px #3A8E8C; }
    input[type="password"] {
      width: 100%; padding: 12px; margin-bottom: 15px;
      background-color: #000; border: 2px solid #3A8E8C; border-radius: 10px;
      color: #fff; font-size: 1rem; outline: none;
    }
    button {
      width: 100%; padding: 12px; background-color: #000; color: #3A8E8C;
      border: 2px solid #3A8E8C; border-radius: 8px 20px 8px 20px;
      cursor: pointer; font-size: 1.1rem; text-shadow: 0 0 5px #3A8E8C;
    }
    button:hover { background-color: #3A8E8C; color: black; box-shadow: 0 0 15px #3A8E8C; }
    .error-container { margin-bottom: 15px; }
    .error, .password-error { color: red; font-size: 0.9rem; margin-bottom: 10px; }
    .password-error { display: none; }
  </style>
</head>
<body>

  <div class="logo">N-Note</div>

  <div class="form-container">
    <h2>Restablecer Contraseña</h2>

    <div class="error-container">
      <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
      <% } %>
      <span id="password-error" class="password-error">Las contraseñas no coinciden</span>
    </div>

    <form action="SvRestablecer" method="post" onsubmit="return validatePasswords()" autocomplete="off">
      <input type="hidden" name="token" value="<%= request.getParameter("token") %>" />
      <input type="password" id="nuevaClave" name="nuevaClave" placeholder="Nueva contraseña" required />
      <input type="password" id="confirmarClave" name="confirmarClave" placeholder="Confirmar contraseña" required />
      <button type="submit">Restablecer</button>
    </form>
  </div>

  <script>
    function validatePasswords() {
      var clave = document.getElementById("nuevaClave").value;
      var confirmar = document.getElementById("confirmarClave").value;
      var error = document.getElementById("password-error");

      if (clave !== confirmar) {
        error.style.display = "block";
        return false;
      } else {
        error.style.display = "none";
        return true;
      }
    }
  </script>

</body>
</html>