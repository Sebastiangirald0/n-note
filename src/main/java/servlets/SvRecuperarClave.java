package servlets;

import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;
import logica.Token;
import logica.Usuario;
import utilidades.Correo;


@WebServlet(name = "SvRecuperarClave", urlPatterns = {"/SvRecuperarClave"})
public class SvRecuperarClave extends HttpServlet {
    
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
        
        String correo = request.getParameter("correo");
        Usuario usuario = control.existeUsuario(correo);

        // Mensaje genérico para evitar filtrado de usuarios
        String mensajeGenerico = "Si la cuenta existe, verifique su bandeja de entrada.";

        if (usuario != null) {
            // Buscar token vigente (método ya debería retornar null si está vencido)
            Token tokenExistente = control.existeToken(usuario.getId());

            String token;
            if (tokenExistente != null) {
                // Reusar token vigente
                token = tokenExistente.getToken();
            } else {
                // Generar nuevo token y guardar
                token = UUID.randomUUID().toString();
                LocalDateTime expiracion = LocalDateTime.now().plusHours(1);
                control.guardarToken(usuario.getId(), token, expiracion);
            }

            // Enlace y contenido del correo
            String link = "http://localhost:8080/nNoteWeb/SvRestablecer?token=" + token;
            String contenido = "Hola " + usuario.getNombre() + ",\n\n"
                    + "Haz clic en el siguiente enlace para restablecer tu contraseña:\n"
                    + link + "\n\nEste enlace expirará en 1 hora.";

            try {
                Correo.enviarCorreo(correo, "Recuperar contraseña", contenido);
            } catch (MessagingException e) {
                e.printStackTrace(); // En producción deberías usar log
            }
        }

        // Siempre mostrar mensaje genérico
        request.setAttribute("error", mensajeGenerico);
        request.getRequestDispatcher("Recuperar.jsp").forward(request, response);
        

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
