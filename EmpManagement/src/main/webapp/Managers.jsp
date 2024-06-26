
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.empmngt.jdbc.DBConnect"%>
<%@page import="com.empmngt.dao.EmpDao"%>
<%@page import="com.empmngt.enities.Employees"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.empmngt.enities.EmployeeAttachment"%>
<%@page import="java.util.Base64" %>
<%@page import="com.empmngt.enities.Roles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
    <style>
body {
    background-image: url("Images/bg.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 100%;
    margin: 40px;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: flex;
}

.sidebar {
    width: 25%;
    margin-left: 15px;
    margin-top: 80px;
    background-color: white;
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border: 0.5px solid black;
    border-radius: 8px;
    height: 50%;
}

.main-content {
    width: 70%;
    padding: 20px;
    margin: 20px;
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

.main-content h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 2px solid #eee;
}

.main-content h3 {
    margin-top: 20px;
    margin-bottom: 15px;
    padding-bottom: 5px;
    border-bottom: 1px solid #ddd;
    font-size: 1.2em;
}

.form-section {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    background: #f9f9f9;
}

.form-group {
    display: flex;
    margin-bottom: 15px;
}

.form-group label {
    width: 30%;
    margin-right: 10px;
    font-weight: bold;
    display: flex;
    align-items: center;
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 70%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f1f1f1;
}

input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 20px;
    text-align: center;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

.button-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 15px;
    align-items: center;
    justify-content: center;
}

.button-container a {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    text-align: center;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    text-decoration: none;
}

.button-container a:hover {
    background-color: #0056b3;
}

h2 {
    text-align: center;
    color: #333;
}

h1 {
    color: orange;
}

.tools {
    margin-bottom: 20px;
}

.tools h3 {
    background-color: #333;
    color: white;
    padding: 10px;
    margin: 0;
    border-radius: 4px 4px 0 0;
    text-align: center;
}

h3 {
    background-color: #333;
    color: white;
    padding: 10px;
    margin: 0;
    border-radius: 4px 4px 0 0;
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #333;
    color: white;
}

tr:hover {
    background-color: #f1f1f1;
}

.Reportees {
    background-color: #f9f9f9; /* Light background color */
    padding: 20px; /* Add some padding */
    margin-bottom: 20px; /* Space below the form */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Slight shadow for depth */
}

.Reportees form {
    display: flex;
    align-items: center;
}

.Reportees select, .Reportees input[type="submit"] {
    display: inline-block;
    padding: 10px; /* Padding inside the elements */
    margin-right: 10px; /* Space between elements */
    border: 1px solid #ccc; /* Border for input elements */
    border-radius: 4px; /* Rounded corners for input elements */
    font-size: 16px; /* Font size */
}

.Reportees select {
    flex-grow: 1; /* Make the select element take up remaining space */
    max-width: 50%; /* Ensure the form doesn't overflow */
}

.Reportees input[type="submit"] {
    background-color: #007bff; /* Blue background for the button */
    color: white; /* White text color */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s ease; /* Smooth transition */
    width: 120px; /* Set a fixed width for the button */
    float:right;
}

.Reportees input[type="submit"]:hover {
    background-color: #0056b3; /* Darker blue on hover */
}

.Reportees h2 {
    margin-bottom: 15px; /* Space below the heading */
    font-size: 24px; /* Larger font size for the heading */
    color: #333; /* Darker text color */
}


    </style>
</head>
<body>
    <% 
        Connection con = DBConnect.getConnection();
        EmpDao eDao = new EmpDao(con);
        List<Employees> list = eDao.getEmployees();
        
        HttpSession sess = request.getSession();
        int mid=((Employees)sess.getAttribute("employee")).getEmpId();
        String sesrole= eDao.getRoleById(mid);
        con.close();
    %>
    
    <%@include file="navbar.jsp" %>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String role2 = request.getParameter("role");
        String msg = (String) request.getAttribute("msg");
    %>

    <div class="container">
        <div class="sidebar">
            <div class="tools">
                <h3>Employee Links</h3>
                <div class="button-container">
                    <a href="EmpLeaves.jsp?id=<%= id %>&role=<%= role2 %>">Leaves</a>
                    <a href="EmpAttend.jsp?id=<%= id %>&role=<%= role2 %>">Attendance</a>
                    <a href="Detail.jsp?id=<%= id %>&role=<%= role2 %>">Detail</a>
                    
                    <% if ("Manager".equals(role2)) { %>
                        <a href="Managers.jsp?id=<%= id %>&role=<%= role2 %>">Add Reportees</a>
                    <% } %>    
                    
                    <%if(sesrole!=null && !sesrole.equals("Trainee")) 
                    { 
                   %>
                   <a href="ReporteeLeave.jsp?id=<%= id %>&role=<%= role2 %>">Apply Leave</a>
					<%} %>                  
                </div>
            </div>
        </div>

        <div class="main-content">
        <div class="Reportees">
         <form action="AddReportees" method="post">
                <select id="emp" name="emp" required>
                    <option value="">Select Employee</option>
                    <% for (Employees r : list) { %>
                        <option value="<%= r.getEmpId() %>"><%= r.getFname() + " " + r.getLname() %></option>
                    <% } %>
                </select>
                <input type="hidden" name="id" value="<%= id %>">
                <input type="submit" value="Add">
            </form>
            </div>
            
            <div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>FullName</th>
            </tr>
        </thead>
        <tbody>
            <% 
            EmpDao er = new EmpDao(DBConnect.getConnection());
            String roleId = request.getParameter("role");
            String name = request.getParameter("name");
            List<Employees> list2=er.getReportees(id);

            for (Employees e : list2) {
            %>
            <tr>
                <td><%= e.getEmpId() %></td>
                <td><%= e.getFname() %> <%= e.getLname() %></td>
                
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

           
            <% if (msg != null) { %>
                <div><%= msg %></div>
            <% } %>
        </div>
    </div>
</body>
</html>