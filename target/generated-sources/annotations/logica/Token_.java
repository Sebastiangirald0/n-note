package logica;

import java.time.LocalDateTime;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import logica.Usuario;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2025-05-05T09:34:35")
@StaticMetamodel(Token.class)
public class Token_ { 

    public static volatile SingularAttribute<Token, Integer> idToken;
    public static volatile SingularAttribute<Token, Usuario> usuario;
    public static volatile SingularAttribute<Token, LocalDateTime> expiracion;
    public static volatile SingularAttribute<Token, String> token;

}