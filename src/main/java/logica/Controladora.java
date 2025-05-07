package logica;

import java.time.LocalDateTime;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;
import persistencia.ControladoraPersistencia;

public class Controladora {

    // 1. Instancia única de la clase (patrón Singleton)
    private static Controladora instancia;

    // 2. Instancia de la controladora de persistencia (también Singleton)
    private ControladoraPersistencia controlPersi;

    // 3. Constructor privado para evitar instancias externas
    private Controladora() {
        // Se obtiene la instancia Singleton de la clase ControladoraPersistencia
        controlPersi = ControladoraPersistencia.getInstance();
    }

    // 4. Método estático para obtener la instancia única
    public static Controladora getInstancia() {
        if (instancia == null) {
            instancia = new Controladora();
        }
        return instancia;
    }

    // 5. Métodos de lógica (sin cambios en comportamiento)
    public void crearUsuario(Usuario usuario) {
        controlPersi.crearUsuario(usuario);
    }

    public Usuario validarUsuario(String correo, String clave) {
        return controlPersi.validarUsuario(correo,clave);
   
    }

    public void crearNota(Nota nota) {
        controlPersi.crearNota(nota);
    }



    public void eliminarNota(int idEliminar) {
        controlPersi.eliminarNota(idEliminar);
    }

    public void editarNota(Nota nota) {
       controlPersi.editarNota(nota);
    }

    public List<Nota> traerNotas(int idUsuario) {
         return controlPersi.traerNotas(idUsuario);
    }

    public boolean validarCorreo(String correo) {
        return controlPersi.validarCorreo(correo);
    }

    public Usuario existeUsuario(String correo) {
        return controlPersi.existeUsuario(correo);
    }

    public void guardarToken(int id, String token, LocalDateTime expiracion) {
       Token nuevoToken = new Token();
       
       nuevoToken.setToken(token);
       nuevoToken.setExpiracion(expiracion);
       
       controlPersi.guardarToken(nuevoToken,id);
       
       
    }

    public Usuario verificarToken(String token) {
       return controlPersi.verificarToken(token);
    }

    public void actualizarClave(int id, String nuevaClave) {
       
        String claveHasheada = BCrypt.hashpw(nuevaClave, BCrypt.gensalt(12));

        controlPersi.actualizarClave(id,claveHasheada);
    }

    public void eliminarToken(String token) {
        controlPersi.eliminarToken(token);
    }

    public Token existeToken(int id) {
         return controlPersi.existeToken(id);
    }

    public List<Usuario> traerUsuarios() {
        return controlPersi.traerUsuarios();
    }

    public void editarUsuario(Usuario usuario) {
        controlPersi.editarUsuario(usuario);
    }

    public void eliminarUsuario(int id) {
        controlPersi.eliminarUsuario(id);
    }

    public Usuario traerUsuario(int id) {
        return controlPersi.traerUsuario(id);
    }


}
