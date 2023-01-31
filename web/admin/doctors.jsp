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
            <h2>Registered Doctors</h2><hr>
            <table class="table table-bordered">
                <thead>
                    <tr><th>Sr.No.</th><th>Full Name</th><th>Clinic name</th><th>Clinic Address</th><th>Mobile No</th><th>Qualification</th><th>Username</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                <%
                int i=1;
                Database db=new Database();
                ResultSet rs=db.getDoctors();
                while(rs.next()){
                int status=rs.getInt("status");
                
                int states=rs.getInt("state_id");
                int cities=rs.getInt("city_id");
                %>
                    <tr><td><%=i++%></td><td><%=rs.getString("fullname")%></td><td><%=rs.getString("cname")%></td><td><%=rs.getString("caddress")%></td><td><%=rs.getString("mobno")%></td><td><%=rs.getString("quali")%></td><td><%=rs.getString("username")%></td>
                        <td>
                            <%
                            if(status==1){
                                %>
                                <label class="label label-success">Active</label>
                                <%
                            }else{
                                %>
                                <label class="label label-warning">In-Active</label>
                                <%
                            }
                            %>
                        </td>
                        <td>
                            <%
                            if(status==1){
                            %>
                                <a href="javascript:void(0);" id="<%=rs.getInt("id")%>" lable="0" class="btn btn-warning btn-sm status">Decline</a> 
                            <%
                            }else{
                            %>
                                <a href="javascript:void(0);"id="<%=rs.getInt("id")%>" lable="1" class="btn btn-success btn-sm status">Active</a> 
                            <%  
                            }
                            %>
                            <a href="javascript:void(0);" id="<%=rs.getInt("id")%>" lable="doctors" class="btn btn-danger btn-sm remove">Delete</a>
                        </td>
                    </tr>
                    <%
                }
                %>
                </tbody>
            </table>
        </section>
    </body>
</html> 

<script>
   $(document).on('click','.status',function(){
       var id=this.id;
       var status=$(this).attr("lable");
       $.ajax({
           method:"post",
           data:{"id":id,"status":status,"action":"updateuserstatus"},
           url:"../WebService.jsp",
           success:function(res){
               //alert(res);
               window.location.reload();
           }
       });
   }); 
</script>

<script>
   $(document).on('click','.remove',function(){
       var id=this.id;
       var tab=$(this).attr("lable");
       if(confirm("Are you sure?")){
            $.ajax({
                method:"post",
                data:{"id":id,"tab":tab,"action":"removedata"},
                url:"../WebService.jsp",
                success:function(res){
                    //alert(res);
                    window.location.reload();
                }
            });
        }
   }); 
</script>
