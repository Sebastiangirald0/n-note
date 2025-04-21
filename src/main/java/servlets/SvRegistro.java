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
        
        Usuario usuario = new Usuario();
        
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        String rol = "estandar";
        
        usuario.setNombre(nombre);
        usuario.setCorreo(correo);
        usuario.setClave(clave);
        usuario.setRol(rol);
        
        control.crearUsuario(usuario);
        
        response.sendRedirect("index.jsp");
        
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
