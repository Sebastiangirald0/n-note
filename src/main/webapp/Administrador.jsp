<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@page import="logica.Usuario"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

            .sidebar-tech-neon .add-icon,
            .search-icon {
                font-size: 24px;
                color: #3A8E8C;
                text-shadow: 0 0 8px #3A8E8C, 0 0 16px #3A8E8C;
                margin-bottom: 40px;
                cursor: pointer;
                transition: transform 0.2s, text-shadow 0.2s;
            }

            .sidebar-tech-neon .add-icon {
                font-size: 50px;
                margin-top: 5px;
            }

            .sidebar-tech-neon .add-icon:hover,
            .search-icon:hover {
                transform: scale(1.2);
                text-shadow: 0 0 10px #3A8E8C, 0 0 20px #3A8E8C, 0 0 30px #3A8E8C;
            }

            .container {
                padding: 30px 0 30px 40px;
                width: 100%;
                overflow-y: scroll;
                height: calc(100vh - 100px);
                scrollbar-width: thin;
                scrollbar-color: #3A8E8C transparent;
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

            input[type="text"] {
                width: 100%;
                background-color: transparent;
                color: #3A8E8C;
                border: none;
                border-bottom: 2px solid #3A8E8C;
                font-size: 1rem;
                font-family: 'Orbitron', sans-serif;
                outline: none;
                margin-bottom: 20px;
                padding: 10px 5px;
                transition: border-color 0.3s, box-shadow 0.3s;
                min-height: 40px;
            }

            input[type="text"]:focus {
                border-bottom: 2px solid #66fffa;
            }

            .neon-text {
                color: #3A8E8C;
                text-shadow: 0 0 5px #3A8E8C, 0 0 10px #3A8E8C, 0 0 20px #3A8E8C;
            }

            .neon-table {
                width: 90%;
                margin: 0 auto 40px auto;
                border-collapse: collapse;
                font-family: 'Orbitron', sans-serif;
                color: #3A8E8C;
                text-shadow: 0 0 5px #3A8E8C;
                box-shadow: 0 0 15px #3A8E8C;
            }

            .neon-table th,
            .neon-table td {
                border: 1px solid #3A8E8C;
                padding: 12px 20px;
                text-align: center;
                font-size: 1rem;
            }

            .neon-table thead {
                background-color: #000;
                border-bottom: 2px solid #3A8E8C;
            }

            .neon-table tbody tr:hover {
                background-color: rgba(102, 255, 250, 0.1);
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="checkbox"] {
                appearance: none;
                width: 18px;
                height: 18px;
                background-color: #000;
                border: 2px solid #3A8E8C;
                border-radius: 4px;
                cursor: pointer;
                outline: none;
                position: relative;
            }

            input[type="checkbox"]:checked::before {
                content: "✓";
                color: #3A8E8C;
                position: absolute;
                top: -2px;
                left: 3px;
                font-size: 16px;
            }

            .role-select {
                background-color: black;
                color: #3A8E8C;
                border: none;
                font-family: 'Orbitron', sans-serif;
                padding: 5px 10px;
                font-size: 0.95rem;
                outline: none;
                cursor: pointer;
            }

            .role-select:focus {
                border-color: #66fffa;
                box-shadow: 0 0 12px #66fffa;
            }

            .save-icon {
                font-size: 20px;
                margin-right: 10px;
                text-shadow: 0 0 8px #3A8E8C, 0 0 16px #3A8E8C;
                transition: transform 0.2s, text-shadow 0.2s;
            }

            .save-icon:hover {
                transform: scale(1.2);
                text-shadow: 0 0 10px #3A8E8C, 0 0 20px #3A8E8C, 0 0 30px #3A8E8C;
            }
            
            .modal-overlay {
                display: none;
            }
            
            .modal-overlay.show {
                display: flex !important;
            }
            
            
            

        </style>

    </head>
    <body>

        <!-- Barra lateral -->
        <div class="sidebar-tech-neon">
            <div class="add-icon" onclick="abrirModal()">+</div>

            
        </div>

        <!-- Encabezado -->
        <div class="header">
            <div class="logo">N-note</div>
            <div class="title-container">
                <h2>Administrador</h2>
            </div>
            <div class="user-info">
                <span class="username"><%= usuario.getNombre()%></span>
                <form action="SvCerrarSesion" method="post" style="width: 200px;">
                    <button type="submit">CERRAR SESIÓN</button>
                </form>
            </div>
        </div>

        <!-- Contenedor principal -->
        <div class="container">

<!-- MODAL AGREGAR USUARIO -->
<div id="modalAgregarUsuario" style="display:none;position:fixed;top:0;left:0;
     width:100%;height:100%;background:rgba(0,0,0,0.8);justify-content:center;
     align-items:center;font-family:'Orbitron',sans-serif;z-index:1001">
  <div style="background:#000;border:3px solid #3A8E8C;border-radius:12px;
              box-shadow:0 0 20px #3A8E8C;padding:40px;width:400px;text-align:center;">
    <h2 style="color:#3A8E8C;text-shadow:0 0 10px #3A8E8C;">Nuevo Usuario</h2>

    <!-- Errores separados -->
    <p id="errorCorreo" style="color:red;font-size:0.9rem;display:none;margin-bottom:8px;">
      El correo ya existe.
    </p>
    <p id="errorClave"  style="color:red;font-size:0.9rem;display:none;margin-bottom:12px;">
      Las contraseñas no coinciden.
    </p>

    <input type="text"      id="nuevoNombre"   placeholder="Nombre de usuario" required autocomplete="off"
           style="width:100%;padding:12px;margin-bottom:12px;background:#000;border:2px solid #3A8E8C;
                  border-radius:10px;color:#3A8E8C;font-family:'Orbitron',sans-serif;font-size:1rem;outline:none;">

    <input type="email"     id="nuevoCorreo"   placeholder="Correo electrónico" required autocomplete="off"
           style="width:100%;padding:12px;margin-bottom:12px;background:#000;border:2px solid #3A8E8C;
                  border-radius:10px;color:#3A8E8C;font-family:'Orbitron',sans-serif;font-size:1rem;outline:none;">

    <select id="nuevoRol" required autocomplete="off"
            style="width:100%;padding:12px;margin-bottom:12px;background:#000;border:2px solid #3A8E8C;
                   border-radius:10px;color:#3A8E8C;font-family:'Orbitron',sans-serif;font-size:1rem;
                   outline:none;appearance:none;">
      <option value="" disabled selected style="color:#666;">Seleccionar rol</option>
      <option value="Administrador">Administrador</option>
      <option value="Estandar">Estandar</option>
    </select>

    <input type="password"  id="nuevaClave"    placeholder="Contraseña" required autocomplete="new-password"
           style="width:100%;padding:12px;margin-bottom:12px;background:#000;border:2px solid #3A8E8C;
                  border-radius:10px;color:#3A8E8C;font-family:'Orbitron',sans-serif;font-size:1rem;outline:none;">

    <input type="password"  id="confirmarClave" placeholder="Confirmar contraseña" required autocomplete="new-password"
           style="width:100%;padding:12px;margin-bottom:20px;background:#000;border:2px solid #3A8E8C;
                  border-radius:10px;color:#3A8E8C;font-family:'Orbitron',sans-serif;font-size:1rem;outline:none;">

    <button onclick="validarYAgregarUsuario()"
            style="width:100%;padding:12px;margin-bottom:10px;background:#000;color:#3A8E8C;
                   border:2px solid #3A8E8C;border-radius:8px 20px;cursor:pointer;
                   font-family:'Orbitron',sans-serif;font-size:1.1rem;">Agregar</button>

    <button onclick="cerrarModalAgregar()"
            style="width:100%;padding:12px;background:#000;color:#3A8E8C;
                   border:2px solid #3A8E8C;border-radius:8px 20px;cursor:pointer;
                   font-family:'Orbitron',sans-serif;font-size:1.1rem;">Cancelar</button>
  </div>
</div>



            <!-- BARRA DE BÚSQUEDA -->
            <div style="margin-bottom: 2px; display: flex; justify-content: center;">
                <input type="text" id="busquedaUsuario" placeholder="Buscar por usuario o correo" onkeyup="filtrarUsuarios()" 
                       style="width: 60%; max-width: 600px;">
            </div>
            
            
            <!-- Modal de confirmación para guardar cambios -->
            <div id="modalGuardarCambios" style="display: none; position: fixed; top: 0; left: 0;
    width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7);
    justify-content: center; align-items: center; z-index: 1000;" class="modal-overlay">
                <div style="background-color: #000; padding: 30px; border-radius: 15px; width: 400px;
        border: 2px solid #3A8E8C; box-shadow: 0 0 10px #3A8E8C; text-align: center;">
                    <h3>¿Estás seguro de guardar los cambios?</h3>
                    <p style="color: white; margin: 20px 0;">Este cambio se aplicará permanentemente.</p>
                    <button onclick="confirmarGuardado()" style="margin-bottom: 10px;">Sí, guardar cambios</button>
                    <button onclick="cancelarGuardado()">Cancelar</button>
                </div>
            </div>
            
            
            
            <!-- Modal de confirmación -->
            <div id="modalConfirmacion" style="display: none; position: fixed; top: 0; left: 0;
     width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7);
     justify-content: center; align-items: center; z-index: 1000;" class="modal-overlay">
                <div style="background-color: #000; padding: 30px; border-radius: 15px; width: 400px;
                     border: 2px solid #3A8E8C; box-shadow: 0 0 10px #3A8E8C; text-align: center;">
                    <h3>¿Deseas eliminar esta nota?</h3>
                    <p style="color: white; margin: 20px 0;">Esta acción no se puede deshacer.</p>
                    <button onclick="confirmarEliminacion()" style="margin-bottom: 10px;">Sí, eliminar</button>
                    <button onclick="cancelarEliminacion()">Cancelar</button>
                </div>
            </div>



            <!-- TABLA DE USUARIOS -->
            <table class="neon-table" id="tablaUsuarios">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" onchange="seleccionarTodos(this)"></th>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="usu" items="${listaUsuarios}">
                        <tr data-id="${usu.id}">
                            <td><input type="checkbox" class="filaCheckbox"></td>
                            <td>
                                ${usu.id}
                                <input type="hidden" class="idOculto" value="${usu.id}" />
                            </td>
                            <td class="editable" data-campo="nombre">${usu.nombre}</td>
                            <td class="editable" data-campo="correo">${usu.correo}</td>
                            <td>
                                <select class="role-select">
                                    <option value="Administrador" <c:if test="${usu.rol == 'Administrador'}">selected</c:if>>Administrador</option>
                                    <option value="Estandar" <c:if test="${usu.rol == 'Estandar'}">selected</c:if>>Estándar</option>
                                </select>
                            </td>
                            <td style="text-align: center;">
                                <i class="fas fa-save save-icon" onclick="guardarCambios(this)" style="cursor: pointer; color: #3A8E8C;"></i>
                                <i class="fas fa-trash delete-x" onclick="mostrarModalEliminacion(this)" style="cursor: pointer; color: #3A8E8C; margin-left: 15px;"></i>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>

        <script>
            // Edición inline por doble clic
            document.querySelectorAll('.editable').forEach(celda => {
                celda.addEventListener('dblclick', function () {
                    if (celda.querySelector('input'))
                        return; // Si ya está editando, no hacer nada

                    const valor = celda.innerText.trim();
                    const input = document.createElement('input');
                    input.type = 'text';
                    input.value = valor;
                    input.style.width = '100%';
                    input.style.backgroundColor = 'transparent';
                    input.style.color = '#3A8E8C';
                    input.style.border = 'none';
                    input.style.outline = 'none';
                    input.style.fontFamily = 'Orbitron, sans-serif';

                    input.addEventListener('blur', () => {
                        celda.innerText = input.value.trim();
                    });

                    input.addEventListener('keydown', (e) => {
                        if (e.key === 'Enter')
                            input.blur();
                    });

                    celda.innerHTML = '';
                    celda.appendChild(input);
                    input.focus();
                });
            });

            function guardarCambios(icono) {
    const fila = icono.closest('tr');
    const id = fila.querySelector('.idOculto').value;

    // Extraemos los valores actuales de la fila
    const nombreCelda = fila.querySelector('[data-campo="nombre"]');
    const correoCelda = fila.querySelector('[data-campo="correo"]');
    const rolSelect = fila.querySelector('select');

    const nombre = nombreCelda.querySelector('input') ? nombreCelda.querySelector('input').value.trim() : nombreCelda.innerText.trim();
    const correo = correoCelda.querySelector('input') ? correoCelda.querySelector('input').value.trim() : correoCelda.innerText.trim();
    const rol = rolSelect.value;

    // Guardamos los cambios en el modal de confirmación
    document.getElementById('modalGuardarCambios').classList.add('show');
    
    // Almacena temporalmente los valores para el uso posterior
    window.datosGuardados = { id, nombre, correo, rol };
}

