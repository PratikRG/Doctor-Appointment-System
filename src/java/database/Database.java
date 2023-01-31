/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/
package database;
import java.sql.*;
import java.text.DateFormat;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
public class Database
{
    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    public Database() throws SQLException
    {
        try{
            
            //MAKE SURE YOU KEEP THE mysql_connector.jar file in java/lib folder
            //ALSO SET THE CLASSPATH
            
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/appoint","root","root");
            System.out.println("connetion success.....");
            
        }
        catch (ClassNotFoundException e)
        {
            System.out.println("exception : "+e);
        }
    }
    //ip:username,password
    //return boolean
    public Boolean checkAdminLogin(String uname,String pwd)
    {
        try {
            pst=con.prepareStatement("select * from admin where username=? and password=?");
            pst.setString(1, uname); //this replaces the 1st  "?" in the query for username
            pst.setString(2, pwd);    //this replaces the 2st  "?" in the query for password
            //executes the prepared statement
            rs=pst.executeQuery();
            if(rs.next()){
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public String checkUserLogin(String uname,String pwd)
    {
        try {
            pst=con.prepareStatement("select * from doctors where username='"+uname+"' and password='"+pwd+"'");
            rs=pst.executeQuery();
            if(rs.next())
            {
                return rs.getString("id");
            }else{
                return "0";
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
        }
        return "0";
    }
    public Boolean checkCurrentPwdExist(String pwd)
    {
        try {
            pst=con.prepareStatement("select * from admin where password=?");
            pst.setString(1, pwd);
            rs=pst.executeQuery();
            if(rs.next())
            {
                return true;
            }
            else
            {
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public Boolean doctorRegister(String fullname,String mobno,String cname,String caddress,String states,String cities,String quali,String username,String password)
    {
        try {
            pst=con.prepareStatement("insert into doctors (fullname,mobno,cname,caddress,state_id,city_id,quali,username,password) values(?,?,?,?,?,?,?,?,?)");
            pst.setString(1, fullname);
            pst.setString(2, mobno);
            pst.setString(3, cname);
            pst.setString(4, caddress);
            pst.setString(5, states);
            pst.setString(6, cities);
            pst.setString(7, quali);
            pst.setString(8, username);
            pst.setString(9, password);
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public Boolean userProfileUpdate(int id,String username,String email,String contactno,String address,String aadhaarno)
    {
        try {
            pst=con.prepareStatement("update users set name=?,email=?,contactno=?,address=?,aadhaarno=? where id=?");
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, contactno);
            pst.setString(4, address);
            pst.setString(5, aadhaarno);
            pst.setInt(6, id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public Boolean userPasswordUpdate(int id,String pwd,String npwd)
    {
        try {
            pst=con.prepareStatement("update users set password=? where id=? and password=?");
            pst.setString(1, npwd);
            pst.setInt(2, id);
            pst.setString(3, pwd);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public ResultSet getDoctors()
    {
        try {
            pst=con.prepareStatement("select * from doctors");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getPatients()
    {
        try {
            pst=con.prepareStatement("select * from patients");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getDoctorDetailsById(String id){
        try {
            pst=con.prepareStatement("select * from doctors where id="+id);
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    
     
     public boolean updateDoctorDetails(int id5,String ufullname,String umobno,String ucname,String ucaddress,String ustates,String ucities,String uquali,String uusername,String upassword){
         try {
             String pass="";
             ResultSet res=this.getDoctorDetailsById(id5);
             if(upassword.equals("")){
                 res.next();
                 pass=res.getString("password");
             }else{
                 pass=upassword;
             }
            pst=con.prepareStatement("update doctors set fullname=?,mobno=?,cname=?,caddress=?,state_id=?,city_id=?,quali=?,username=?,password=? where id=?");
            pst.setString(1, ufullname);
            pst.setString(2, umobno);
            pst.setString(3, ucname);
            pst.setString(4, ucaddress);
            pst.setString(5, ustates);
            pst.setString(6, ucities);
            pst.setString(7, uquali);
            pst.setString(8, uusername);
            pst.setString(9, pass);
            pst.setInt(10, id5);
            
            //executes the prepared statement
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
     }
     
    public ResultSet getSellers()
    {
        try {
            pst=con.prepareStatement("select * from users where user_type='Seller'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    
    public double getLatestBidAmount(int id,String user_id){
        
        try {
            pst=con.prepareStatement("select max(bid_amount)as bid_amount from bidding where product_id="+id+"");
            rs=pst.executeQuery();
            rs.first();
            return rs.getDouble("bid_amount");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validatingh : "+e);
            return 0;
        }
    }
    
    public int bidonproduct(String id,String amt,String userid,String date){
        
        try {
            pst=con.prepareStatement("select max(bid_amount) bid_amount from bidding where product_id="+id);
            rs=pst.executeQuery();
            if(rs.first()){
                
                Double bidamt=rs.getDouble("bid_amount");
                if(bidamt < Double.parseDouble(amt)){
                    pst=con.prepareStatement("insert into bidding (user_id,product_id,bid_amount,bid_date,status) values(?,?,?,?,?)");
                    pst.setInt(1, Integer.parseInt(userid));
                    pst.setInt(2, Integer.parseInt(id));
                    pst.setDouble(3,Double.parseDouble(amt));
                    pst.setString(4, date);
                    pst.setInt(5, 0);
                    //executes the prepared statement
                    int n=pst.executeUpdate();
                    if(n==1)
                    {
                        //TRUE iff the query founds any corresponding data
                        return 1;
                    }
                }else{
                    return 2;
                }
            }else{
                pst=con.prepareStatement("insert into bidding (user_id,product_id,bid_amount,bid_date,status) values(?,?,?,?,?)");
                    pst.setInt(1, Integer.parseInt(userid));
                    pst.setInt(2, Integer.parseInt(id));
                    pst.setDouble(3,Double.parseDouble(amt));
                    pst.setString(4, date);
                    pst.setInt(5, 0);
                    //executes the prepared statement
                    int n=pst.executeUpdate();
                    if(n==1)
                    {
                        //TRUE iff the query founds any corresponding data
                        return 1;
                    }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return 0;
        }
        return 0;
    }
    public boolean checkbidpresent(String userid,String id,String amt,String date){
        try {
            pst=con.prepareStatement("select bid_amount from bidding where user_id="+userid+" and product_id="+id);
            rs=pst.executeQuery();
            if(rs.first()){
                PreparedStatement pst1=con.prepareStatement("update bidding set bid_amount="+amt+",bid_date="+date+" where user_id="+userid+" and product_id="+id);
                    int n=pst.executeUpdate();
                    if(n==1)
                    {
                        return true;
                    }
            }else{
                return false;
            }
        }catch(Exception e){
            System.out.println("error while validating"+e);
            return false;
        }
        return false;
    }
    public ResultSet getproducts()
    {
        try {
            pst=con.prepareStatement("select * from products where status='1'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validatingg : "+e);
            return null;
        }
    }
    
    public ResultSet getproducts(String keyword)
    {
        try {
            pst=con.prepareStatement("select * from products where status='1' and product_name LIKE '%"+keyword+"%'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validatingg : "+e);
            return null;
        }
    }
    public boolean setProductPhoto(String filename,int pid){
        try {
            pst=con.prepareStatement("update products set img_url='uploads/"+filename+"' where id="+pid);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public ResultSet getProductBids(int pid){
        try {
            pst=con.prepareStatement("select * from bidding where product_id="+pid+" order by bid_amount desc");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getNews()
    {
        try {
            pst=con.prepareStatement("select * from news");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public ResultSet getAnno()
    {
        try {
            pst=con.prepareStatement("select * from announcements");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return null;
        }
    }
    public boolean updateUsersStatus(int id,int status){
        try {
            pst=con.prepareStatement("update doctors set status="+status+" where id="+id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public boolean updatePatientsStatus(int id,int status){
        try {
            pst=con.prepareStatement("update patients set status="+status+" where id="+id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    
    public boolean updateStatus(int id,int status,String tab){
        try {
            pst=con.prepareStatement("update "+tab+" set status="+status+" where id="+id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public boolean selectproduct(int pid,int bidid){
        try {
            pst=con.prepareStatement("update products set status=2 where id="+pid);
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                PreparedStatement pst1=con.prepareStatement("update bidding set status=1 where id="+bidid);
                //executes the prepared statement
                int nn=pst1.executeUpdate();
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public boolean removeData(int id,String tab){
        try {
            pst=con.prepareStatement("delete from "+tab+" where id="+id);
            //executes the prepared statement
            int n=pst.executeUpdate();
            System.out.println(n);
            if(n==1)
            {
                return true;
            }else{
                return false;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
        
    }
    public Boolean addNews(String title,String content)
    {
        try {
            pst=con.prepareStatement("insert into news (title,content) values(?,?)");
            pst.setString(1, title);
            pst.setString(2, content);
            int n=pst.executeUpdate();
            
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
        
    }
    
    public Boolean createAppoint(String pname2,String dob,String email,String appotdate,String appottime,String mobno2,String gender,String problem,String address,String states2,String cities2,String did,String passwordd,String sessid) throws ParseException
    {
       
        try {
//            int check=checkPatientIsExistMobileno(mobno2);
            if(!sessid.equals("")){
                int status=0;
                pst=con.prepareStatement("insert into appoints (patient_id,appoint_date,atime,problem,doctors_id,status) values(?,?,?,?,?,?)");
                pst.setInt(1,Integer.parseInt(sessid));
                pst.setString(2,appotdate);
                pst.setString(3,appottime);
                pst.setString(4, problem);
                pst.setString(5, did);
                pst.setInt(6, status);
                int n=pst.executeUpdate();

                if(n==1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e.getMessage());
            return false;
        }
        return false;
    }
    
    public Boolean createAppoint(String pname2,String dob,String email,String appotdate,String appottime,String mobno2,String gender,String problem,String address,String states2,String cities2,String did,String passwordd) throws ParseException
    {
       
        try {

                int status=1;
                pst=con.prepareStatement("insert into patients (name,dob,email,mobile,gender,address,state_id,city_id,status,password) values(?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                pst.setString(1, pname2);
                pst.setString(2,dob);
                pst.setString(3, email);
                pst.setString(4, mobno2);
                pst.setString(5, gender);
                pst.setString(6, address);
                pst.setString(7, states2);
                pst.setString(8, cities2);
                pst.setInt(9, status);
                pst.setString(10, passwordd);
                int n=pst.executeUpdate();
                if(n==1)
                {
                    ResultSet rs = pst.getGeneratedKeys();
                    rs.next();
                    int patientid=rs.getInt(1);
                    
                    int status1=0;
                    PreparedStatement pst1=con.prepareStatement("insert into appoints (patient_id,appoint_date,atime,problem,doctors_id,status) values(?,?,?,?,?,?)");
                    pst1.setInt(1,patientid);
                    pst1.setString(2,appotdate);
                    pst1.setString(3,appottime);
                    pst1.setString(4, problem);
                    pst1.setString(5, did);
                    pst1.setInt(6, status1);
                    pst1.executeUpdate();

                    return true;
                }else{
                    return false;
                }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e.getMessage());
            return false;
        }
    }
    
    public ResultSet getTodaysAppointmentsOfDocId(String did){
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            System.out.println(dateFormat.format(date)); 
            System.out.print(did);
            
            pst=con.prepareStatement("select * from appoints where doctors_id=? and appoint_date=?");
            pst.setString(1, did);
            pst.setString(2, dateFormat.format(date));          
            rs=pst.executeQuery();
            
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public ResultSet getAppointmentsOfPatientId(String pid){
        try {
            pst=con.prepareStatement("select * from appoints where patient_id=?");
            pst.setString(1, pid);
            rs=pst.executeQuery();
            
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public ResultSet getAppoints(){
        try {
            pst=con.prepareStatement("select * from appoints");
            rs=pst.executeQuery();
            
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public ResultSet getPatientDetailsById(int patientid){
        try {
            pst=con.prepareStatement("select * from patients where id=?");
            pst.setInt(1, patientid);
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    public Boolean userPasswordAdminUpdate(String npwd,String pwd1)
    {
        try {
            pst=con.prepareStatement("update admin set password=? where password=?");
            pst.setString(1, npwd);
            pst.setString(2, pwd1);
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }    
    public Boolean userPatientUpdate(int id6,String name,String email,String mobile,String dob,String states6,String cities6,String gender,String address)
    {
        try {
            pst=con.prepareStatement("update patients set name=?,dob=?,email=?,mobile=?,gender=?,address=?,state_id=?,city_id=? where id=?");
            pst.setString(1, name);
            pst.setString(2, dob);
            pst.setString(3, email);
            pst.setString(4, mobile);
            pst.setString(5, gender);
            pst.setString(6, address);
            pst.setString(7, states6);
            pst.setString(8, cities6);
            pst.setInt(9, id6);
            
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public Boolean userPatientPwdUpdate(int id6,String pass,String cpass)
    {
        try {
            pst=con.prepareStatement("update patients set password=? where id=? and password=?");
            pst.setString(1, pass);
            pst.setInt(2, id6);
            pst.setString(3, cpass);
            
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
            return false;
        }
    }
    public Boolean changepassword(String pwd1)
    {
        try {
            pst=con.prepareStatement("update admin set password='"+pwd1+"'");
            //executes the prepared statement
            int n=pst.executeUpdate();
            if(n==1)
            {
                //TRUE iff the query founds any corresponding data
                return true;
            }
            else
            {
                return false;
            }
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return false;
        }
    }
    
    public String checkPatientLogin(String uname,String pwd)
    {
        try {
            pst=con.prepareStatement("select * from patients where mobile='"+uname+"' and password='"+pwd+"' and status=1");
            rs=pst.executeQuery();
            if(rs.next())
            {
                return rs.getString("id");
            }else{
                return "0";
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while validating"+e);
        }
        return "0";
    }
    
    public ResultSet getStates()
    {
        try {
            pst=con.prepareStatement("select * from states");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public ResultSet getCities()
    {
        try {
            pst=con.prepareStatement("select * from cities");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public String getStateNameById(int stateid)
    {
        try {
            pst=con.prepareStatement("select * from states where id=?");
            pst.setInt(1, stateid);
            rs=pst.executeQuery();
            rs.next();
            return rs.getString("name");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
        public String getCityNameById(int cityid)
    {
        try {
            pst=con.prepareStatement("select * from cities where id=?");
            pst.setInt(1,cityid);
            rs=pst.executeQuery();
            rs.next();
            return rs.getString("name");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public ResultSet getCitiesByStateId(int stateid)
    {
        try {
            pst=con.prepareStatement("select * from cities where state_id=?");
            pst.setInt(1, stateid);
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println("error while val"+e);
            return null;
        }
    }
    
    public ResultSet getDoctorListSearch(String doctorname,int states,int cities) {
        try {
            pst=con.prepareStatement("select * from doctors where status=1 and state_id="+states+" and city_id="+cities+" and fullname LIKE '%"+doctorname+"%'");
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            return null;            
        }
    }
    
    public ResultSet getDoctorDetailsById(int id) {
        try {
            pst=con.prepareStatement("select * from doctors where id="+id);
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
        }
    }
    public ResultSet getUserBids(String userid){
        try {
            pst=con.prepareStatement("select * from bidding where user_id="+userid);
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
        }
    }
    
    public ResultSet getUserDetails(int userid){
        try {
            pst=con.prepareStatement("select * from users where id="+userid);
            //executes the prepared statement
            rs=pst.executeQuery();
            return rs;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return null;
        }
    }

    private int checkPatientIsExistMobileno(String mobno2) {
        try {
            pst=con.prepareStatement("select * from patients where mobile='"+mobno2);
            //executes the prepared statement
            rs=pst.executeQuery();
            if(rs.next()){
                return rs.getInt("id");
            }else{
                return 0;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            return 0;
        }
    }
}

