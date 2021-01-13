<%-- 
    Document   : hotelProfile
    Created on : Jan 11, 2021, 11:52:17 PM
    Author     : tawfe
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String hotel_id = request.getParameter("hotel_id");
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/hotel_reservation_system_db?useSSL=false";
    String user = "root";
    String passworddb = "troot";
    Connection connection = null;
    Statement statement = null;
    Statement statement2 = null;
    connection = (Connection) DriverManager.getConnection(url, user, passworddb);
    statement = (Statement) connection.createStatement();
    statement2 = (Statement) connection.createStatement();
    String query = "SELECT * FROM hotel WHERE hotel_id='" + Integer.valueOf(hotel_id) + "'";
    String query2 = "SELECT * from photos";
    ResultSet resultSet = null;
    ResultSet resultSet2 = null;
    resultSet = statement.executeQuery(query);
    resultSet2 = statement2.executeQuery(query2);
    String hotel_name = "";
    String hotel_city = "";
    String hotel_stars = "";
    String hotel_avg_rate = "";
    String hotel_distance = "";
    String hotel_phone = "";
    String hotel_min_price = "";
    String hotel_max_price = "";
    String hotel_availability = "";
    ArrayList<String> hotel_photos = new ArrayList<>();

    while (resultSet.next()) {
        hotel_name = resultSet.getString("hotel_name");
        hotel_city = resultSet.getString("hotel_city");
        hotel_stars = resultSet.getString("hotel_stars");
        hotel_phone = resultSet.getString("hotel_phone");
        hotel_avg_rate = resultSet.getString("hotel_avg_rate");
        hotel_min_price = resultSet.getString("hotel_price_min");
        hotel_max_price = resultSet.getString("hotel_price_max");
        hotel_availability = resultSet.getString("hotel_availability");
        hotel_distance = resultSet.getString("hotel_distance");
    }
    while (resultSet2.next()) {
        if (resultSet2.getInt("hotel_id") == Integer.valueOf(hotel_id)) {
            hotel_photos.add(resultSet2.getString("photo"));
        }
    }
    ArrayList<String> rComments = new ArrayList<>();
    ArrayList<String> rValues = new ArrayList<>();
    ArrayList<Integer> rUserId = new ArrayList<>();
    ArrayList<String> rUserName = new ArrayList<>();

    statement = null;
    statement = (Statement) connection.createStatement();
    query = "SELECT * FROM rate WHERE hotel_id ='" + hotel_id + "'";
    resultSet = null;
    resultSet = statement.executeQuery(query);
    while (resultSet.next()) {
        rComments.add(resultSet.getString("comment"));
        rValues.add(resultSet.getString("rate"));
        rUserId.add(resultSet.getInt("user_id"));
    }

    statement = null;
    statement = (Statement) connection.createStatement();
    query = "SELECT * FROM user";
    resultSet = null;
    resultSet = statement.executeQuery(query);
    while (resultSet.next()) {
        for (int i = 0; i < rUserId.size(); i++) {
            if (resultSet.getInt("user_id") == rUserId.get(i)) {
                rUserName.add(resultSet.getString("display_name"));
            }
        }

    }

    statement = null;
    statement = (Statement) connection.createStatement();
    query = "SELECT * FROM meals WHERE hotel_id='" + hotel_id + "'";
    resultSet = null;
    resultSet = statement.executeQuery(query);
    ArrayList<String> meals = new ArrayList<>();
    ArrayList<String> meals_price = new ArrayList<>();
    while (resultSet.next()) {
        meals.add(resultSet.getString("meal_name"));
        meals_price.add(resultSet.getString("meal_price"));
    }

    statement = null;
    statement = (Statement) connection.createStatement();
    query = "SELECT * FROM hotel_facilities WHERE hotel_id='" + hotel_id + "'";
    resultSet = null;
    resultSet = statement.executeQuery(query);
    ArrayList<String> facilities = new ArrayList<>();
    while (resultSet.next()) {
        facilities.add(resultSet.getString("hotel_facilities_name"));
    }

    statement = null;
    statement = (Statement) connection.createStatement();
    query = "SELECT * FROM room WHERE hotel_id='" + hotel_id + "'";
    resultSet = null;
    resultSet = statement.executeQuery(query);
    ArrayList<String> room_id = new ArrayList<>();
    ArrayList<String> room_type = new ArrayList<>();
    ArrayList<String> room_availability = new ArrayList<>();
    ArrayList<String> room_price = new ArrayList<>();
    while (resultSet.next()) {
        room_id.add(String.valueOf(resultSet.getInt("room_id")));
        room_type.add(resultSet.getString("room_type"));
        room_availability.add(resultSet.getString("room_availability"));
        room_price.add(resultSet.getString("room_price"));
    }


