<%@page import="logica.Usuario"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
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
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
                justify-content: flex-start;
                height: 100vh;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #000;
                padding: 10px 40px;
                width: 100%;
                box-shadow: 0 2px 10px #3A8E8C;
                height: 60px;
            }

            .logo {
                font-weight: bold;
                font-size: 28px;
                text-shadow: 0 0 8px #3A8E8C;
            }

            .title-container {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .title-container h2 {
                font-size: 1.8rem;
                font-weight: bold;
                color: #3A8E8C;
                text-shadow: 0 0 8px #3A8E8C;
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
                font-size: 1rem;
                text-shadow: 0 0 5px #3A8E8C;
                transition: background-color 0.3s;
            }

            .logout-btn:hover {
                background-color: #66fffa;
            }

            .container {
                padding-top: 30px;
                padding-bottom: 30px;
                padding-left: 40px;
                padding-right: 0px;
                width: 100%;
                margin-top: 20px;
                overflow-y: scroll;
                height: calc(100vh - 100px);
                scrollbar-width: thin;
                scrollbar-color: #3A8E8C transparent;
            }

            .nota {
                background-color: #000;
                border: 2px solid #3A8E8C;
                box-shadow: 0 0 10px #3A8E8C;
                border-radius: 12px;
                padding: 20px;
                width: 100%;
                max-width: 280px;
                color: #fff;
                font-family: 'Orbitron', sans-serif;
                position: relative;
                transition: transform 0.3s, box-shadow 0.3s;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                word-break: break-word;
                overflow: hidden;
                height: 220px; /* 👉 Altura fija para todas las notas */
            }
            .nota:hover {
                transform: scale(1.02);
                box-shadow: 0 0 12px #3A8E8C;
            }

            .delete-x {
                position: absolute;
                top: 10px;
                right: 20px;
                color: #3A8E8C;
                font-size: 18px; /* Reducción en el tamaño para evitar el solapamiento */
                font-weight: bold;
                cursor: pointer;
                text-shadow: 0 0 8px #3A8E8C, 0 0 15px #3A8E8C;
                transition: 0.3s ease;
            }

            .delete-x:hover {
                color: #66fffa;
                text-shadow: 0 0 12px #66fffa, 0 0 20px #66fffa;
            }


            .grid-notas {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 20px;
                padding: 0 40px;
                justify-items: center;
            }


            .nota h3 {
                margin: 0;
                font-size: 14px;
                border-bottom: 1px solid #3A8E8C;
                padding-bottom: 5px;
                color: #3A8E8C;
                ;

                /* 👇 Aquí vienen los cambios */
                max-width: 85%; /* Ajusta este valor si es necesario */
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .nota p {
                font-size: 14px;
                margin-top: 10px;

                margin-bottom: 5px;
                overflow-y: auto; /* 👉 Scroll solo si el contenido es mayor */
                max-height: 100px; /* 👉 Limita el espacio visual para el contenido */
            }

            .nota small {
                font-size: 12px;
                color: #666;
                margin-top: auto; /* 👈 esto empuja la fecha al fondo */
                margin-bottom: 0;
                align-self: flex-end;
            }

            @media screen and (max-width: 768px) {
                .grid-notas {
                    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                }
            }

            @media screen and (max-width: 480px) {
                .grid-notas {
                    grid-template-columns: 1fr;
                    padding: 0 10px;
                }
            }


            #modalNota {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            #modalNota div {
                background-color: #000;
                padding: 30px;
                border-radius: 15px;
                width: 500px;
                height: 450px; /* altura */
                text-align: center;
                border: 2px solid #3A8E8C;
                box-shadow: 0 0 10px #3A8E8C;
            }

            #modalNota h3 {
                margin-top: -10px;
                font-size: 1.5rem;
                color: #3A8E8C;

            }






            .neon-text {
                color: #3A8E8C; /* o el color que uses para el neón */
                text-shadow: 0 0 5px #3A8E8C, 0 0 10px #3A8E8C, 0 0 20px #3A8E8C;
                font-family: 'Orbitron', sans-serif;
            }

            input[type="text"], textarea {
                width: 100%;
                background-color: transparent;
                color: #3A8E8C;
                border: none;
                border-bottom: 2px solid #3A8E8C;
                font-size: 1rem;
                font-family: 'Orbitron', sans-serif; /* ✅ Añadido */
                outline: none;
                margin-bottom: 20px;
                padding: 10px 5px;
                box-shadow: none;
                transition: border-color 0.3s, box-shadow 0.3s;
                min-height: 40px;
            }


            textarea {
                min-height: 220px; /* altura fija para textareas */
                color: white;
                resize: none; /* para bloquear el estiramiento */
            }

            input[type="text"]:focus, textarea:focus {
                border-bottom: 2px solid #66fffa;
                box-shadow: none;
            }

            button {
                width: 100%;
                padding: 8px;
                background-color: #000;
                color: #3A8E8C;
                border: 2px solid #3A8E8C;
                border-radius: 8px 20px 8px 20px;
                cursor: pointer;
                font-size: 0.9rem;
                text-shadow: 0 0 5px #3A8E8C;
                transition: 0.3s ease;
                font-family: 'Orbitron', sans-serif;
            }

            button:hover {
                background-color: #3A8E8C;
                color: black;
                box-shadow: 0 0 15px #3A8E8C;
            }

            .sidebar-tech-neon {
                position: fixed;
                top: 63px;
                left: 0;
                width: 60px;
                height: calc(100vh - 60px);
                background-color: #000;
                box-shadow: 2px 0 10px #3A8E8C;
                z-index: 999;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-top: 20px;
            }

            .sidebar-tech-neon .add-icon {
                font-size: 50px;
                color: #3A8E8C;
                text-shadow: 0 0 8px #3A8E8C, 0 0 16px #3A8E8C;
                margin-top: 5px; /* Ajusta el margen superior */
                margin-bottom: 40px;
                cursor: pointer;
                transition: transform 0.2s, text-shadow 0.2s;
                border: none;
                background: none;
                user-select: none;
            }

            .sidebar-tech-neon .add-icon:hover {
                transform: scale(1.2);
                text-shadow:
                    0 0 10px #3A8E8C,
                    0 0 20px #3A8E8C,
                    0 0 30px #3A8E8C,
                    0 0 40px #3A8E8C; /* 👈 más capas = efecto más intenso */
            }
            .container::-webkit-scrollbar {
                width: 10px;
            }

            .container::-webkit-scrollbar-track {
                background: transparent;
                border-left: 1px solid #3A8E8C;
            }

            .container::-webkit-scrollbar-thumb {
                background-color: #3A8E8C;
                border-radius: 50%;
                border: 2px solid #000;
                box-shadow: 0 0 10px #3A8E8C, 0 0 20px #3A8E8C;
            }

            .container::-webkit-scrollbar-thumb:hover {
                background-color: #66fffa;
                box-shadow: 0 0 12px #66fffa, 0 0 25px #66fffa;
            }

            .search-icon {
                font-size: 24px;
                color: #3A8E8C;
                text-shadow: 0 0 8px #3A8E8C, 0 0 16px #3A8E8C;
                margin-bottom: 40px;
                cursor: pointer;
                transition: transform 0.2s, text-shadow 0.2s;
            }

            .search-icon:hover {
                transform: scale(1.2);
                text-shadow:
                    0 0 10px #3A8E8C,
                    0 0 20px #3A8E8C,
                    0 0 30px #3A8E8C;
            }


        </style>
    </head>
    <body>

        <!-- Barra lateral izquierda -->
        <div class="sidebar-tech-neon">
            <div class="add-icon" onclick="abrirModal()">+</div>
            <div class="search-icon" onclick="abrirBuscador()">
                <i class="fas fa-search"></i>
            </div>
            <div class="search-icon" onclick="quitarFiltro()" style="margin-top: 10px;">
                <i class="fas fa-filter-circle-xmark"></i>
            </div>
            
        </div>

        <!-- Modal de búsqueda -->
        <div id="modalBuscar" style="display: none; position: fixed; top: 0; left: 0;
