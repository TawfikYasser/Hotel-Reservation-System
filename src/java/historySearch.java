/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tawfe
 */
@WebServlet(urlPatterns = {"/historySearch"})
public class historySearch extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String from = request.getParameter("from");
            String to = request.getParameter("to");
            
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system_db?useSSL=false";
            String user = "root";
            String passworddb = "troot";
            Connection connection = null;
            connection = (Connection) DriverManager.getConnection(url, user, passworddb);
            String var = "";
            if (from.equals("from")) {//from default

            } else if (to.equals("to")) {//to default

            } else {//from and to selected

                Statement statement1 = null;
                statement1 = (Statement) connection.createStatement();
                ResultSet resultSet = null;
                resultSet = statement1.executeQuery("SELECT * FROM history");
               SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy");
               Date from_d = sdformat.parse(from);
               Date to_d = sdformat.parse(from);
                //out.println("<h1>"+from+"</h1>");
//                out.println("<h1>"+to+"</h1>");

                while (resultSet.next()) {
                               Date in_d = sdformat.parse(resultSet.getString("history_check_in"));
                               Date out_d = sdformat.parse(resultSet.getString("history_check_in"));
                    if(in_d.compareTo(from_d) > 0 && out_d.compareTo(to_d) > 0 ){
                        var = "from before in and out before to";
                    }
                }
                
            }
            
            out.println("<h1>"+var+"</h1>");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
