<%-- 
    Document   : index
    Created on : Jan 11, 2018, 7:32:30 AM
    Author     : Brothers
--%>

<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
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
        <%
        Database db=new Database();
        %>
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
            <a href="index.jsp" class="btn btn-primary">I am a doctor</a>
            <%
            }
            %>
            <div class=" col-md-4 login-doctors" style="margin-top: 65px;"><br>
                <h3 class="text-center">Find Doctor For Appointment</h3><br>
                <form action="search-doctors.jsp" method="POST">
                    <div class="col-md-12">
                        <label>Doctor name</label>
                        <input type="text" class="form-control" required="true" name="doctorname" style="background-color: #ffffff8c;" placeholder="Doctor name"><br>
                    </div>
                    <div class="col-md-6">
                        <label>State</label>
                        <select name="states" id="states" required="true" class="form-control">
                            <option value="">Select State</option>
                        <%
                        ResultSet rsst=db.getStates();
                        while(rsst.next()){
                            %>
                            <option value="<%=rsst.getString("id")%>"><%=rsst.getString("name")%></option>
                            <%
                        }
                        %>
                        </select><br>
                    </div>
                    <div class="col-md-6">
                        <label>City</label>
                        <select name="cities" id="cities" required="true" class="form-control">
                            <option value="">Select city</option>
                        </select><br>
                    </div>
                    
                    <div class="col-md-12 text-center">
                        <button type="submit" class="btn btn-primary">Search</button>  <br><br><br><br>
                    </div>

                </form>
            </div>
        </section>
        <section class="col-md-12"><br>
            <h5 class="text-center">Copyright 2021. All rights reserved.</h5>
        </section>
    </body>
</html>
<script>
    $("#states").change(function(){
        var stateid=this.value;
        $.ajax({
                    url:"WebService.jsp",
                    data:{"stateid":stateid,"action":"getcitiesbystateid"},
                    method:"POST",
                    success:function(res){  
                       //alert(res);
                       $("#cities").html(res);
                    }
                });
    });
</script>
