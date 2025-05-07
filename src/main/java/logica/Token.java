
package logica;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;

@Entity
@NamedQueries({
    @NamedQuery(
        name = "Token.validarToken",
        query = "SELECT t.usuario FROM Token t WHERE t.token = :token AND t.expiracion > CURRENT_TIMESTAMP"
    ),
    @NamedQuery(
        name = "Token.porUsuario",
        query = "SELECT t FROM Token t WHERE t.usuario.id = :usuarioId"
    )
})
public class Token implements Serializable {
    
    @Id
    @GeneratedValue (strategy = GenerationType.AUTO)
    private int idToken;
    
    private String token;
    
    private LocalDateTime expiracion;

    @OneToOne
    @JoinColumn(name = "usuario_fk", nullable = false)
    private Usuario usuario;

    public Token() {
    }

    public Token(int idToken, String token, LocalDateTime expiracion, Usuario usuario) {
        this.idToken = idToken;
        this.token = token;
        this.expiracion = expiracion;
        this.usuario = usuario;
    }

    public int getIdToken() {
        return idToken;
    }

    public void setIdToken(int idToken) {
        this.idToken = idToken;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LocalDateTime getExpiracion() {
        return expiracion;
    }

    public void setExpiracion(LocalDateTime expiracion) {
        this.expiracion = expiracion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
    
    
    
    
    
    
}
