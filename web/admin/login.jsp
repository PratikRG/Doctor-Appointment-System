<%-- 
    Document   : login
    Created on : Jan 21, 2018, 3:33:43 PM
    Author     : Brothers
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
        <style>
            .login-widget{
                float: none;
                display: grid;
                margin: auto;
                border: 1px grey solid;
                padding: 20px;
                background-color: lightsteelblue;
            }
        </style>
    </head>
    <body>
        <header style="background-color: #2ec5a178; padding: 15px;">
            <center><h1>Admin Panel</h1></center>
        </header>
        <section class="col-md-12"><br><br><br><br><br><br>
                <div class="row">
                    <div class="col-md-3 login-widget">
                        <%
                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("0")){
                                    %>
                                    <div class="alert alert-danger">
                                       Invalid Username/Password!
                                    </div>
                                    <%
                                }
                            }
                        %>
                        <h3 class="text-center">LOGIN</h3>
                        <form action="../WebService.jsp" method="post">
                            <div class="col-md-12">
                                <label>Username</label>
                                <input type="text" class="form-control" name="username" required="true" placeholder="Username">
                            </div>
                            <div class="col-md-12"><br>
                                <label>Password</label>
                                <input type="password" class="form-control" name="password" required="true" placeholder="Password">
                            </div>
                            <div class="col-md-12 text-center"><br>
                                <input type="hidden" value="admin_login" name="action"/>
                                <button type="submit" class="btn btn-default">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
        </section>
    </body>
</html>
