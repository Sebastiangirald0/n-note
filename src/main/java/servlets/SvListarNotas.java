package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Nota;


@WebServlet(name = "SvListarNotas", urlPatterns = {"/SvListarNotas"})
public class SvListarNotas extends HttpServlet {
    
    Controladora control = Controladora.getInstancia();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        List<Nota> listaNotas = control.traerNotas();
        
        HttpSession sesion = request.getSession(false);
        
        sesion.setAttribute("listaNotas", listaNotas);
        
        response.sendRedirect("Principal.jsp");
                
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
