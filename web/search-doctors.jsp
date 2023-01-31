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
                <h3 class="text-left">Doctor Search Result:</h3><br>
            <%
            String doctorname=request.getParameter("doctorname");
            int states=Integer.parseInt(request.getParameter("states"));
            int cities=Integer.parseInt(request.getParameter("cities"));
           
            Database db=new Database();
            ResultSet rs=db.getDoctorListSearch(doctorname,states,cities);
            System.out.println(rs);
            
            while(rs.next()){
            %>
                <div class="col-md-4">
                    <div class="media">
                        <div class="media-left">
                            <a href="#">
                                <img class="media-object" src="images/no-image-icon-6.png" style="width:50px" alt="...">
                            </a>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading"><%=rs.getString("fullname")%></h4>
                            <%=rs.getString("quali")%>, <%=rs.getString("cname")%>, <%=rs.getString("caddress")%><br>
                            <a href="doctor-profile.jsp?did=<%=rs.getInt("id")%>" class="btn btn-default btn-xs">View Profile</a> 
                            <a href="create-appointment.jsp?did=<%=rs.getInt("id")%>" class="btn btn-primary btn-xs">Create Appointment</a> 
                        </div>
                    </div>
                </div>
                <%
            }
            
                %>
            </div>
        </section>
        <section class="col-md-12"><br>
            <h5 class="text-center">Copyright 2021. All rights reserved.</h5>
        </section>
    </body>
</html>
