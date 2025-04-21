/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;
import logica.Nota;
import logica.Usuario;

/**
 *
 * @author NAISHA
 */
@WebServlet(name = "SvNuevaNota", urlPatterns = {"/SvNuevaNota"})
public class SvNuevaNota extends HttpServlet {
    
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
        
        String nombreNota = request.getParameter("titulo");
        String contenidoNota = request.getParameter("contenido");

        nota.setNombreNota(nombreNota);
        nota.setContenidoNota(contenidoNota);
        nota.setFechaEdicion(fechaEdicion);
        nota.setUsuarioPropietario((Usuario)request.getSession().getAttribute("usuario"));
        
        control.crearNota(nota);
        
        response.sendRedirect("SvListarNotas");
        
        
        
        
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
