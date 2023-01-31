<%-- 
    Document   : index
    Created on : Jan 10, 2018, 6:04:55 PM
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
        <link rel="stylesheet" type="text/css" href="http://localhost:8084/eauction2018/admin-panel/css/style.css" />
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
        <style>
            .widget{
                float: none;
                display: grid;
                margin: auto;
                border: 1px grey solid;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <%@ include file="parts/header.jsp" %> 
        
        <section class="center-side col-md-3 widget">
            <%
                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("1")){
                                    %>
                                    <div class="alert alert-success">
                                        Password changed!
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-danger">
                                        Current Password does not matched.
                                    </div>
                                    <%
                                }
                            }
                        %>
            <h3>Change Password</h3><br>
            <form action="../WebService.jsp" name="updatepwd" method="post">
                <div class="col-md-12">
                    <label>Current Password</label>
                    <input type="password" class="form-control" name="pwd" id="pwd" required="true" placeholder="********">
                </div>
                <div class="col-md-12"><br>
                    <label>New Password</label>
                    <input type="password" class="form-control" name="npwd" id="npwd" required="true" placeholder="********">
                </div>
                <div class="col-md-12"><br>
                    <label>Confirm Password</label>
                    <input type="password" class="form-control" name="cpwd" id="cpwd" required="true" placeholder="********">
                </div>
                <input type="hidden" name="action" value="updateadminpassword"/>
                <div class="col-md-12 text-center"><br>
                    <a href="javascript:updatepwd();" class="btn btn-default">Submit</a>
                </div>
            </form>
        </section>
        
    </body>
</html> 
<script>
    function updatepwd(){
        var pwd=document.getElementById("pwd").value;
        var pwd1=document.getElementById("npwd").value;
        var pwd2=document.getElementById("cpwd").value;
        if(pwd==''){
            alert("Please enter password.");
        }else if(pwd1=='' || pwd2==''){
            alert("Please enter password.");
        }else if(pwd1!=pwd2){
            alert("Password does not matched.");
        }else{
            document.updatepwd.submit();
        }
    }
</script>