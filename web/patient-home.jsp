<%-- 
    Document   : index
    Created on : Jan 11, 2018, 7:32:30 AM
    Author     : Brothers
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
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
                    <a href="find-doctor.jsp" class="btn btn-primary pull-right">Find Doctor</a>

            <div class=" col-md-10 login-doctors" style="margin-top: 65px;"><br>
                <h3 class="text-center">My Appointments</h3><br>
                <table class="table table-bordered">
                    <tr>
                        <th>Appointment date</th><th>Doctor Name</th><th>Mobile No.</th><th>Clinic name</th><th>Clinic address</th><th>Problem</th><th>Status</th><th>Action</th>
                    </tr>
            <%
         
            String id=(String)session.getAttribute("user_acc");
//            out.print(id);
            ResultSet rs =db.getAppointmentsOfPatientId(id);
            if(rs!=null){
                int i=1;
                while(rs.next()){
                    int doctors_id=rs.getInt("doctors_id");
                    String appoint_date=rs.getString("appoint_date");
                    String problem=rs.getString("problem");
                    int status=rs.getInt("status");
                    String atime=rs.getString("atime");
                    ResultSet rs1=db.getDoctorDetailsById(doctors_id);
                    if(rs1!=null){
                        while(rs1.next()){
                            String pname=rs1.getString("fullname");
                            String cname=rs1.getString("cname");
                            String mobile=rs1.getString("mobno");
                            String caddress=rs1.getString("caddress");
                            %>
                            <tr>
                                <th><%=appoint_date%> <br><b><%=atime%></b></th><th><%=pname%></th><th><%=mobile%></th><th><%=cname%></th><th><%=caddress%></th><th><%=problem%></th>
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
                                <th>
                                    <%
                                    if(status==1 || status==0){
                                    %>
                                   <a href="javascript:void(0);" id="<%=rs.getInt("id")%>" lable="3" class="btn btn-danger btn-sm status">Cancel</a>
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
            %>    
                </table>
            </div>
        </section>
        <section class="col-md-12"><br>
            <h5 class="text-center">Copyright 2021. All rights reserved.</h5>
        </section>
    </body>
</html>
<script>
   $(document).on('click','.status',function(){
       var id=this.id;
       var status=$(this).attr("lable");
       if(confirm("Are you sure?")){
            $.ajax({
                method:"post",
                data:{"id":id,"status":status,"action":"updatestatus","tab":"appoints"},
                url:"WebService.jsp",
                success:function(res){
                    //alert(res);
                    window.location.reload();
                }
            });
        }
   }); 
</script>
