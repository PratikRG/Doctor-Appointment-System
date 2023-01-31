<%-- 
    Document   : logout
    Created on : Apr 3, 2016, 6:59:24 AM
    Author     : Brothers
--%>
<%
session.invalidate();
response.sendRedirect("index.jsp");
%>