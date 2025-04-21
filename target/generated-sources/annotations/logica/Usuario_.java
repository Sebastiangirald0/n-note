package logica;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import logica.Nota;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2025-04-21T16:43:16")
@StaticMetamodel(Usuario.class)
public class Usuario_ { 

    public static volatile SingularAttribute<Usuario, String> clave;
    public static volatile SingularAttribute<Usuario, String> correo;
    public static volatile SingularAttribute<Usuario, Integer> id;
    public static volatile SingularAttribute<Usuario, String> nombre;
    public static volatile SingularAttribute<Usuario, String> rol;
    public static volatile ListAttribute<Usuario, Nota> listaNotas;

}