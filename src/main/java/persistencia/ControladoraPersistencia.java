package persistencia;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logica.Nota;
import logica.Usuario;
import persistencia.exceptions.NonexistentEntityException;

public class ControladoraPersistencia {
    
    private static ControladoraPersistencia instancia = null;

    private NotaJpaController notaJpa;
    private UsuarioJpaController usuarioJpa;

    // Constructor privado
    private ControladoraPersistencia() {
        notaJpa = new NotaJpaController();
        usuarioJpa = new UsuarioJpaController();
    }

    // Método público para obtener la única instancia
    public static ControladoraPersistencia getInstance() {
        if (instancia == null) {
            instancia = new ControladoraPersistencia();
        }
        return instancia;
    }

    public void crearUsuario(Usuario usuario) {
        usuarioJpa.create(usuario);
    }

    public List<Usuario> traerUsuarios() {
        return usuarioJpa.findUsuarioEntities();  
    }

    public void crearNota(Nota nota) {
        notaJpa.create(nota);
    }

    public List<Nota> traerNotas() {
      return notaJpa.findNotaEntities();
    }

    public void eliminarNota(int idEliminar) {
        try {
            notaJpa.destroy(idEliminar);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editarNota(Nota nota) {
        try {
            notaJpa.edit(nota);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}