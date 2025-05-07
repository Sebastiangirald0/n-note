package persistencia;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import logica.Token;
import logica.Usuario;
import persistencia.exceptions.NonexistentEntityException;


public class TokenJpaController implements Serializable {

    public TokenJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public TokenJpaController() {
       emf = Persistence.createEntityManagerFactory("nNoteWeb_PU");
    }
    
    
    
    
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Token token) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(token);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Token token) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            token = em.merge(token);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = token.getIdToken();
                if (findToken(id) == null) {
                    throw new NonexistentEntityException("The token with id " + id + " no longer exists.");
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
            Token token;
            try {
                token = em.getReference(Token.class, id);
                token.getIdToken();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The token with id " + id + " no longer exists.", enfe);
            }
            em.remove(token);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Token> findTokenEntities() {
        return findTokenEntities(true, -1, -1);
    }

    public List<Token> findTokenEntities(int maxResults, int firstResult) {
        return findTokenEntities(false, maxResults, firstResult);
    }

    private List<Token> findTokenEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Token.class));
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

    public Token findToken(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Token.class, id);
        } finally {
            em.close();
        }
    }

    public int getTokenCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Token> rt = cq.from(Token.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public Usuario validarToken(String token) {
    EntityManager em = getEntityManager();
    try {
        return em.createNamedQuery("Token.validarToken", Usuario.class)
                 .setParameter("token", token)
                 .getSingleResult();
    } catch (NoResultException e) {
        return null; // Token inválido o expirado
    } finally {
        em.close();
    }
}

    public void eliminarTokenPorValor(String token) {
    EntityManager em = getEntityManager();
    try {
        em.getTransaction().begin();
        em.createQuery("DELETE FROM Token t WHERE t.token = :token")
          .setParameter("token", token)
          .executeUpdate();
        em.getTransaction().commit();
    } finally {
        em.close();
    }
    }
    
    
    public Token obtenerTokenPorUsuario(int usuarioId) {
        EntityManager em = getEntityManager();
        try {
            Token token = em.createNamedQuery("Token.porUsuario", Token.class)
                    .setParameter("usuarioId", usuarioId)
                    .getSingleResult();

            // Verificar si el token está vencido
            if (token.getExpiracion().isBefore(LocalDateTime.now())) {
                em.getTransaction().begin();
                em.remove(em.merge(token));  // merge por si está en estado detached
                em.getTransaction().commit();
                return null;
            }

            return token;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
    
    
}
