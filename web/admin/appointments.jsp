<%-- 
    Document   : index
    Created on : Jan 10, 2018, 6:04:55 PM
    Author     : Brothers
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Database"%>
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
            <h2>Appointments</h2><hr>
                <div class=" col-md-12 login-doctors"><br>
                <table class="table table-bordered">
                    <tr>
                        <th>Sr.No.</th><th>Appointment Date</th><th>Doctor Name</th><th>Patient Name</th><th>Mobile No.</th><th>DOB</th><th>Problem</th><th>Status</th>
                    </tr>
            <%
            Database db=new Database();
            ResultSet rs =db.getAppoints();
            if(rs!=null){
                int i=1;
                while(rs.next()){
                    int patient_id=rs.getInt("patient_id");
                    int doctors_id=rs.getInt("doctors_id");
                    String appoint_date=rs.getString("appoint_date");
                    String appoint_time=rs.getString("atime");
                    String problem=rs.getString("problem");
                    int status=rs.getInt("status");
                    ResultSet rs2=db.getDoctorDetailsById(doctors_id);
                    ResultSet rs1=db.getPatientDetailsById(patient_id);
                    
                    if(rs2.next()){
                    if(rs1!=null){
                        while(rs1.next()){
                            String pname=rs1.getString("name");
                            String dob=rs1.getString("dob");
                            String mobile=rs1.getString("mobile");
                            String address=rs1.getString("address");
                            %>
                            <tr>
                                <th><%=i++%></th><th><%=appoint_date%> <%=appoint_time%></th><th><%=rs2.getString("fullname")%></th><th><%=pname%></th><th><%=mobile%></th><th><%=dob%></th><th><%=problem%></th>
                                <th>
                                    <%
                            if(status==1){
                                %>
                                <label class="label label-success">Accepted</label>
                                <%
                            }else if(status==2){
                                %>
                                <label class="label label-warning">Rejected</label>
                                <%
                            }else if(status==0){
                                %>
                                <label class="label label-default">Pending</label>
                                <%
                            }else if(status==3){
                                %>
                                <label class="label label-danger">Canceled</label>
                                <%
                            }else if(status==4){
                                %>
                                <label class="label label-success">Completed</label>
                                <%
                            }
                            %>
                                </th>
                            </tr>
                            <%
                        }
                    }
                }
}
            }
            %>    
                </table>
            </div>

        </section>
    </body>
</html> 
