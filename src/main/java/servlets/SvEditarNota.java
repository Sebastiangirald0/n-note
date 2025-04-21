package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;
import logica.Nota;
import logica.Usuario;


@WebServlet(name = "SvEditarNota", urlPatterns = {"/SvEditarNota"})
public class SvEditarNota extends HttpServlet {
    Controladora control = Controladora.getInstancia();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Nota nota = new Nota();
        Date fechaEdicion = new Date();
        
        
        nota.setIdNota(Integer.parseInt(request.getParameter("idNota")));
        nota.setNombreNota(request.getParameter("titulo"));
        nota.setContenidoNota(request.getParameter("contenido"));
        nota.setFechaEdicion(fechaEdicion);
        nota.setUsuarioPropietario((Usuario)request.getSession().getAttribute("usuario"));
        
        
        
        control.editarNota(nota);
        
        response.sendRedirect("SvListarNotas");
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
