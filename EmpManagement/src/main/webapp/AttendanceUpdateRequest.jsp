<!-- employee_details.jsp -->


<%@ page import="java.util.*"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="com.empmngt.enities.Attendance"%>
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
    String r=(String)sess.getAttribute("role");
%>

<div class="container">
    <h2>Reportees</h2>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Date</th>
                <th>Old CheckIn Time</th>
                <th>New CheckIn Time</th>
                <th>Old CheckOut Time</th>
                <th>New CheckOut Time</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            EmpDao er = new EmpDao(DBConnect.getConnection());
            List<Attendance> list2=null;
            
            if(r.equals("Manager"))
            		list2=er.ManagerAttendance(mid);
            else
            	list2=er.HRAttendance();

            for (Attendance e : list2) {
            %>
            <tr>
                <td><%= e.getName() %></td>
                <td><%= e.getDate()%></td>
                <td><%= e.getCheckin()%></td>
                <td><%= e.getNewcheckin()%></td>
                <td><%= e.getCheckout()%></td>
                <td><%= e.getNewcheckout()%></td>
                <td>
                <form action="AttendanceUpdate" method="get">
                       		<input type="hidden" name="id" value="<%=e.getAttendId() %>">	
                       		<input type="hidden" name="Date" value="<%=e.getDate() %>">
                       		<input type="hidden" name="CIT" value="<%=e.getNewcheckin() %>">
                       		<input type="hidden" name="COT" value="<%=e.getNewcheckout() %>">
                            <input type="submit" value="Approve">
                </form>
                </td>
                
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
