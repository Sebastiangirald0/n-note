package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Usuario;


@WebServlet(name = "SvListarUsuarios", urlPatterns = {"/SvListarUsuarios"})
public class SvListarUsuarios extends HttpServlet {
    
    Controladora control = Controladora.getInstancia();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
     // 1. Obtener la lista actualizada desde la base de datos
    List<Usuario> listaUsuarios = control.traerUsuarios();

    // 2. Guardar la lista en el request
    request.setAttribute("listaUsuarios", listaUsuarios);

    // 3. Redirigir internamente al JSP usando forward (sin mostrar el servlet en la URL)
    RequestDispatcher dispatcher = request.getRequestDispatcher("Administrador.jsp");
    dispatcher.forward(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
