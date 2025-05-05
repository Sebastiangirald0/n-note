package logica;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import logica.Usuario;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2025-05-05T09:34:35")
@StaticMetamodel(Nota.class)
public class Nota_ { 

    public static volatile SingularAttribute<Nota, Date> fechaEdicion;
    public static volatile SingularAttribute<Nota, String> contenidoNota;
    public static volatile SingularAttribute<Nota, Integer> idNota;
    public static volatile SingularAttribute<Nota, Usuario> usuarioPropietario;
    public static volatile SingularAttribute<Nota, String> nombreNota;

}