%>
<html>
    <head>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="jquery-3.5.1.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@200&family=Roboto:wght@100&display=swap" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="hotelicon.png">
        <title><%=hotel_name%></title>
        <script>
            var counter = 0;
            var arr = [];
            var roomids = "";
            var riValue ="";
            function checkDates(element)
            {
                   var currentDate = new Date();
                   if(element.name === "checkindate"){
                       var inputDate = new Date(element.value);
                       if(inputDate < currentDate){
                           alert("Check in date in past");
                       }else{
                           document.getElementById("vCheckInDate").value = inputDate;
                       }
                   }
                   if(element.name === "checkoutdate"){
                    var inputDate = new Date(element.value);
                    var checkin = new Date(document.getElementById("checkindate").value);
                       if(inputDate < currentDate || inputDate < checkin){
                           alert("Check out date in past or check out date is before check in date.");
                       }else{
                            document.getElementById("vCheckOutDate").value = inputDate;
                       }
                   }
            }  
            
            
            function checkAvilability(element,index,room_id){
                alert(room_id);
                roomids += room_id.toString();
                roomids +=",";
                alert(roomids);
                var selectedValue = document.getElementById("room-menu").value;
                if(selectedValue===""){
                    alert("Please choose a room number from above first!");
                }else{
    
                        counter = 0;
                        arr[index] = Number(element.value);
                        var i;
                        for(i= 0 ; i < arr.length ;i++){
                            if(isNaN(arr[i])){
                                arr[i] = 0;
                            }
                            counter+= arr[i];
                        }
                        if(counter > Number(selectedValue)){
                            alert("You must choose only "+selectedValue+" rooms.");
                        } 
                }
            }
            
            function checkOnClick(){
                
                var selectedValue = document.getElementById("room-menu").value;
                if(counter < Number(selectedValue)){
                        alert("You must choose "+selectedValue+" rooms.");
                        return false;
                }else{
                    document.getElementById("vAdults").value = document.getElementById("adults-menu").value;
                    document.getElementById("vChildren").value = document.getElementById("children-menu").value;
                    document.getElementById("vNumberOfRooms").value = document.getElementById("room-menu").value;
                    document.getElementById("vRoomId").value = roomids;
                    return true;
                }
            }
        </script>
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
                background: #ffffff;
                box-shadow: 5px 5px 18px #888888;
            }
            nav:after{
                content: '';
                clear: both;
                display: table;
            }
            nav .logo{
                float: left;
                color: navy;
                font-size: 27px;
                font-weight: 600;
                line-height: 70px;
                padding-left: 60px;
            }
            nav .cname{
                float: left;
                color: navy;
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
                background: #ffffff;
                margin: 0 5px;
            }
            nav ul li a{
                color: navy;
                text-decoration: none;
                line-height: 70px;
                font-size: 16px;
                padding: 8px 15px;
                text-transform: uppercase;
            }
            nav ul li a:hover{
                color: rgba(0,242,254,.8);
                border-radius: 5px;
            }
            nav .logout:hover{
                box-shadow: 0 0 5px rgba(0,242,254,.8), 0 0 5px rgba(0,242,254,.8);
            }
            nav ul ul li a:hover{
                color: rgba(79,172,254,.8);
                box-shadow: none;
            }
            nav ul ul{
                position: absolute;
                top: 90px;
                border-top: 3px solid rgba(0,242,254,.8);
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

            .profile-container{
                margin: 10px auto;
                width: 100%;
                max-width: 100%;
                margin-bottom: 300px;
            }
            .profile-container .rate-card{
                margin: 0px auto;
                margin-bottom: -100px;
                text-align: center;
                width: 100%;
                max-width: 30%;
                height: 300px;
            }
            .profile-container h3{
                text-align: center;
                margin-top: 5px;
                font-family: 'Nunito', sans-serif;
            }
            .container-img{
                position: relative;

            }
            .container-img .btn{
                width: 20%;
                height: 50px;
                border: none;
                margin-top: 100px;
                outline: none;
                background: linear-gradient(to right,rgba(79,172,254,.8),rgba(0,242,254,.8));
                cursor: pointer;
                font-size: 16px;
                text-transform: uppercase;
                color: white;
                border-radius: 1px;
                transition: .3s;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-family: 'Nunito', sans-serif;
            }
            .center-hotel-name {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 60px;
            }
            .hotel_img{
                margin: 10px auto;
                text-align: center;
                width: 100%;
                max-width: 100%;
                height: 650px;
                display: block;
                margin-left: auto;
                margin-right: auto;
                width: 100%;
                opacity: 0.3;

            }
            .hotel_img-additional{
                margin: 10px auto;
                text-align: center;
                width: 300px;
                margin-left: 300px;
                margin-right: auto;
                display: inline-block;
                max-width: 50%;
                height: 300px;
                border-radius: 50%;
            }
            .profile-container form{
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
            .profile-container form .form_group{
                text-align: center;
                width: 100%;
                height: 100%;
                color: black;
                border-radius: 1px;
                border: 0px solid silver;
                margin: 15px 0 10px 0;
                padding: 0 30px;
                font-family: 'Nunito', sans-serif;
            }
            
            .hotel-info{
                font-size: 25px;
            }
            .profile-container .form_group{
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
                width: 50%;
                height: 80%;
                text-align: center;
                background-color: #eee;
                border: 1px solid #dddddd;
                cursor: pointer;
                border-radius: 1px;
                
            }
            table, th, td {
                border-collapse: collapse;
                padding: 15px;
                text-align: center;
                
            }

            table.center {
                margin-left: auto; 
                margin-right: auto;
                border-collapse: collapse;
                border-radius: 5px 5px 0 0;
                overflow: hidden;
                font-size: 0.9em;
                box-shadow: 0 0 20px rgba(0,0,0,0.15);
                margin-bottom: 50px;
            }
            th{
                background-color: #009879;
                color: white;
                text-align: center;
                font-weight: bold;
            }
            .center th,td{
                padding: 12px 15px;
            }
            .center tbody,tr{
                border-bottom: 1px solid #dddddd;
            }
            .center tbody tr:nth-of-type(even){
                background-color: #f3f3f3;
            }
            .profile-container .btn{
                margin-left: 50%;
                transform: translateX(-50%);
                width: 15%;
                margin-bottom: 15px;
                height: 50px;
                border: none;
                outline: none;
                background: #009879;
                cursor: pointer;
                font-size: 16px;
                text-transform: uppercase;
                color: white;
                border-radius: 30px;
                transition: .3s;
                font-family: 'Nunito', sans-serif;
            }
           
            
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">Hotel System</div>
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

        <div class="container-img">
            <img class='hotel_img' src='<%=hotel_photos.get(0)%>'/>
            <div class="center-hotel-name"><b><%=hotel_name%></b></div>
            
                
                <a href="#makeReserve"><input type="submit" class="btn" value="Reserve"></a>

        </div>

        <div class="profile-container">

            <form class="form">
                <h3>Hotel Photos</h3>
                <br>
                <br>
                <br>
                <%for (int i = 1; i < hotel_photos.size(); i++) {%>
                <img class='hotel_img-additional' src='<%=hotel_photos.get(i)%>'/>
                <%}%>
                <br>
                <br>
                <br>
                <br>
                <hr>
                <div class="form_group">
                <label class="hotel-info">Hotel City: <b><%=hotel_city%><b></label>
                            </div>
                            <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Phone: <b><%=hotel_phone%><b></label>
                                </div>
                <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Stars: <b><%=hotel_stars%> stars<b></label>
                                </div>
                <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Distance: <b><%=hotel_distance%> km from center<b></label>
                                </div>
                <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Rating: <b><%=hotel_avg_rate%><b></label>
                                </div>
                <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Minimum Price: $<b><%=hotel_min_price%><b></label>
                                </div>
                <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Maximum Price: $<b><%=hotel_max_price%><b></label>
                                </div>
                <hr>
                <div class="form_group">
                    <label class="hotel-info">Hotel Availability: <b><%=hotel_availability%><b></label>
                                </div>
                                <hr>

                <div class="form_group">
                    <label class="hotel-info">Hotel Ratings</label>
                </div>

                <%if (rUserName.size() > 0) {%>
                <%for (int i = 0; i < rUserName.size(); i++) {%>
                <div class="rate-card">
                    <div class="w3-card-4" >
                        <header class="w3-container w3-blue" style="background-color: navy;">

                            <h1><%=rUserName.get(i)%></h1>

                        </header>

                        <div class="w3-container">
                            <p><%=rComments.get(i)%></p>
                        </div>

                        <footer class="w3-container w3-blue" style="background-color: navy;">
                            <h5><%=rValues.get(i)%></h5>
                        </footer>
                    </div>
                </div>
                <%}%>
                <%}%>
                <hr>

                <%if (meals.size() > 0) {%>
                <div class="form_group">
                    <p class="hotel-info"><strong>Hotel Meals</strong></p>
                    <br>
                    <%for (int i = 0; i < meals.size(); i++) {%>
                    <label class="hotel-info">*Meal <%=(i + 1)%>*</label>
                    <br>
                    <label class="hotel-info">Meal Name: <%=meals.get(i)%></label>
                    <br>
                    <label class="hotel-info">Meal Price: $<%=meals_price.get(i)%></label>
                    <br>
                    <br>
                    <%}%>
                </div>
                <%}%>
                <hr>

                <%if (facilities.size() > 0) {%>
                <div class="form_group">
                    <p class="hotel-info"><b>Most popular facilities</b></p>
                    <br>
                    <%for (int i = 0; i < facilities.size(); i++) {%>
                    <label class="hotel-info">*Facility <%=(i + 1)%>*</label>
                    <br>
                    <label class="hotel-info"><%=facilities.get(i)%></label>
                    <br>
                    <%}%>
                </div>
                <%}%>
                <hr>

                <%if (room_type.size() > 0) {%>
                <div class="form_group">
                    <p class="hotel-info"><b>Hotel Rooms</b></p>
                    <br>
                    <%for (int i = 0; i < room_type.size(); i++) {%>
                    <br>
                    <label class="hotel-info">*Room <%=(i + 1)%>*</label>
                    <br>
                    <label class="hotel-info">Room Type: <%=room_type.get(i)%></label>
                    <br>
                    <label class="hotel-info">Room Availability: <%=room_availability.get(i)%></label>
                    <br>
                    <label class="hotel-info">Room Price: $<%=room_price.get(i)%></label>
                    <br>
                    <%}%>
                </div>
                <%}%>

                
                 <hr>

            
            <div class="form_group">
                <p class="hotel-info" id="makeReserve"><b>Make a reservation</b></p>
                <br>
                
                <div class="form_group">
                    <label>Check In</label>
                    <br>
                    <input class="city-menu" type="date"  name="checkindate" id="checkindate" onchange="checkDates(this)"/>
                </div>
                <div class="form_group">
                    <label>Check Out</label>
                    <br>
                    <input class="city-menu" type="date" name="checkoutdate" id="checkoutdate" onchange="checkDates(this)"/>
                </div>
                <div class="form_group">
                    <label>Number of Adults</label>
                    <br>
                    <select class="city-menu" id="adults-menu">
                        <option value="" disabled selected>Number of adults</option>
                        <option value="1" >1</option>
                        <option value="2" >2</option>
                        <option value="3" >3</option>
                        <option value="4" >4</option>
                        <option value="5" >5</option>
                        <option value="1" >6</option>
                        <option value="2" >7</option>
                        <option value="3" >8</option>
                        <option value="4" >9</option>
                        <option value="5" >10</option>
                    </select>
                </div>
                <div class="form_group">
                    <label>Number of Children</label>
                    <br>
                    <select class="city-menu" id="children-menu">
                        <option value="" disabled selected>Number of children</option>
                        <option value="0" >0</option>
                        <option value="1" >1</option>
                        <option value="2" >2</option>
                        <option value="3" >3</option>
                        <option value="4" >4</option>
                        <option value="5" >5</option>
                        <option value="6" >6</option>
                        <option value="7" >7</option>
                        <option value="8" >8</option>
                        <option value="9" >9</option>
                        <option value="10" >10</option>
                    </select>
                </div>
                <div class="form_group">
                    <label>Number of Rooms</label>
                    <br>
                    <select class="city-menu" id="room-menu">
                        <option value="" disabled selected>Number of rooms</option>
                        <option value="1" >1</option>
                        <option value="2" >2</option>
                        <option value="3" >3</option>
                        <option value="4" >4</option>
                        <option value="5" >5</option>
                        <option value="6" >6</option>
                        <option value="7" >7</option>
                        <option value="8" >8</option>
                        <option value="9" >9</option>
                        <option value="10" >10</option>
                    </select>
                </div>
                <br>
            </div>
                 
                 
                 <div class="table-group">
                     
                     <table class="center">
                         
                         <tr>
                             <th>Room #</th>
                             <th>Room Type</th>
                             <th>Room Price</th>
                             <th>Room Availability</th>
                             <th># Of Rooms</th>
                         </tr>
                         
                         <%for(int i = 0 ;i <room_type.size();i++){%>
                         <tr>
                             <td><%=room_id.get(i)%></td> 
                             <td><%=room_type.get(i)%></td>
                             <td>$<%=room_price.get(i)%></td>
                             <td><%=room_availability.get(i)%></td>
                             <td>
                                 <%if(room_availability.get(i).equals("NO")){%>
                                 <select class="city-menu" disabled>
                                     <option value="" disabled selected>#Rooms ------------</option>
                                     <option value="1" >1</option>
                                     <option value="2" >2</option>
                                     <option value="3" >3</option>
                                     <option value="4" >4</option>
                                     <option value="5" >5</option>
                                     <option value="6" >6</option>
                                     <option value="7" >7</option>
                                     <option value="8" >8</option>
                                     <option value="9" >9</option>
                                     <option value="10" >10</option>
                                 </select>
                                 <%}else{%>
                                 <select class="city-menu" onchange="checkAvilability(this,<%=i%>,<%=room_id.get(i)%>)">
                                     <option value="" disabled selected>#Rooms ------------</option>
                                     <option value="0" >0</option>
                                     <option value="1" >1</option>
                                     <option value="2" >2</option>
                                     <option value="3" >3</option>
                                     <option value="4" >4</option>
                                     <option value="5" >5</option>
                                     <option value="6" >6</option>
                                     <option value="7" >7</option>
                                     <option value="8" >8</option>
                                     <option value="9" >9</option>
                                     <option value="10" >10</option>
                                 </select>
                                 <%}%>
                             </td>
                         </tr>
                         <%}%>
                     </table>
                     
                 </div>
                 
            </form>
                     <form  onsubmit="return checkOnClick()" action="makeReservation" method="Post">
                     <input type="submit" class="btn" id="mRes" value="Apply">
                     <input type="hidden" class="btn" id="vCheckInDate" name="checkin">
                     <input type="hidden" class="btn" id="vCheckOutDate" name="checkout">
                     <input type="hidden" class="btn" id="vAdults" name="adults">
                     <input type="hidden" class="btn" id="vChildren" name="children">
                     <input type="hidden" class="btn" id="vNumberOfRooms" name="norooms">
                     <input type="hidden" class="btn" id="vRoomId" name="roomId">
                     </form>
        </div>

    </body>
</html>