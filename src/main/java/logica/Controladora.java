package logica;

import java.util.List;
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
        List<Usuario> listaUsuarios = controlPersi.traerUsuarios();

        if (listaUsuarios == null) {
            return null;
        }

        for (Usuario usuarioAux : listaUsuarios) {
            if (usuarioAux.getCorreo().equals(correo) && usuarioAux.getClave().equals(clave)) {
                return usuarioAux;
            }
        }

        return null;
    }

    public void crearNota(Nota nota) {
        controlPersi.crearNota(nota);
    }

    public List<Nota> traerNotas() {
        
        return controlPersi.traerNotas();
        
    }

    public void eliminarNota(int idEliminar) {
        controlPersi.eliminarNota(idEliminar);
    }

    public void editarNota(Nota nota) {
       controlPersi.editarNota(nota);
    }
}
