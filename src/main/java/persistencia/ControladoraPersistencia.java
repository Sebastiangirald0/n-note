package persistencia;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logica.Nota;
import logica.Token;
import logica.Usuario;
import persistencia.exceptions.NonexistentEntityException;

public class ControladoraPersistencia {
    
    private static ControladoraPersistencia instancia = null;

    private NotaJpaController notaJpa;
    private UsuarioJpaController usuarioJpa;
    private TokenJpaController tokenJpa;

    // Constructor privado
    private ControladoraPersistencia() {
        notaJpa = new NotaJpaController();
        usuarioJpa = new UsuarioJpaController();
        tokenJpa = new TokenJpaController();
        
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



    public void crearNota(Nota nota) {
        notaJpa.create(nota);
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

    public List<Nota> traerNotas(int idUsuario) {
        return notaJpa.traerNotasPorUsuario(idUsuario);
    }


    public Usuario validarUsuario(String correo, String clave) {
       
        return usuarioJpa.validarUsuario(correo, clave);
    }

    public boolean validarCorreo(String correo) {
       
        return usuarioJpa.validarCorreo(correo);
    }

    public Usuario existeUsuario(String correo) {
        return usuarioJpa.existeUsuario(correo);
    }

    public void guardarToken(Token nuevoToken, int id) {
        
       Usuario usuario = usuarioJpa.findUsuario(id);
       
       nuevoToken.setUsuario(usuario);
       
       tokenJpa.create(nuevoToken);
   
    }

    public Usuario verificarToken(String token) {
        return tokenJpa.validarToken(token);
    }

    public void actualizarClave(int id, String claveHasheada) {
      
      Usuario usuario =usuarioJpa.findUsuario(id);
      
      usuario.setClave(claveHasheada);
      
        try {
            usuarioJpa.edit(usuario);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
   
    }

    public void eliminarToken(String token) {
        tokenJpa.eliminarTokenPorValor(token);
    }

    public Token existeToken(int id) {
      return tokenJpa.obtenerTokenPorUsuario(id);
    }

    public List<Usuario> traerUsuarios() {
        return usuarioJpa.findUsuarioEntities();
    }

    public void editarUsuario(Usuario usuario) {
        try {
            usuarioJpa.edit(usuario);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void eliminarUsuario(int id) {
        try {
            usuarioJpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Usuario traerUsuario(int id) {
        return usuarioJpa.findUsuario(id);
    }

  
}