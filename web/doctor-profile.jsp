<%-- 
    Document   : search-doctors
    Created on : Jan 21, 2018, 6:30:09 PM
    Author     : Brothers
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctors Appointment System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </head>
    <body> 
        <header>
            <center><h1>Doctors Appointment System</h1></center>
        </header>
        <section class="col-md-12 center-side">
            <%
            if(session.getAttribute("user_acc")!= null){
            %>
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Welcome, Patient <i class="fa fa-arrow-down"></i>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <a class="dropdown-item" href="patient-home.jsp">Home</a>
                  <a class="dropdown-item" href="patient-profile.jsp">My Profile</a>
                  <a class="dropdown-item" href="logout.jsp">Logout</a>
                </div>
              </div>
            <%    
            }else{
            %>
            <a href="index.jsp" class="btn btn-primary">I am a doctor</a> <a href="find-doctor.jsp" class="btn btn-primary">Find Doctor?</a>
            <%
            }
            %>
            <div class="col-md-12 login-doctors" style="margin-top: 25px;"><br>
                <h3 class="text-left">Doctor Profile Details</h3><br>
                <div class="col-md-12">
                    <%
                        int did=Integer.parseInt(request.getParameter("did"));
                        Database db=new Database();
                        ResultSet rs=db.getDoctorDetailsById(did);
                        if(rs.next()){
                            int stateid=rs.getInt("state_id");
                            int cityid=rs.getInt("city_id");
                            String statename=db.getStateNameById(stateid);
                            String cityname=db.getCityNameById(cityid);
                    %>
                    <div class="media">    
                        <table class="table table-bordered">
                            <tr><th>Doctor name</th><td><%=rs.getString("fullname")%></td></tr>
                            <tr><th>Mobile no.</th><td><%=rs.getString("mobno")%></td></tr>
                            <tr><th>clinic name</th><td><%=rs.getString("cname")%></td></tr>
                            <tr><th>clinic address</th><td><%=rs.getString("caddress")%></td></tr>
                            <tr><th>State</th><td><%=statename%></td></tr>
                            <tr><th>City</th><td><%=cityname%></td></tr>
                            <tr><th>Qualification</th><td><%=rs.getString("quali")%></td></tr>
                        </table>
                    </div>
                    <a href="create-appointment.jsp?did=<%=rs.getInt("id")%>" class="btn btn-primary text-center">Create Appointment</a>
                    <br><br>
                <%
                        }
                %>
                </div>
               
            </div>
        </section>
        <section class="col-md-12"><br>
            <h5 class="text-center">Copyright 2021. All rights reserved.</h5>
        </section>
    </body>
</html>
