<%-- 
    Document   : index
    Created on : Jan 11, 2018, 7:32:30 AM
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
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.css" />
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
        <script src="css/bootstrap-datepicker.min.js"></script>
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
            <a href="index.jsp" class="btn btn-primary">I am a doctor</a>
            <%
            }
            %>
            <div class=" col-md-4 login-doctors" style="margin-top: 25px;"><br>
                <h3 class="text-center">Create Doctor Appointment</h3><br>
                <%
                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("1")){
                                    %>
                                    <div class="alert alert-success text-center">
                                       Appointment Request Sent Successfully! 
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-danger">
                                       Request not sent!
                                    </div>
                                    <%
                                }
                            }
                        %>
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
                    <form action="WebService.jsp" method="POST" name="createappointform">
                        <input type="hidden" name="action" value="createappoint"/>
                        <input type="hidden" name="did" value="<%=did%>"/>
                    <div class="col-md-12">
                    <div class="media">
                        <div class="media-left">
                            <a href="#">
                                <img class="media-object" src="images/no-image-icon-6.png" style="width:50px" alt="...">
                            </a>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading"><%=rs.getString("fullname")%></h4>
                            <%=rs.getString("quali")%>, <%=rs.getString("cname")%>, <%=rs.getString("caddress")%><br>
                            <a href="doctor-profile.jsp?did=<%=rs.getString("id")%>" class="btn btn-default btn-xs">View Profile</a>
                        </div>
                    </div>
                </div>
                    <div class="col-md-12">
                        <label>Patient name</label>
                        <input type="text" class="form-control" required="true" name="pname" id="pname" style="background-color: #ffffff8c;" placeholder="Patient Name"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Date of birth</label>
                        <input type="text" class="form-control datepicker" required="true" name="dob" id="dob"  style="background-color: #ffffff8c;" placeholder="Birth date"><br>
                    </div>
                    
                    <div class="col-md-6">
                        <label>Email ID</label>
                        <input type="email" class="form-control" required="true" name="email" id="email"  style="background-color: #ffffff8c;" placeholder="Email Id"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Appointment Date</label>
                        <input type="date" class="form-control" required="true" name="appotdate" id="appotdate"  style="background-color: #ffffff8c;" placeholder="Appointment date time"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Appointment Time</label>
                        <input type="time" class="form-control" required="true" name="appottime" id="appottime"  style="background-color: #ffffff8c;" placeholder="Appointment date time"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Mobile No.</label>
                        <input type="number" class="form-control" required="true" name="mobno" id="mobno" style="background-color: #ffffff8c;" placeholder="Mobile No"><br>
                    </div>
                    
                    <div class="col-md-6">
                        <label>Gender</label><br>
                        <label><input type="radio" checked name="gender" value="Male"> Male </label>
                        <label><input type="radio" name="gender" value="Female"> Female </label><br><br>
                    </div>
                    
                    <div class="col-md-12">
                        <label>Briefly describe your problem</label>
                        <textarea class="form-control" required="true" name="problem" id="problem" rows="3" style="background-color: #ffffff8c;" placeholder="Write about your problem."></textarea><br>
                    </div>
                    <div class="col-md-12">
                        <label>Address</label>
                        <textarea class="form-control" required="true" rows="2" name="address" id="address" style="background-color: #ffffff8c;" placeholder="Write address."></textarea><br>
                    </div>
                    
                    <div class="col-md-6">
                        <label>State</label>
                        <select name="states" id="states" class="form-control">
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
                        <select name="cities" id="cities" class="form-control">
                            <option value="">Select city</option>
                        </select><br>
                    </div>
                    <%
                    if(session.getAttribute("user_acc")!= null){
                    %>
                    <input type="hidden" name="createappoint" value="login" />
                    <input type="hidden" class="form-control" required="true" value="111" name="password" id="password">
                    <input type="hidden" class="form-control" required="true" value="111" name="confirm_password" id="confirm_password">
                    </div>
                    <%    
                    }else{
                    %>
                    <input type="hidden" name="createappoint" value="notlogin" />
                    <div class="col-md-6">
                        <label>Password</label>
                        <input type="password" class="form-control" required="true" name="password" id="password" style="background-color: #ffffff8c;" placeholder="Password"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Confirm Password</label>
                        <input type="password" class="form-control" required="true" name="confirm_password" id="confirm_password" style="background-color: #ffffff8c;" placeholder="Confirm Password"><br>
                    </div>
                    <%
                    }
                    %>
                    <div class="col-md-12 text-center">
                        <a href="javascript:createappoint();" class="btn btn-primary">Submit</a>  <br><br><br><br>
                    </div>

                </form>
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
<script>
    $(document).ready(function(){
		var date_input=$('.datepicker'); //our date input has the name "date"
		var container=$('form').length>0 ? $('form').parent() : "body";
		date_input.datepicker({
			format: 'dd-mm-yyyy',
			container: container,
			todayHighlight: true,
			autoclose: true,
		});
	});
        
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
    
    function createappoint(){
        var pname=document.getElementById("pname").value;
        var dob=document.getElementById("dob").value;
        var email=document.getElementById("email").value;
        var appotdate=document.getElementById("appotdate").value;
        var appottime=document.getElementById("appottime").value;
        var mobno=document.getElementById("mobno").value;
        var states=document.getElementById("states").value;
        var cities=document.getElementById("cities").value;
        var problem=document.getElementById("problem").value;
        var address=document.getElementById("address").value;
        var password=document.getElementById("password").value;
        var confirm_password=document.getElementById("confirm_password").value;
        
        if(pname=='' || dob=='' || email=='' || appotdate=='' || appottime=='' || mobno=='' || states=='' || cities=='' || problem=='' || address=='' || password=='' || confirm_password==''){
            alert("Please fill all details.");
        }else if(!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)){
            alert("Please enter valid email address.");
        }else if(!$.isNumeric(mobno)){
            alert("Please enter valid mobile no.");
        }else if(mobno.length!=10){
            alert("Please enter valid mobile no.");
        }else if(password!=confirm_password){
            alert("Password must be same");
        }else{
            document.createappointform.submit();
        }
    }
    </script>
