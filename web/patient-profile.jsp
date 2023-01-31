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
        <%
        Database db=new Database();
                        String id=(String)session.getAttribute("user_acc");
ResultSet rs=db.getPatientDetailsById(Integer.parseInt(id));
                if(rs.next()){
        %>
        <section class="col-md-12">
            
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
            <div class=" col-md-4 login-doctors" style="margin-top: 65px; float: left;"><br>
                <%
                            if(request.getParameter("status1")!= null){
                                String login=request.getParameter("status1");
                                if(login.equals("0")){
                                    %>
                                    <div class="alert alert-danger">
                                       Current password not exist!
                                    </div>
                                    <%
                                }else if(login.equals("2")){
                                    %>
                                    <div class="alert alert-danger">
                                       Password not match!
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-success">
                                       Account Password Updated Successfully! 
                                    </div>
                                    <%
                                }
                            }
                        %>
                <h3 class="text-center">Change Password</h3><br>
               
                <form action="WebService.jsp" method="POST" name="patientpwdform">
                    <input type="hidden" value="<%=rs.getInt("id")%>" name="id"/>
                    <div class="col-md-6">
                        <label>Current Password</label>
                        <input type="password" class="form-control" name="pwd" id="pwd" required="true" style="background-color: #ffffff8c;" placeholder="********"><br>
                    </div>
                    <div class="col-md-6">
                        <label>New Password</label>
                        <input type="password" class="form-control" name="npwd" id="npwd" required="true" style="background-color: #ffffff8c;" placeholder="********"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Confirm Password</label>
                        <input type="password" class="form-control" name="cpwd" id="cpwd" required="true" style="background-color: #ffffff8c;" placeholder="********"><br>
                    </div>
                    <div class="col-md-12">
                        <button type="button" onclick="updatepwddetails();" class="btn btn-success">Update</button>  <br><br><br><br>
                    </div>
                        <input type="hidden" value="updatepatientpwd" name="action" />
                </form>
            </div>
            <div class=" col-md-6 login-doctors" style="margin-top: 65px; float:left;"><br>
                <%
                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("0")){
                                    %>
                                    <div class="alert alert-danger">
                                       Problem with updation!
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-success">
                                       Your details updated successfully! 
                                    </div>
                                    <%
                                }
                            }
                        %>
                <h3 class="text-center">Patient Profile Details</h3><br>
               <%
                
               %>
                <form action="WebService.jsp" method="POST" name="patientrefform">
                    <input type="hidden" value="<%=rs.getInt("id")%>" name="id"/>
                    <div class="col-md-4">
                        <label>Name</label>
                        <input type="text" class="form-control" value="<%=rs.getString("name")%>" name="name" id="name" required="true" style="background-color: #ffffff8c;" placeholder="Name"><br>
                    </div>
                    <div class="col-md-4">
                        <label>Mobile No</label>
                        <input type="text" maxlength="10" class="form-control"  value="<%=rs.getString("mobile")%>" name="mobile" id="mobile" required="true"  style="background-color: #ffffff8c;" placeholder="Mobile No"><br>
                    </div>
                    <div class="col-md-4">
                        <label>Email</label>
                        <input type="text" class="form-control" required="true"  value="<%=rs.getString("email")%>" id="email" name="email" style="background-color: #ffffff8c;" placeholder="Email"><br>
                    </div>
                    <div class="col-md-3">
                        <label>Date of Birth</label>
                        <input type="text" class="form-control datepicker" required="true"  value="<%=rs.getString("dob")%>" name="dob" id="dob"  style="background-color: #ffffff8c;" placeholder="DOB"><br>
                    </div>
                    <div class="col-md-3">
                        <label>State</label>
                        <select name="states" id="states" class="form-control">
                            <option  value="">Select State</option>
                        <%
                        ResultSet rsst=db.getStates();
                        while(rsst.next()){
                            %>
                            <option value="<%=rsst.getInt("id")%>" <% if(rs.getString("state_id").equals(rsst.getString("id"))){ out.println("selected");  } %> ><%=rsst.getString("name")%></option>
                            <%
                        }
                        %>
                        </select><br>
                    </div>
                    <div class="col-md-3">
                        <label>City</label>
                        <select name="cities" id="cities" class="form-control">
                            <%
                            ResultSet rscity=db.getCitiesByStateId(Integer.parseInt(rs.getString("state_id")));
                            while(rscity.next()){
                                %>
                                <option value="<%=rscity.getString("id")%>" <% if(rs.getString("city_id").equals(rscity.getString("id"))){ out.println("selected");  } %> ><%=rscity.getString("name")%></option>
                                <%
                            }
                            %>
                        </select><br>
                    </div>
                    <div class="col-md-3">
                        <label>Gender</label><br>
                        <label><input type="radio" <% if(rs.getString("gender").equals("Male")){ out.println("checked"); } %> name="gender" value="Male"> Male </label>
                        <label><input type="radio" <% if(rs.getString("gender").equals("Female")){ out.println("checked"); } %> name="gender" value="Female"> Female </label><br><br>
                    </div>
                    <div class="col-md-12">
                        <label>Address</label>
                        <input type="text" class="form-control" required="true" value="<%=rs.getString("address")%>" name="address" id="address" style="background-color: #ffffff8c;" placeholder="Address"><br>
                    </div>
                     <div class="col-md-12">
                        <button type="button" onclick="updatedetails();" class="btn btn-success">Update</button>  <br><br><br><br>
                    </div>
                        <input type="hidden" value="updatepatientdetails" name="action" />
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
    
    function updatedetails(){
        var name=document.getElementById("name").value;
        var mobno=document.getElementById("mobile").value;
        var email=document.getElementById("email").value;
        var dob=document.getElementById("dob").value;
        var states=document.getElementById("states").value;
        var cities=document.getElementById("cities").value;
        var address=document.getElementById("address").value;

        if(name=='' || mobno=='' || email=='' || dob=='' || states=='' || cities=='' || address==''){
            alert("Please fill all details.");
        }else if(!$.isNumeric(mobno)){
            alert("Please enter valid mobile no.");
        }else if(mobno.length!=10){
            alert("Please enter valid mobile no.");
        }else{
            document.patientrefform.submit();
        }
    }
    function updatepwddetails(){
        var pwd=document.getElementById("pwd").value;
        var cpwd=document.getElementById("cpwd").value;
        var npwd=document.getElementById("npwd").value;
       
        if(pwd=='' || cpwd=='' || npwd==''){
            alert("Please fill all details.");
        }else if(cpwd!=npwd){
            alert("Confirm password not match.");
        }else{
            document.patientpwdform.submit();
        }
    }
</script>

