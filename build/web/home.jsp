<%-- 
    Document   : home
    Created on : Jan 11, 2021, 2:20:38 AM
    Author     : tawfe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<%
    /*String username = request.getSession().getAttribute("session_username").toString();
    String email = request.getSession().getAttribute("session_email").toString();
    String displayname = request.getSession().getAttribute("session_displayname").toString();
    String password = request.getSession().getAttribute("session_password").toString();
    String phonenumber = request.getSession().getAttribute("session_phonenumber").toString();
    String role = request.getSession().getAttribute("session_role").toString();*/

    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String username = "";
    String displayname = "";
    String phonenumber = "";
    String role = "";

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/hotel_reservation_system_db?useSSL=false";
    String user = "root";
    String passworddb = "troot";
    Connection connection = null;
    Statement statement = null;
    connection = (Connection) DriverManager.getConnection(url, user, passworddb);
    statement = (Statement) connection.createStatement();
    String query = "SELECT * FROM user";
    ResultSet resultSet = null;
    resultSet = statement.executeQuery(query);
    while (resultSet.next()) {
        if (resultSet.getString("email").equals(email) && resultSet.getString("password").equals(password)) {
            username = resultSet.getString("username");
            displayname = resultSet.getString("display_name");
            phonenumber = resultSet.getString("phone_number");
            role = resultSet.getString("role");
        }
    }
