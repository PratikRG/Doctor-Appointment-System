<%-- 
    Document   : WebService
    Created on : Jan 26, 2018, 10:30:10 AM
    Author     : Brothers
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.InputStream"%>
<%@page import="database.Database"%>
<%
    Database db=new Database();
    String action=request.getParameter("action");
    System.out.println(action);
    switch(action){
        case "doctor_reg":
            String fullname=request.getParameter("fullname");
            String mobno=request.getParameter("mobno");
            String cname=request.getParameter("cname");
            String caddress=request.getParameter("caddress");
            String states=request.getParameter("states");
            String cities=request.getParameter("cities");
            String quali=request.getParameter("quali");
            String username=request.getParameter("username");
            String password=request.getParameter("password");
                       
                boolean resuserreg=db.doctorRegister(fullname,mobno,cname,caddress,states,cities,quali,username,password);
                if(resuserreg){
                 response.sendRedirect("doctor-register.jsp?status=1");
                }else{
                 response.sendRedirect("doctor-register.jsp?status=0");
                }
            
            break;
        case "doctor_login":
            String username1=request.getParameter("username");
            String password1=request.getParameter("password");
            String res=db.checkUserLogin(username1, password1);
            if(res=="0"){
                response.sendRedirect("index.jsp?login=0");
            }else{
                session.setAttribute("user_acc",res);
                response.sendRedirect("home.jsp");
            }
            break;
        case "patientlogin":
            String username23=request.getParameter("username");
            System.out.println(username23);
            String password23=request.getParameter("password");
            String res24=db.checkPatientLogin(username23, password23);
            if(res24=="0"){
                response.sendRedirect("patient-login.jsp?login=0");
            }else{
                session.setAttribute("user_acc",res24);
                response.sendRedirect("patient-home.jsp");
            }
            break;
        case "admin_login":
            String username2=request.getParameter("username");
            String password2=request.getParameter("password");
            boolean res2=db.checkAdminLogin(username2, password2);
            if(res2){
                response.sendRedirect("admin/appointments.jsp");
            }else{
                response.sendRedirect("admin/login.jsp?status=0");
            }
            break;
        case "updateuserstatus":
            int id=Integer.parseInt(request.getParameter("id"));
            int status=Integer.parseInt(request.getParameter("status"));
            boolean uus=db.updateUsersStatus(id,status);
            if(uus){
                out.print(1);
            }else{
                out.print(0);
            }
            break;
        case "updatepatientstatus":
            int id12=Integer.parseInt(request.getParameter("id"));
            int status32=Integer.parseInt(request.getParameter("status"));
            boolean uuss=db.updatePatientsStatus(id12,status32);
            if(uuss){
                out.print(1);
            }else{
                out.print(0);
            }
            break;
        case "updateadminpassword":
            String pwd1=request.getParameter("pwd");
            String npwd1=request.getParameter("npwd");
            String cpwd1=request.getParameter("cpwd");
            
            boolean ress1=db.userPasswordAdminUpdate(cpwd1,pwd1);
                if(ress1){
                 response.sendRedirect("admin/change-pwd.jsp?status=1");
                }else{
                 response.sendRedirect("admin/change-pwd.jsp?status=0");
                }
            break;
        case "updatestatus":
            int id122=Integer.parseInt(request.getParameter("id"));
            int status322=Integer.parseInt(request.getParameter("status"));
            String tab2=request.getParameter("tab");
            boolean uuss2=db.updateStatus(id122,status322,tab2);
            if(uuss2){
                out.print(1);
            }else{
                out.print(0);
            }
            break;
        case "removedata":
            int id1=Integer.parseInt(request.getParameter("id"));
            String tab=request.getParameter("tab");
            boolean rem=db.removeData(id1,tab);
            if(rem){
                out.print(1);
            }else{
                out.print(0);
            }
            break;
        case "getcitiesbystateid":
            int stateid=Integer.parseInt(request.getParameter("stateid"));
            ResultSet citydata=db.getCitiesByStateId(stateid);
            String opt="<option value=''>Select City</option>";
                    while(citydata.next()){
                        String ctname=citydata.getString("name");
                        String ctid=citydata.getString("id");
                        opt+="<option value='"+ctid+"'>"+ctname+"</option>";
                    }
                    out.println(opt);
            break;
        
        case "updateprofdetails":
            int id11=Integer.parseInt(request.getParameter("id"));
            String username11=request.getParameter("user_name");
            String email11=request.getParameter("email");
            String contactno11=request.getParameter("contactno");
            String address11=request.getParameter("address");
            String aadhaarno11=request.getParameter("aadhaarno");
            boolean ress=db.userProfileUpdate(id11,username11,email11,contactno11,address11,aadhaarno11);
                if(ress){
                 response.sendRedirect("my-profile.jsp?status=1");
                }else{
                 response.sendRedirect("my-profile.jsp?status=0");
                }
            break;
        case "updatepatientdetails":
            int id7=Integer.parseInt(request.getParameter("id"));
            String name7=request.getParameter("name");
            String email7=request.getParameter("email");
            String mobile7=request.getParameter("mobile");
            String dob7=request.getParameter("dob");
            String states6=request.getParameter("states");
            String cities6=request.getParameter("cities");
            String gender7=request.getParameter("gender");
            String address7=request.getParameter("address");
            boolean res67=db.userPatientUpdate(id7,name7,email7,mobile7,dob7,states6,cities6,gender7,address7);
                if(res67){
                 response.sendRedirect("patient-profile.jsp?status=1");
                }else{
                 response.sendRedirect("patient-profile.jsp?status=0");
                }
            break;
         case "updatepatientpwd":
            int id8=Integer.parseInt(request.getParameter("id"));
            String cpass=request.getParameter("pwd");
            String npwd=request.getParameter("npwd");
            String cpwd=request.getParameter("cpwd");
            if(npwd.equals(cpwd)){
                boolean res88=db.userPatientPwdUpdate(id8,npwd,cpass);
                if(res88){
                 response.sendRedirect("patient-profile.jsp?status1=1");
                }else{
                 response.sendRedirect("patient-profile.jsp?status1=0");
                }
            }else{
                response.sendRedirect("patient-profile.jsp?status1=2");
            }
            
            break;
         case "updatedoctordetails":
            int id6=Integer.parseInt(request.getParameter("id"));
            String ufullname=request.getParameter("fullname");
            String umobno=request.getParameter("mobno");
            String ucname=request.getParameter("cname");
            String ucaddress=request.getParameter("caddress");
            String ustates=request.getParameter("states");
            String ucities=request.getParameter("cities");
            String uquali=request.getParameter("quali");
            String uusername=request.getParameter("username");
            String upassword=request.getParameter("password");
            
            boolean ress6=db.updateDoctorDetails(id6,ufullname,umobno,ucname,ucaddress,ustates,ucities,uquali,uusername,upassword);
                if(ress6){
                 response.sendRedirect("my-profile.jsp?status=1");
                }else{
                 response.sendRedirect("my-profile.jsp?status=0");
                }
            break;
        case "createappoint":
            String pname2=request.getParameter("pname");
            String createappoint=request.getParameter("createappoint");
            String dob=request.getParameter("dob");
            String email=request.getParameter("email");
            String mobno2=request.getParameter("mobno");
            String appotdate=request.getParameter("appotdate");
            String appottime=request.getParameter("appottime");
            String gender=request.getParameter("gender");
            String problem=request.getParameter("problem");
            String address=request.getParameter("address");
            String states2=request.getParameter("states");
            String cities2=request.getParameter("cities");
            String passwordd=request.getParameter("password");
            String did=request.getParameter("did");
            String sessid="";
            try{
                sessid=(String)session.getAttribute("user_acc");
            }catch(Exception e){
                sessid="";
            }
            boolean crappo=false;
                     System.out.println(sessid);
                     if(createappoint.equals("login")){
                         crappo=db.createAppoint(pname2,dob,email,appotdate,appottime,mobno2,gender,problem,address,states2,cities2,did,passwordd,sessid);
                     }else{
                         crappo=db.createAppoint(pname2,dob,email,appotdate,appottime,mobno2,gender,problem,address,states2,cities2,did,passwordd);
                     }
                
                if(crappo){
                 response.sendRedirect("create-appointment.jsp?did="+did+"&status=1");
                }else{
                 response.sendRedirect("create-appointment.jsp?did="+did+"&status=0");
                }
            
            break;
    }
    %>
