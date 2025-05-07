package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;
import logica.Usuario;
import org.mindrot.jbcrypt.BCrypt;


@WebServlet(name = "SvCrearUsuario", urlPatterns = {"/SvCrearUsuario"})
public class SvCrearUsuario extends HttpServlet {
    
    Controladora control = Controladora.getInstancia();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
        String rol = request.getParameter("rol");

        String claveHasheada = BCrypt.hashpw(clave, BCrypt.gensalt(12));

        usuario.setNombre(nombre);
        usuario.setCorreo(correo);
        usuario.setClave(claveHasheada); // Guardamos la clave ya hasheada
        usuario.setRol(rol);

        control.crearUsuario(usuario);

        response.sendRedirect("SvlistarUsuarios");

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