%>
<html>
    <head>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@200&family=Roboto:wght@100&display=swap" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="hotelicon.png">
        <title>Home ( <%= displayname%> )</title>
        <script type="text/javascript" src="homescript.js"></script>
        <style>
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body{
                background: #f2f2f2;
                font-family: 'Nunito', sans-serif;
            }
            nav{
                background: #1b1b1b;
                box-shadow: 5px 5px 18px #888888;
            }
            nav:after{
                content: '';
                clear: both;
                display: table;
            }
            nav .logo{
                float: left;
                color: #27a327;
                font-size: 27px;
                font-weight: 600;
                line-height: 70px;
                padding-left: 60px;
            }
            nav .cname{
                float: left;
                color: white;
                font-size: 18px;
                font-weight: 600;
                line-height: 70px;
                padding-left: 60px;
            }
            nav ul{
                float: right;
                list-style: none;
                margin-right: 40px;
                position: relative;
            }
            nav ul li{
                float: left;
                display: inline-block;
                background: #1b1b1b;
                margin: 0 5px;
            }
            nav ul li a{
                color: white;
                text-decoration: none;
                line-height: 70px;
                font-size: 16px;
                padding: 8px 15px;
                text-transform: uppercase;
            }
            nav ul li a:hover{
                color: #27a327;
                border-radius: 5px;
            }
            nav .logout:hover{
                box-shadow: 0 0 5px #27a327, 0 0 5px #27a327;
            }
            nav ul ul li a:hover{
                color: #27a327;
                box-shadow: none;
            }
            nav ul ul{
                position: absolute;
                top: 90px;
                border-top: 3px solid #27a327;
                opacity: 0;
                visibility: hidden;
                transition: top .3s;
                box-shadow: 5px 10px 18px #888888;
            }
            nav ul li:hover > ul{
                top: 70px;
                opacity: 1;
                visibility: visible;
            }
            nav ul ul li{
                position: relative;
                margin: 0px;
                width: 150px;
                float: none;
                display: list-item;
                border-bottom: 1px solid rgba(0,0,0,0.3);
            }
            nav ul ul li a{
                line-height: 50px;
            }
            .search_container{
                margin: 50px auto;
                width: 500px;
                max-width: 90%
            }
            .search_container h3{
                text-align: center;
                margin-top: 5px;
                font-family: 'Nunito', sans-serif;
            }
            .search_container .btn-search{
                background: #27a327;
                cursor: pointer;
                border-radius: 1px;
                box-shadow: 0 8px 16px rgba(0,0,0,.3);
                padding-top: 10px;
                padding-right: 10px;
                padding-left: 10px;
                padding-bottom: 10px;
                text-align: center;
                width: 100%;
                height: 50px;
                color: white;
                border-radius: 1px;
                border: 0px solid silver;
                margin: 15px 0 10px 0;
                padding: 0 10px;
                font-family: 'Nunito', sans-serif;
            }
            .search_container form{
                width: 100%;
                height: 100%;
                background: white;
                border-radius: 1px;
                box-shadow: 0 8px 16px rgba(0,0,0,.3);
                padding-top: 10px;
                padding-right: 10px;
                padding-left: 10px;
                padding-bottom: 10px;
            }
            .search_container form .form_group{
                text-align: center;
                width: 100%;
                height: 50px;
                color: black;
                border-radius: 1px;
                border: 0px solid silver;
                margin: 15px 0 10px 0;
                padding: 0 30px;
                font-family: 'Nunito', sans-serif;
            }
            .city-menu{
                padding: 8px 12px;
                color: #333333;
                width: 100%;
                height: 80%;
                text-align: center;
                background-color: #eee;
                border: 1px solid #dddddd;
                cursor: pointer;
                border-radius: 1px;
            }
            .city-menu:focus,
            .city-menu:hover{
                outline: none;
                border: 1px solid #bbbbbb;
            }
            .city-menu option{
                background: #ffffff;
            }
        </style>
    </head>
    <body>
        <nav>
            <div class="logo">Hotel System</div>
            <div class="cname">Welcome: <%=displayname%></div>
            <ul>
                <li><a href="profile.jsp">Profile</a></li>
                <li>
                    <a href="#">Features</a>
                    <ul>
                        <li><a href="#">Pages</a></li>
                        <li><a href="#">Elements</a></li>
                        <li><a href="#">Icons</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">Services</a>
                    <ul>
                        <li><a href="#">Web Design</a></li>
                        <li><a href="#">App Design</a></li>
                        <li><a href="#">More</a></li>
                    </ul>
                </li>
                <li><a href="#">Portfolio</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="#" class="logout">Log Out</a></li>
            </ul>
        </nav>

        <div class="search_container">
            <form class="form">

                <h3>Find deals on hotels, homes and much more...</h3>
                <div class="form_group">
                    <select class="city-menu" id="city" name="cityList" data-dropdown>
                        <option value="" disabled selected>Where are you going?</option>
                        <%

                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost:3306/hotel_reservation_system_db?useSSL=false";
                            user = "root";
                            passworddb = "troot";
                            connection = null;
                            statement = null;
                            connection = (Connection) DriverManager.getConnection(url, user, passworddb);
                            statement = (Statement) connection.createStatement();
                            query = "SELECT * FROM hotel";
                            resultSet = null;
                            resultSet = statement.executeQuery(query);
                            while (resultSet.next()) {
                        %>
                        <option value="<%=resultSet.getString("hotel_location")%>"><%=resultSet.getString("hotel_location")%></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form_group">
                    <label>Check In</label>
                    <br>
                    <input class="city-menu" type="date" name="checkindate"/>
                </div>
                <div class="form_group">
                    <label>Check Out</label>
                    <br>
                    <input class="city-menu" type="date" name="checkoutdate"/>
                </div>
                <div class="form_group">
                    <label>Number of Adults</label>
                    <br>
                    <select class="city-menu">
                        <option value="" disabled selected>Number of adults</option>
                        <option value="1" >1</option>
                        <option value="2" >2</option>
                        <option value="3" >3</option>
                        <option value="4" >4</option>
                        <option value="5" >5</option>
                    </select>
                </div>
                <div class="form_group">
                    <label>Number of Children</label>
                    <br>
                    <select class="city-menu">
                        <option value="" disabled selected>Number of children</option>
                        <option value="0" >0</option>
                        <option value="1" >1</option>
                        <option value="2" >2</option>
                        <option value="3" >3</option>
                        <option value="4" >4</option>
                        <option value="5" >5</option>
                    </select>
                </div>
                <br>
                <div class="form_group">
                    <div id="txtHint">Data</div>
                </div>
            </form>
            <div class="form_group">
                <button type="button" class="btn-search" id="sub" onclick="searchHotels()">Submit</button>
            </div>
        </div>
    </body>
</html>
