<!-- hr_home.jsp -->
 
 <%@ page import="javax.servlet.http.HttpSession" %>
 <%@ page import="com.empmngt.enities.Employees" %>
<!DOCTYPE html>
<html>
<head>
    <title>HR HomePage</title>
    
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
  background-size: cover;
  background-position: center;
  padding:-10px;
}
.banner img
{
 width:100%;
}
    </style>
</head>
<body>


   
    
    <%
HttpSession sess = request.getSession();
Employees emp = (Employees)sess.getAttribute("employee");

%>
 <%@include file="navbar.jsp" %>
<marquee><h2>Welcome <% out.print(emp.getFname()+ ","+ emp.getLname());%> </h2></marquee>
    <div class="banner">
        <img alt="logo" src="Images/logo.jpeg">
    
    </div>
</body>
</html>
