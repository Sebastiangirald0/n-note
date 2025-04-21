
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;


@WebServlet(name = "SvEliminarNota", urlPatterns = {"/SvEliminarNota"})
public class SvEliminarNota extends HttpServlet {

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
        
        int idEliminar = Integer.parseInt(request.getParameter("idNota"));

        control.eliminarNota(idEliminar);

        response.sendRedirect("SvListarNotas");

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
