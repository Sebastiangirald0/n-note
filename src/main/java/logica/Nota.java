package logica;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Nota implements Serializable {
    @Id
    @GeneratedValue (strategy = GenerationType.AUTO)
    private int idNota;
    private String nombreNota;
    

    @Lob // Esto indica que 'contenidoNota' será un campo largo en la base de datos
    private String contenidoNota;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaEdicion;
    
    @ManyToOne
    @JoinColumn(name = "id_usuario")
    private Usuario usuarioPropietario;

    public Nota() {
    }

    public Nota(int idNota, String nombreNota, String contenidoNota, Date fechaEdicion, Usuario usuarioPropietario) {
        this.idNota = idNota;
        this.nombreNota = nombreNota;
        this.contenidoNota = contenidoNota;
        this.fechaEdicion = fechaEdicion;
        this.usuarioPropietario = usuarioPropietario;
    }

    public int getIdNota() {
        return idNota;
    }

    public void setIdNota(int idNota) {
        this.idNota = idNota;
    }

    public String getNombreNota() {
        return nombreNota;
    }

    public void setNombreNota(String nombreNota) {
        this.nombreNota = nombreNota;
    }

    public String getContenidoNota() {
        return contenidoNota;
    }

    public void setContenidoNota(String contenidoNota) {
        this.contenidoNota = contenidoNota;
    }

    public Date getFechaEdicion() {
        return fechaEdicion;
    }

    public void setFechaEdicion(Date fechaEdicion) {
        this.fechaEdicion = fechaEdicion;
    }

    public Usuario getUsuarioPropietario() {
        return usuarioPropietario;
    }

    public void setUsuarioPropietario(Usuario usuarioPropietario) {
        this.usuarioPropietario = usuarioPropietario;
    }
    
    
    
}
