<%-- 
    Document   : index
    Created on : Jan 11, 2018, 7:32:30 AM
    Author     : Brothers
--%>

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
            <a href="find-doctor.jsp" class="btn btn-primary">Find Doctor</a>
            <a href="patient-login.jsp" class="btn btn-info pull-right">Patient Login</a>
            <br>
            <div class=" col-md-4 login-doctors" style="margin-top: 65px;"><br><br>
                <h3 class="text-center">Doctors Login</h3>
                <form action="WebService.jsp" method="POST">
                    <div class="col-md-12">
                        <label>Username</label>
                        <input type="text" class="form-control" required="true" name="username" style="background-color: #ffffff8c;" placeholder="Username"><br>
                    </div>
                    <div class="col-md-12">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" required="true"  style="background-color: #ffffff8c;" placeholder="********"><br>
                    </div>
                    <input type="hidden" name="action" value="doctor_login" />
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-default">LOGIN</button> <a href="doctor-register.jsp">Register New Doctor</a><br><br><br><br>
                    </div>
                </form>
            </div>
        </section>
        <section class="col-md-12"><br>
            <h5 class="text-center">Copyright 2021. All rights reserved.</h5>
        </section>
    </body>
</html>
