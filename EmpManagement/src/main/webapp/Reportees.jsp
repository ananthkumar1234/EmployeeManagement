<!-- employee_details.jsp -->


<%@ page import="java.util.*"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<title>Employee Details</title>

<style>
/* Reset default browser styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Style for the body */
body {
    font-family: Arial, sans-serif;
    background-image: url("Images/bg.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    color: #333;
}

/* General container styling */
.container {
    max-width:100%;
    margin: 40px;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Heading styles */
h2 {
    color: #333;
    text-align: center;
    margin-bottom: 20px;
}

/* Style for the filter form */
.filter-form {
    margin: 20px 0;
    text-align: center;
}

.filter-form select, .filter-form input[type="text"] {
    padding: 10px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    width: 200px;
}

.filter-form input[type="submit"] {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.filter-form input[type="submit"]:hover {
    background-color: #0056b3;
}

/* Style for the table */
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

/* Style for the buttons */
.edit-btn, .btn-primary {
    background-color: #007bff;
    color: white;
    padding: 5px 10px;
    text-decoration: none;
    border-radius: 3px;
    border: none;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.edit-btn:hover, .btn-primary:hover {
    background-color: #0056b3;
}

</style>

</head>

<body>
<%@include file="navbar.jsp"%>

<% 
    Connection con = DBConnect.getConnection();
    EmpDao eDao = new EmpDao(con);
    HttpSession sess = request.getSession();
    //Employees emp=(Employees)sess.getAttribute("employee");
    //int mid=emp.getEmpId();
    int mid=((Employees)sess.getAttribute("employee")).getEmpId();
%>

<div class="container">
    <h2>Reportees</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>FullName</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            EmpDao er = new EmpDao(DBConnect.getConnection());
            String roleId = request.getParameter("role");
            String name = request.getParameter("name");
            List<Employees> list2=er.getReportees(mid);

            for (Employees e : list2) {
            %>
            <tr>
                <td><%= e.getEmpId() %></td>
                <td><%= e.getFname() %> <%= e.getLname() %></td>
                <td><a href="Detail.jsp?id=<%= e.getEmpId() %>" class="btn-primary">View</a></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
