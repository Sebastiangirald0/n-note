/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Usuario;


@WebServlet(name = "SvInicioSesion", urlPatterns = {"/SvInicioSesion"})
public class SvInicioSesion extends HttpServlet {
    
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
        
       
        
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        
        Usuario usuario = control.validarUsuario(correo, clave);
        
        if(usuario != null){
            
            if(usuario.getRol().equals("Administrador")){
                
              HttpSession sesionUsuario = request.getSession(true);
                sesionUsuario.setAttribute("usuario", usuario);

                response.sendRedirect("SvListarUsuarios");  
  
            }
            else{
            
                HttpSession sesionUsuario = request.getSession(true);
                sesionUsuario.setAttribute("usuario", usuario);

                response.sendRedirect("SvListarNotas");
 
            }
            
        
        }
        
        else{       
            request.setAttribute("error", "Correo o contraseña incorrectos.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        
        
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
