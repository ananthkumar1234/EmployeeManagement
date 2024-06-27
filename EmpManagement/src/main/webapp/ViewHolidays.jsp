<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.enities.AddHoliday"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Holiday</title>
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
}

/* Style for the main container */
.main-container {
    display:flex;
    max-width:100%;
    margin: 40px;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Style for the left column */
.left-column {
	flex:1;
    width: 50%; 
    margin:10px;/* Adjust width as needed */
}

/* Style for the right column */
.right-column {
	flex:2;
    width: 100%; /* Adjust width as needed */
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin:10px;
    padding: 20px;
}

/* Style for the AddHoliday container */
.AddHoliday {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 20px;
}

/* Style for the AssignLeaves container */
.AssignLeaves {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

h2 {
    text-align: center;
    color: white;
    margin-bottom: 20px;
    background-color:#333;
    padding:10px;
    border-radius: 4px 4px 0 0;
}

/* Style for input fields */
input[type="date"],
input[type="text"],
input[type="submit"] {
    width: 100%;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #ccc;
    margin-bottom: 10px;
    font-size: 16px;
}

/* Style for buttons */
button[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color:#007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
    background-color: #555;
}

.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: white;
}

.table thead {
    background-color: #333;
    color: #fff;
}

.table th, .table td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

.table th {
    font-weight: bold;
}

.table tr:nth-child(even) {
    background-color: #f9f9f9;
}



.table tr td:last-child {
    text-align: center;
}

.right-column h2{

background-color: white;
color: #333}


.strikethrough {
        text-decoration: line-through;
        color: red;
    }

    
    </style>
</head>
<body>
<%@include file="navbar.jsp"%>
<div class="main-container">


<div class="right-column">
<%
EmpDao er = new EmpDao(DBConnect.getConnection());
List<AddHoliday> list = er.displayHolidays();
%>
<h2>List of Holidays</h2>
<table class="table">
    <thead>
        <tr>
            <th scope="col">Date</th>
            <th scope="col">Holiday Name</th>
            <th scope="col">Day</th>
            
        </tr>
    </thead>
    <tbody>
        <%
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (AddHoliday a : list) {
            LocalDate holidayDate = LocalDate.parse(a.getDate(), formatter);
            boolean isPast = holidayDate.isBefore(today);
        %>
        <tr class="<%= isPast ? "strikethrough" : "" %>">
            <td><%= a.getDate() %></td>
            <td><%= a.getName() %></td>
            <td><%= holidayDate.getDayOfWeek() %></td>

        </tr>
        <%
        }
        %>
    </tbody>
</table>

</div>
</div>
</body>
</html>