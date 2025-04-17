/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import logica.Nota;
import logica.Usuario;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author NAISHA
 */
public class NotaJpaController implements Serializable {

    public NotaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
        public NotaJpaController() {
        emf = Persistence.createEntityManagerFactory("nNoteWeb_PU");
    }
        
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Nota nota) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario usuarioPropietario = nota.getUsuarioPropietario();
            if (usuarioPropietario != null) {
                usuarioPropietario = em.getReference(usuarioPropietario.getClass(), usuarioPropietario.getId());
                nota.setUsuarioPropietario(usuarioPropietario);
            }
            em.persist(nota);
            if (usuarioPropietario != null) {
                usuarioPropietario.getListaNotas().add(nota);
                usuarioPropietario = em.merge(usuarioPropietario);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Nota nota) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Nota persistentNota = em.find(Nota.class, nota.getIdNota());
            Usuario usuarioPropietarioOld = persistentNota.getUsuarioPropietario();
            Usuario usuarioPropietarioNew = nota.getUsuarioPropietario();
            if (usuarioPropietarioNew != null) {
                usuarioPropietarioNew = em.getReference(usuarioPropietarioNew.getClass(), usuarioPropietarioNew.getId());
                nota.setUsuarioPropietario(usuarioPropietarioNew);
            }
            nota = em.merge(nota);
            if (usuarioPropietarioOld != null && !usuarioPropietarioOld.equals(usuarioPropietarioNew)) {
                usuarioPropietarioOld.getListaNotas().remove(nota);
                usuarioPropietarioOld = em.merge(usuarioPropietarioOld);
            }
            if (usuarioPropietarioNew != null && !usuarioPropietarioNew.equals(usuarioPropietarioOld)) {
                usuarioPropietarioNew.getListaNotas().add(nota);
                usuarioPropietarioNew = em.merge(usuarioPropietarioNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = nota.getIdNota();
                if (findNota(id) == null) {
                    throw new NonexistentEntityException("The nota with id " + id + " no longer exists.");
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
            Nota nota;
            try {
                nota = em.getReference(Nota.class, id);
                nota.getIdNota();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The nota with id " + id + " no longer exists.", enfe);
            }
            Usuario usuarioPropietario = nota.getUsuarioPropietario();
            if (usuarioPropietario != null) {
                usuarioPropietario.getListaNotas().remove(nota);
                usuarioPropietario = em.merge(usuarioPropietario);
            }
            em.remove(nota);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Nota> findNotaEntities() {
        return findNotaEntities(true, -1, -1);
    }

    public List<Nota> findNotaEntities(int maxResults, int firstResult) {
        return findNotaEntities(false, maxResults, firstResult);
    }

    private List<Nota> findNotaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Nota.class));
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

    public Nota findNota(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Nota.class, id);
        } finally {
            em.close();
        }
    }

    public int getNotaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Nota> rt = cq.from(Nota.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