function confirmarGuardado() {
    // Usamos los valores almacenados para hacer el envío
    const { id, nombre, correo, rol } = window.datosGuardados;

    const params = new URLSearchParams();
    params.append("id", id);
    params.append("nombre", nombre);
    params.append("correo", correo);
    params.append("rol", rol);

    // Enviar los datos al servlet sin esperar respuesta
    fetch("SvEditarUsuario", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString()
    }).catch(error => {
        console.error("Error al actualizar usuario:", error);
    });

    // Ocultamos el modal después de confirmar
    document.getElementById('modalGuardarCambios').classList.remove('show');
}

function cancelarGuardado() {
    // Solo ocultamos el modal
    document.getElementById('modalGuardarCambios').classList.remove('show');
}

            // Función para seleccionar todos los checkboxes (opcional)
            function seleccionarTodos(checkbox) {
                document.querySelectorAll('.filaCheckbox').forEach(cb => cb.checked = checkbox.checked);
            }
        </script>

        <script>
    let idAEliminar = null;

    function mostrarModalEliminacion(icono) {
        const fila = icono.closest('tr');
        idAEliminar = fila.getAttribute('data-id');
        document.getElementById('modalConfirmacion').classList.add('show');
    }

    function cancelarEliminacion() {
        document.getElementById('modalConfirmacion').classList.remove('show');
        idAEliminar = null;
    }

    function confirmarEliminacion() {
        if (!idAEliminar) return;

        // Creamos un formulario para enviar el ID al servlet
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "SvEliminarUsuario";

        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "id";
        input.value = idAEliminar;
        form.appendChild(input);

        document.body.appendChild(form);
        form.submit(); // Enviamos el formulario

        // Opcional: ocultar modal
        document.getElementById('modalConfirmacion').style.display = 'none';
    }
    
    
        
    
    
    
        </script>






















        <script>
            // BUSCADOR
            function filtrarUsuarios() {
                const texto = document.getElementById('busquedaUsuario').value.toLowerCase();
                const filas = document.querySelectorAll('#tablaUsuarios tbody tr');
                filas.forEach(fila => {
                    const contenido = fila.innerText.toLowerCase();
                    fila.style.display = contenido.includes(texto) ? '' : 'none';
                });
            }

            // CHECKBOX GENERAL
            function seleccionarTodos(check) {
                document.querySelectorAll('.filaCheckbox').forEach(cb => cb.checked = check.checked);
            }

            // MODAL AGREGAR
            function abrirModal() {
                document.getElementById('modalAgregarUsuario').style.display = 'flex';
            }
            function cerrarModalAgregar() {
                document.getElementById('modalAgregarUsuario').style.display = 'none';
            }

            // AGREGAR USUARIO
            function agregarUsuario() {
                const nombre = document.getElementById('nuevoNombre').value;
                const correo = document.getElementById('nuevoCorreo').value;
                const rol = document.getElementById('nuevoRol').value;

                const tabla = document.querySelector('#tablaUsuarios tbody');
                const nuevaFila = document.createElement('tr');
                nuevaFila.innerHTML = `
        <td><input type="checkbox" class="filaCheckbox"></td>
        <td>?</td>
        <td ondblclick="editarCelda(this)">${nombre}</td>
        <td ondblclick="editarCelda(this)">${correo}</td>
        <td ondblclick="editarCelda(this)">${rol}</td>
        <td><i class="fas fa-trash delete-x" onclick="mostrarModalEliminacion(this)"></i></td>
    `;
                tabla.appendChild(nuevaFila);
                cerrarModalAgregar();
            }

        </script>
        
        
