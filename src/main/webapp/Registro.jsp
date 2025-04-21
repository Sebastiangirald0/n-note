
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registro - N-note</title>
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
      width: 320px;
    }

    h2 {
      margin-bottom: 20px;
    }

    input[type="text"],
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

    .login-link {
      margin-top: 15px;
      display: block;
      text-decoration: none;
      color: #3A8E8C;
      font-size: 14px;
    }

  </style>
</head>
<body>
  <div class="logo">N-note</div>

  <div class="form-container">
    <h2>Registro</h2>
    <form action="SvRegistro" method="post">
      <input type="text" name="nombre" placeholder="Nombre completo" required />
      <input type="email" name="correo" placeholder="Correo electrónico" required />
      <input type="password" name="clave" placeholder="Contraseña" required />
      <input type="password" name="confirmar" placeholder="Confirmar contraseña" required />
      <button type="submit">Registrarse</button>
    </form>
    <a href="index.jsp" class="login-link">¿Ya tienes cuenta? Inicia sesión</a>
  </div>
</body>
</html>
