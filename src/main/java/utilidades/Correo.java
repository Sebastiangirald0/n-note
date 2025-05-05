package utilidades;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class Correo {
    
    public static void enviarCorreo(String destinatario, String asunto, String contenido) throws MessagingException {
        final String remitente = "industriesprototype@gmail.com"; // Cambia esto
        final String clave = "hrzqzrpkduuradbr"; // Usa una contraseña de aplicación si es Gmail

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session sesion = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitente, clave);
            }
        });

        Message mensaje = new MimeMessage(sesion);
        mensaje.setFrom(new InternetAddress(remitente));
        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensaje.setSubject(asunto);
        mensaje.setText(contenido);

        Transport.send(mensaje);
    }    
    
    
    
    
    
    
}