<!-- ARRAY DE CORREOS YA EN USO -->
<script>
  const correosExistentes = [
    <c:forEach var="u" items="${listaUsuarios}" varStatus="st">
      "${fn:toLowerCase(u.correo)}"<c:if test="${!st.last}">,</c:if>
    </c:forEach>
  ];
</script>

<!-- SCRIPT DE VALIDACIÓN, ENVÍO Y RECARGA -->
<script>
  function validarYAgregarUsuario() {
    const nombre    = document.getElementById("nuevoNombre");
    const correo    = document.getElementById("nuevoCorreo");
    const rol       = document.getElementById("nuevoRol");
    const clave     = document.getElementById("nuevaClave");
    const confirmar = document.getElementById("confirmarClave");
    const errCorreo = document.getElementById("errorCorreo");
    const errClave  = document.getElementById("errorClave");

    // Reset de errores
    errCorreo.style.display = 'none';
    errClave.style.display  = 'none';

    const mail = correo.value.trim().toLowerCase();

    // Validación de correo duplicado
    if (correosExistentes.includes(mail)) {
      errCorreo.style.display = 'block';
      return;
    }
    // Validación de contraseñas
    if (clave.value !== confirmar.value) {
      errClave.style.display = 'block';
      return;
    }

    // Preparamos y enviamos
    const params = new URLSearchParams();
    params.append("nombre",  nombre.value.trim());
    params.append("correo",  mail);
    params.append("rol",     rol.value);
    params.append("clave",   clave.value);

    fetch("SvCrearUsuario", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString()
    })
    .finally(() => {
      // cerrar modal y limpiar campos
      cerrarModalAgregar();
      nombre.value = '';
      correo.value = '';
      rol.selectedIndex = 0;
      clave.value = '';
      confirmar.value = '';
      // **Recargar la página para ver el nuevo usuario**
      location.reload();
    });
  }

  function abrirModal() {
    document.getElementById("modalAgregarUsuario").style.display = "flex";
  }
  function cerrarModalAgregar() {
    document.getElementById("modalAgregarUsuario").style.display = "none";
  }
</script>



    </body>
</html>
