/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import logica.Nota;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import logica.Usuario;
import org.mindrot.jbcrypt.BCrypt;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author NAISHA
 */
public class UsuarioJpaController implements Serializable {

    public UsuarioJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public UsuarioJpaController() {
        emf = Persistence.createEntityManagerFactory("nNoteWeb_PU");
    }
    
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
public Usuario validarUsuario(String correo, String clave) {
    EntityManager em = null; // Creamos la variable de la conexión (EntityManager).
    try {
        em = getEntityManager(); // Obtenemos la conexión a la base de datos mediante el EntityManager.
        
        // La consulta JPQL para buscar el usuario por su correo.
        String jpql = "SELECT u FROM Usuario u WHERE u.correo = :correo"; // Buscamos al usuario por correo, sin necesidad de incluir la clave en esta consulta.
        
        // Crear la consulta tipada utilizando EntityManager.
        TypedQuery<Usuario> query = em.createQuery(jpql, Usuario.class);
        
        // Establecer el parámetro "correo" en la consulta.
        query.setParameter("correo", correo);
        
        // Ejecutar la consulta y obtener el usuario.
        try {
            // Obtenemos el usuario si existe, si no, lanzará una excepción que manejaremos.
            Usuario usuario = query.getSingleResult(); // Si el correo existe, nos devuelve un único usuario.
            
            // Comprobamos si la contraseña ingresada es la misma que la guardada en la base de datos (que está hasheada).
            if (BCrypt.checkpw(clave, usuario.getClave())) { // Usamos bcrypt para verificar si las contraseñas coinciden.
                return usuario; // Si las contraseñas coinciden, devolvemos el usuario.
            } else {
                return null; // Si las contraseñas no coinciden, retornamos null.
            }
            
        } catch (Exception e) {
            // Si no hay resultados o ocurre una excepción (como que el correo no exista), retornamos null.
            return null;
        }
    } finally {
        if (em != null) {
            em.close(); // Cerramos la conexión al final para liberar recursos.
        }
    }
}


    public void create(Usuario usuario) {
        if (usuario.getListaNotas() == null) {
            usuario.setListaNotas(new ArrayList<Nota>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Nota> attachedListaNotas = new ArrayList<Nota>();
            for (Nota listaNotasNotaToAttach : usuario.getListaNotas()) {
                listaNotasNotaToAttach = em.getReference(listaNotasNotaToAttach.getClass(), listaNotasNotaToAttach.getIdNota());
                attachedListaNotas.add(listaNotasNotaToAttach);
            }
            usuario.setListaNotas(attachedListaNotas);
            em.persist(usuario);
            for (Nota listaNotasNota : usuario.getListaNotas()) {
                Usuario oldUsuarioPropietarioOfListaNotasNota = listaNotasNota.getUsuarioPropietario();
                listaNotasNota.setUsuarioPropietario(usuario);
                listaNotasNota = em.merge(listaNotasNota);
                if (oldUsuarioPropietarioOfListaNotasNota != null) {
                    oldUsuarioPropietarioOfListaNotasNota.getListaNotas().remove(listaNotasNota);
                    oldUsuarioPropietarioOfListaNotasNota = em.merge(oldUsuarioPropietarioOfListaNotasNota);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Usuario usuario) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario persistentUsuario = em.find(Usuario.class, usuario.getId());
            List<Nota> listaNotasOld = persistentUsuario.getListaNotas();
            List<Nota> listaNotasNew = usuario.getListaNotas();
            List<Nota> attachedListaNotasNew = new ArrayList<Nota>();
            for (Nota listaNotasNewNotaToAttach : listaNotasNew) {
                listaNotasNewNotaToAttach = em.getReference(listaNotasNewNotaToAttach.getClass(), listaNotasNewNotaToAttach.getIdNota());
                attachedListaNotasNew.add(listaNotasNewNotaToAttach);
            }
            listaNotasNew = attachedListaNotasNew;
            usuario.setListaNotas(listaNotasNew);
            usuario = em.merge(usuario);
            for (Nota listaNotasOldNota : listaNotasOld) {
                if (!listaNotasNew.contains(listaNotasOldNota)) {
                    listaNotasOldNota.setUsuarioPropietario(null);
                    listaNotasOldNota = em.merge(listaNotasOldNota);
                }
            }
            for (Nota listaNotasNewNota : listaNotasNew) {
                if (!listaNotasOld.contains(listaNotasNewNota)) {
                    Usuario oldUsuarioPropietarioOfListaNotasNewNota = listaNotasNewNota.getUsuarioPropietario();
                    listaNotasNewNota.setUsuarioPropietario(usuario);
                    listaNotasNewNota = em.merge(listaNotasNewNota);
                    if (oldUsuarioPropietarioOfListaNotasNewNota != null && !oldUsuarioPropietarioOfListaNotasNewNota.equals(usuario)) {
                        oldUsuarioPropietarioOfListaNotasNewNota.getListaNotas().remove(listaNotasNewNota);
                        oldUsuarioPropietarioOfListaNotasNewNota = em.merge(oldUsuarioPropietarioOfListaNotasNewNota);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = usuario.getId();
                if (findUsuario(id) == null) {
                    throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(int id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario usuario;
            try {
                usuario = em.getReference(Usuario.class, id);
                usuario.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.", enfe);
            }
            List<Nota> listaNotas = usuario.getListaNotas();
            for (Nota listaNotasNota : listaNotas) {
                listaNotasNota.setUsuarioPropietario(null);
                listaNotasNota = em.merge(listaNotasNota);
            }
            em.remove(usuario);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Usuario> findUsuarioEntities() {
        return findUsuarioEntities(true, -1, -1);
    }

    public List<Usuario> findUsuarioEntities(int maxResults, int firstResult) {
        return findUsuarioEntities(false, maxResults, firstResult);
    }

    private List<Usuario> findUsuarioEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Usuario.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Usuario findUsuario(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsuarioCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Usuario> rt = cq.from(Usuario.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public boolean validarCorreo(String correo) {
    EntityManager em = null;

    try {
        em = getEntityManager();

        // Consulta JPQL que busca un usuario por su correo
        String jpql = "SELECT u FROM Usuario u WHERE u.correo = :correo";

        TypedQuery<Usuario> query = em.createQuery(jpql, Usuario.class);
        query.setParameter("correo", correo);
        query.setMaxResults(1); // Solo nos interesa 1 resultado como mucho

        // Intentamos obtener un resultado
        List<Usuario> resultados = query.getResultList();

        return !resultados.isEmpty(); // Si hay al menos uno, el correo ya existe

    } finally {
        if (em != null) {
            em.close();
        }
    }
}

    public Usuario existeUsuario(String correo) {
        EntityManager em = null;

        try {
            em = getEntityManager();

            String jpql = "SELECT u FROM Usuario u WHERE u.correo = :correo";

            TypedQuery<Usuario> query = em.createQuery(jpql, Usuario.class);
            query.setParameter("correo", correo);

            try {
                // Intentamos obtener un único resultado
                Usuario usuario = query.getSingleResult();
                return usuario;
            } catch (NoResultException e) {
                // Si no se encuentra un usuario con el correo, retornamos null
                return null;
            } catch (Exception e) {
                // Capturamos cualquier otra excepción que pueda ocurrir (aunque no es muy común)
                e.printStackTrace();  // Es una buena práctica loguear la excepción
                return null;
            }
        } finally {
            // Cerramos la conexión para liberar recursos
            if (em != null) {
                em.close();
            }
        }
    }

    
    
    
    
    
    
    
}
