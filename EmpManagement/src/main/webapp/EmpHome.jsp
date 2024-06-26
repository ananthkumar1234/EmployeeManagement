<!-- hr_home.jsp -->
 
  <%@ page import="com.empmngt.enities.Employees" %>
  <%@ page import="java.awt.Image" %>
  <%@ page import="java.awt.Toolkit" %>
  <%@ page import="java.net.URL" %>
<!DOCTYPE html>
<html>
<head>
    <title>EMP Homeage</title>
    <style>
    
    *
{
margin: 0px;
padding: 0px;
box-sizing: border-box;
}
    
    body {
    background-color:#ADD8E6;
    background-image: url("Images/bg.jpg");
  background-repeat: none;
  background-size: fixed;
  background-position: center;
}
.banner img
{
 width:100%;
}
h2{
font-size:20px;
}
    </style>
    
</head>
<body>

    
    <%
HttpSession se2 = request.getSession();
Employees emp = (Employees)se2.getAttribute("employee");
int eid = emp.getEmpId();
request.setAttribute("eid", eid);
%>
<%@include file="navbar.jsp" %>
<h2 >Welcome <% out.print(emp.getFname()+ ","+ emp.getLname());%> </h2>
You are in Employee homepage
    <div class="banner">
        <img alt="logo" src="Images/logo.jpeg">
    
    </div>
</body>
</html>
