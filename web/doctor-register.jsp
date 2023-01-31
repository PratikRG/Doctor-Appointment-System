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
            <!--<a href="create-appointment.jsp" class="btn btn-primary">Create Appointment.</a>-->
            <div class=" col-md-4 login-doctors" style="margin-top: 65px;"><br>
                <%
                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("0")){
                                    %>
                                    <div class="alert alert-danger">
                                       Problem with registration!
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-success">
                                       Your are registered successfully! 
                                    </div>
                                    <%
                                }
                            }
                        %>
                <h3 class="text-center">New Doctor Registration</h3><br>
                <form action="WebService.jsp" method="POST" name="doctorrefform">
                    <div class="col-md-12">
                        <label>Full name</label>
                        <input type="text" class="form-control" name="fullname" id="fullname" required="true" style="background-color: #ffffff8c;" placeholder="Full name"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Mobile No</label>
                        <input type="text" maxlength="10" class="form-control" name="mobno" id="mobno" required="true"  style="background-color: #ffffff8c;" placeholder="Mobile No"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Clinic name</label>
                        <input type="text" class="form-control" required="true" id="cname" name="cname" style="background-color: #ffffff8c;" placeholder="Clinic name"><br>
                    </div>
                    <div class="col-md-12">
                        <label>Clinic Address</label>
                        <input type="text" class="form-control" required="true" name="caddress" id="caddress"  style="background-color: #ffffff8c;" placeholder="Clinic Address"><br>
                    </div>
                    <div class="col-md-6">
                        <label>State</label>
                        <select name="states" id="states" class="form-control">
                            <option value="">Select State</option>
                        <%
                            try{
                        ResultSet rsst=db.getStates();
                        while(rsst.next()){
                            %>
                            <option value="<%=rsst.getString("id")%>"><%=rsst.getString("name")%></option>
                            <%
                        }
}catch(Exception e){}
                        %>
                        </select><br>
                    </div>
                    <div class="col-md-6">
                        <label>City</label>
                        <select name="cities" id="cities" class="form-control">
                            <option value="">Select city</option>
                        </select><br>
                    </div>
                    <div class="col-md-6">
                        <label>Qualification</label>
                        <input type="text" class="form-control" name="quali" id="quali" required="true"  style="background-color: #ffffff8c;" placeholder="Qualification"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Username</label>
                        <input type="text" class="form-control" required="true" name="username" id="username" style="background-color: #ffffff8c;" placeholder="Username"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Password</label>
                        <input type="password" class="form-control" required="true" name="password" id="password" style="background-color: #ffffff8c;" placeholder="********"><br>
                    </div>
                    <div class="col-md-6">
                        <label>Confirm Password</label>
                        <input type="password" class="form-control" required="true" name="password1" id="password1" style="background-color: #ffffff8c;" placeholder="********"><br>
                    </div>
                    <div class="col-md-12">
                        <button type="button" onclick="doctorreg();" class="btn btn-success">REGISTER</button> <a href="index.jsp">Doctor's Login</a> <br><br><br><br>
                    </div>
                        <input type="hidden" value="doctor_reg" name="action" />
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
    
    function doctorreg(){
        var fullname=document.getElementById("fullname").value;
        var mobno=document.getElementById("mobno").value;
        var cname=document.getElementById("cname").value;
        var caddress=document.getElementById("caddress").value;
        var states=document.getElementById("states").value;
        var cities=document.getElementById("cities").value;
        var quali=document.getElementById("quali").value;
        var username=document.getElementById("username").value;
        var password=document.getElementById("password").value;
        var password1=document.getElementById("password1").value;
        if(fullname=='' || mobno=='' || cname=='' || caddress=='' || states=='' || cities=='' || quali=='' || username=='' || password=='' || password1==''){
            alert("Please fill all details.");
        }else if(!$.isNumeric(mobno)){
            alert("Please enter valid mobile no.");
        }else if(mobno.length!=10){
            alert("Please enter valid mobile no.");
        }else if(password!=password1){
            alert("Password not matched.");
        }else{
            document.doctorrefform.submit();
        }
    }
</script>

