<%@page import="logica.Usuario"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Supongamos que el nombre de usuario está guardado en sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Panel de Notas - N-note</title>
        <style>
            body {
                margin: 0;
                background-color: #f0f0f0;
                font-family: Arial, sans-serif;
                color: #3A8E8C;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ffffff;
                padding: 10px 40px; /* menor altura */
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }


            .logo {
                font-style: italic;
                font-weight: bold;
                font-size: 24px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .username {
                font-weight: bold;
            }

            .logout-btn {
                padding: 10px 20px;
                background-color: #3A8E8C;
                color: white;
                border: none;
                border-radius: 20px;
                cursor: pointer;
            }

            .container {
                padding: 30px 40px;
            }

            .actions {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                /* Podrías reducir el gap si es necesario */
            }

            .add-btn {
                padding: 10px 20px;
                background-color: #3A8E8C;
                color: white;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                font-size: 20px; /* Opcional, para hacer el "+" más visible */
            }

            .grid-notas {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }


            .nota {
                width: 220px; /* ancho fijo para uniformidad */
                background-color: #d6eaea;
                border: 2px solid #3A8E8C;
                border-radius: 15px;
                padding: 15px;
                position: relative;
                max-height: 200px;
                overflow: hidden;
                cursor: pointer;
                transition: transform 0.1s ease-in-out;
            }
            
            .nota:hover {
                transform: scale(1.02);
            }

            .nota h3 {
                margin: 0;
                font-size: 16px;
                border-bottom: 1px solid #3A8E8C;
                padding-bottom: 5px;
            }

            .nota p {
                font-size: 14px;
                margin-top: 10px;
                margin-bottom: 5px;
                max-height: 60px; /* límite de altura */
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .nota small {
                font-size: 12px;
                color: #666;
            }

            .nota .delete-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                background-color: black;
                color: white;
                border: none;
                border-radius: 50%;
                width: 25px;
                height: 25px;
                cursor: pointer;
                font-weight: bold;
            }

            .add-btn {
                background-color: #3A8E8C;
                color: white;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                font-size: 24px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }



        </style>
    </head>
    <body>

        <div class="header">
            <div class="logo">N-note</div>
            <div><h2>Mis notas</h2></div>
            <div class="user-info">
                <span class="username"><%= usuario.getNombre()%></span>
                <form action="SvCerrarSesion" method="post" style="margin: 0;">
                    <button type="submit" class="logout-btn">Cerrar sesión</button>
                </form>
            </div>
        </div>

        <div class="container">

            <!-- Ventana Modal para Agregar o Editar Nota -->
            <div id="modalNota" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); justify-content:center; align-items:center; z-index:1000;">
                <div style="background:#fff; padding:30px; border-radius:15px; width:300px; position:relative;">
                    <h3 id="modalTitulo">Agregar nueva nota</h3>
                    <form id="formNota" method="post">
                        <input type="hidden" name="idNota" id="idNota">
                        <input type="text" name="titulo" id="tituloNota" placeholder="Título" required style="width:100%; margin-bottom:10px; padding:8px; border-radius:10px; border:1px solid #ccc;">
                        <textarea name="contenido" id="contenidoNota" placeholder="Contenido" required style="width:100%; height:80px; margin-bottom:10px; padding:8px; border-radius:10px; border:1px solid #ccc;"></textarea>
                        <button type="submit" style="background:#3A8E8C; color:white; padding:10px; border:none; border-radius:10px; width:100%;">Guardar</button>
                    </form>
                    <button onclick="cerrarModal()" style="position:absolute; top:10px; right:10px; background:red; color:white; border:none; border-radius:50%; width:25px; height:25px;">×</button>
                </div>
            </div>


            <div class="actions">
                <button class="add-btn" onclick="abrirModal()">+</button>         
            </div>

            <div class="grid-notas">
                <!-- Mostrar notas dinámicamente -->
                <c:forEach var="nota" items="${sessionScope.listaNotas}">
                    <div class="nota" onclick="editarNota('${nota.idNota}', '${nota.nombreNota}', `${nota.contenidoNota}`)">
                        <form action="SvEliminarNota" method="post" style="position:absolute; top:10px; right:10px; z-index: 10;">
                            <input type="hidden" name="idNota" value="${nota.idNota}" />
                            <button type="submit" class="delete-btn" onclick="event.stopPropagation();">×</button>
                        </form>
                        <h3>${nota.nombreNota}</h3>
                        <p>${nota.contenidoNota}</p>
                        <small>Modificada: ${nota.fechaEdicion}</small>
                    </div>
                </c:forEach>

            </div>
        </div>

    </body>

    <script>
        function abrirModal() {
            document.getElementById("modalTitulo").innerText = "Agregar nueva nota";
            document.getElementById("formNota").action = "SvNuevaNota";
            document.getElementById("idNota").value = "";
            document.getElementById("tituloNota").value = "";
            document.getElementById("contenidoNota").value = "";
            document.getElementById("modalNota").style.display = "flex";
        }

        function editarNota(id, titulo, contenido) {
            document.getElementById("modalTitulo").innerText = "Editar nota";
            document.getElementById("formNota").action = "SvEditarNota";
            document.getElementById("idNota").value = id;
            document.getElementById("tituloNota").value = titulo;
            document.getElementById("contenidoNota").value = contenido;
            document.getElementById("modalNota").style.display = "flex";
        }

        function cerrarModal() {
            document.getElementById("modalNota").style.display = "none";
        }
    </script>

</html>
