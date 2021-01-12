<%-- 
    Document   : userProfile
    Created on : Jan 12, 2021, 11:24:00 AM
    Author     : tawfe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%
    String userId = request.getParameter("id");
    String username = "";
    String displayname = "";
    String email = "";
    String phone ="";
    String password = "";
    String role = "";
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/hotel_reservation_system_db?useSSL=false";
    String user = "root";
    String passworddb = "troot";
    Connection connection = null;
    Statement statement = null;
    connection = (Connection) DriverManager.getConnection(url, user, passworddb);
    statement = (Statement) connection.createStatement();
    String query = "SELECT * from user WHERE user_id='"+userId+"'";
    ResultSet resultSet = statement.executeQuery(query);
    while(resultSet.next()){
        
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile <%=userId%></title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
