/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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


@WebServlet(name = "SvRestablecer", urlPatterns = {"/SvRestablecer"})
public class SvRestablecer extends HttpServlet {
    
    Controladora control = Controladora.getInstancia();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
               String token = request.getParameter("token");

        if (token == null || token.isEmpty()) {
            request.setAttribute("error", "Token inválido ingrese su correo.");
            request.getRequestDispatcher("Recuperar.jsp").forward(request, response);
            return;
        }

        // Validar token en la base de datos
        Usuario usuario = control.verificarToken(token);
        

        if (usuario == null) {
            request.setAttribute("error", "El enlace ha expirado o es inválido ingrese su correo.");
            request.getRequestDispatcher("Recuperar.jsp").forward(request, response);
            return;
        }

        // Si el token es válido, guardar el id del usuario en sesión o request
        request.setAttribute("token", token); // opcional
        request.setAttribute("correo", usuario.getCorreo()); // para mostrarlo si quieres

        request.getRequestDispatcher("Restablecer.jsp").forward(request, response);
  
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    String token = request.getParameter("token");
    String nuevaClave = request.getParameter("nuevaClave");
    String confirmarClave = request.getParameter("confirmarClave");
    
        

    if (token == null || token.isEmpty()) {
        request.setAttribute("error", "Token inválido.");
        request.getRequestDispatcher("Recuperar.jsp").forward(request, response);
        return;
    }

    if (!nuevaClave.equals(confirmarClave)) {
        request.setAttribute("error", "Las contraseñas no coinciden.");
        request.setAttribute("token", token);
        request.getRequestDispatcher("Restablecer.jsp").forward(request, response);
        return;
    }

    // Validar nuevamente el token y obtener el usuario
    Usuario usuario = control.verificarToken(token);
    

    if (usuario == null) {
        request.setAttribute("error", "El token ha expirado o no es válido.");
        request.getRequestDispatcher("Recuperar.jsp").forward(request, response);
        return;
    }

    
    
    
    // Actualizar la contraseña del usuario
    control.actualizarClave(usuario.getId(), nuevaClave);
    

    // Eliminar o invalidar el token
    control.eliminarToken(token); // Debes implementar este método si no existe

    // Redirigir al login con mensaje de éxito
    request.setAttribute("error", "Contraseña actualizada correctamente. Inicia sesión.");
    request.getRequestDispatcher("index.jsp").forward(request, response);
        
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
