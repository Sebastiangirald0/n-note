package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;
import logica.Usuario;
import org.mindrot.jbcrypt.BCrypt;


@WebServlet(name = "SvRegistro", urlPatterns = {"/SvRegistro"})
public class SvRegistro extends HttpServlet {
    
    Controladora control = Controladora.getInstancia();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Crear un nuevo objeto Usuario (aún vacío)
        Usuario usuario = new Usuario();

        // Obtener los datos del formulario enviados por el usuario
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        String rol = "estandar"; // El rol por defecto es "estandar"

        // Verificar si el correo ya está registrado (true = duplicado)
        boolean correoDuplicado = control.validarCorreo(correo);

        if (correoDuplicado) {
            // Si el correo ya existe, volvemos a la página de registro con un mensaje de error
            request.setAttribute("error", "Este correo ya está registrado.");
            request.getRequestDispatcher("Registro.jsp").forward(request, response);
        } else {
            // Si el correo no está en uso, se hashea la contraseña con BCrypt
            String claveHasheada = BCrypt.hashpw(clave, BCrypt.gensalt(12));

            // Guardamos los datos en el objeto Usuario
            usuario.setNombre(nombre);
            usuario.setCorreo(correo);
            usuario.setClave(claveHasheada); // Guardamos la clave ya hasheada
            usuario.setRol(rol);

            // Llamamos al método de la capa lógica para guardar el nuevo usuario
            control.crearUsuario(usuario);

            // Redirigimos al usuario al index (puede cambiarse a una página de bienvenida)
            response.sendRedirect("index.jsp");
        }

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