width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7);
justify-content: center; align-items: center; z-index: 1000;"
             onclick="cerrarSiClickFuera(event)">
            <div id="contenidoModal" style="background-color: #000; padding: 30px; border-radius: 15px; width: 400px;
    border: 2px solid #3A8E8C; box-shadow: 0 0 10px #3A8E8C; text-align: center;">
                <h3 class="neon-text">Buscar nota</h3>
                <input type="text" id="inputBuscar" placeholder="Nombre de la nota..." />
                <button onclick="cerrarYAplicarFiltro()" style="margin-top: 15px;">Aplicar filtro</button>
            </div>
        </div>

        <div class="header">
            <div class="logo">N-note</div>
            <div class="title-container">
                <h2>Mis notas</h2>
            </div>
            <div class="user-info">
                <span class="username"><%= usuario.getNombre()%></span>
                <form action="SvCerrarSesion" method="post" style="width: 200px;">
                    <button type="submit">CERRAR SESIÓN</button>
                </form>
            </div>
        </div>

        <div class="container">

            <!-- Modal Agregar/Editar -->
            <div id="modalNota">
                <div>
                    <h3 id="modalTitulo">Agregar nueva nota</h3>
                    <form id="formNota" method="post">
                        <input type="hidden" name="idNota" id="idNota">
                        <input type="text" name="titulo" id="tituloNota"  placeholder="Título" required>

                        <textarea name="contenido" id="contenidoNota" placeholder="Contenido" required></textarea>
                        <button type="submit">Guardar</button>
                    </form>

                </div>
            </div>

            <!-- Modal de confirmación para eliminar -->
            <div id="modalConfirmacion" style="display: none; position: fixed; top: 0; left: 0;
                 width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7);
                 justify-content: center; align-items: center; z-index: 1000;">
                <div style="background-color: #000; padding: 30px; border-radius: 15px; width: 400px;
                     border: 2px solid #3A8E8C; box-shadow: 0 0 10px #3A8E8C; text-align: center;">
                    <h3 >¿Deseas eliminar esta nota?</h3>
                    <p style="color: white; margin: 20px 0;">Esta acción no se puede deshacer.</p>
                    <button onclick="confirmarEliminacion()" style="margin-bottom: 10px;">Sí, eliminar</button>
                    <button onclick="cancelarEliminacion()">Cancelar</button>
                </div>
            </div>

            <div class="grid-notas">
                <c:forEach var="nota" items="${sessionScope.listaNotas}">
                    <div class="nota" onclick="editarNota('${nota.idNota}', '${nota.nombreNota}', '${nota.contenidoNota}')">
                        <span class="delete-x" onclick="eliminarNota(event, '${nota.idNota}')">×</span>
                        <h3>${nota.nombreNota}</h3>
                        <p>${nota.contenidoNota}</p>
                        <small>Modificada: 
                            <fmt:formatDate value="${nota.fechaEdicion}" pattern="dd/MM/yyyy hh:mm a" />
                        </small>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- ✅ Formulario oculto para eliminar nota por POST -->
        <form id="formEliminar" method="post" action="SvEliminarNota" style="display:none;">
            <input type="hidden" name="idNota" id="inputIdNota">
        </form>

        <script>
            let idNotaAEliminar = null;

            function eliminarNota(event, idNota) {
                event.stopPropagation();
                idNotaAEliminar = idNota;
                document.getElementById("modalConfirmacion").style.display = "flex";
            }

            function confirmarEliminacion() {
                document.getElementById("inputIdNota").value = idNotaAEliminar;
                document.getElementById("formEliminar").submit();
            }

            function cancelarEliminacion() {
                idNotaAEliminar = null;
                document.getElementById("modalConfirmacion").style.display = "none";
            }
        </script>

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

            // Función para cerrar el modal al hacer clic fuera del contenido
            function cerrarModal() {
                document.getElementById("modalNota").style.display = "none";
            }

            // Agregar listener para cerrar el modal al hacer clic fuera del área de contenido
            document.getElementById("modalNota").addEventListener("click", function (event) {
                // Verifica si el clic fue fuera del área de contenido
                if (event.target === this) {
                    cerrarModal();  // Cierra el modal
                }
            });
        </script>


        <script>
            function abrirBuscador() {
                document.getElementById("modalBuscar").style.display = "flex";
            }

            function cerrarBuscador() {
                document.getElementById("modalBuscar").style.display = "none";
            }

            function cerrarYAplicarFiltro() {
                filtrarNotas(); // Solo aquí se aplica el filtro
                cerrarBuscador();
            }

            function cerrarSiClickFuera(event) {
                const modal = document.getElementById("contenidoModal");
                // Si el clic NO fue dentro del contenido del modal
                if (!modal.contains(event.target)) {
                    cerrarBuscador(); // Se cierra sin aplicar filtro
                }
            }

            function filtrarNotas() {
                const filtro = document.getElementById("inputBuscar").value.toLowerCase();
                const notas = document.querySelectorAll(".nota");

                notas.forEach(nota => {
                    const titulo = nota.querySelector("h3").textContent.toLowerCase();
                    nota.style.display = titulo.includes(filtro) ? "block" : "none";
                });
            }

            function quitarFiltro() {
                document.getElementById("inputBuscar").value = "";
                filtrarNotas();
            }
        </script>
            
        </script>

    </body>
</html>