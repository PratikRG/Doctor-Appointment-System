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
    </head>
    <body>
        <%@ include file="parts/header.jsp" %>
        <section class="center-side col-md-12">
            <h2>Appointment Details</h2><hr>
            <div class="col-md-6">
                <h4><b>Appointment Date : 12-01-2018</b></h4>
            </div>
            <div class="col-md-6">
                <h4><b>Appointment Status : <label class="label label-success">Finish</label> <label class="label label-warning">Canceled</label> <label class="label label-default">Pending</label></b></h4>
            </div>
            <div class="col-md-6">
                <h4>Patient Details</h4>
                <table class="table table-bordered">
                    <tr><th>Patient name : </th><td>Anup sable</td></tr>
                    <tr><th>Address : </th><td>Sai nagar, Arvi</td></tr>
                    <tr><th>City : </th><td>Arvi</td></tr>
                    <tr><th>State : </th><td>Maharashtra</td></tr>
                    <tr><th>Problem Description : </th><td>asdasda sd asd asd asd as da sdasdasd asdas</td></tr>
                    <tr><th>Mobile No. : </th><td>2323232323</td></tr>
                    <tr><th>Birth date : </th><td>28-09-1999</td></tr>
                    <tr><th>Gender : </th><td>Male</td></tr>
                    <tr><th>Email ID : </th><td>anup@gmail.com</td></tr>
                </table>
            </div>
            <div class="col-md-6">
                <h4>Doctor Details</h4>
                <table class="table table-bordered">
                    <tr><th>Doctor Name : </th><td>Anup sable</td></tr>
                    <tr><th>Clinic Name : </th><td>Om Sai Clinic</td></tr>
                    <tr><th>Clinic Address : </th><td>Sai nagar, Arvi</td></tr>
                    <tr><th>Mobile No. : </th><td>2323232323</td></tr>
                    <tr><th>Qualification : </th><td>MD</td></tr>
                    <tr><th>City : </th><td>Arvi</td></tr>
                    <tr><th>State : </th><td>Maharashtra</td></tr>
                </table>
            </div>
        </section>
    </body>
</html> 
