<%@ page import="java.util.List"%>
<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="com.empmngt.enities.Attendance"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Employee Attendance</title>
<style>
body {
    background-color: #ADD8E6;
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
}
.content {
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
    width: 75%;
    padding: 20px;
}
h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
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
.button-container {
    display: flex;
    gap: 20px;
    padding: 15px;
    align-items: center;
    justify-content: center;
}
.button-container input[type="submit"] {
    background-color: #007bff;
    color: white;
    border: none;
    width: 100px;
    padding: 10px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}
.button-container input[type="submit"]:hover {
    background-color: #0056b3;
}
table {
    width: 100%;
    margin-top: 20px;
    border-collapse: collapse;
    background-color: white;
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
.filter {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 8px;
    background-color: #f9f9f9;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}
.filter form {
    display: flex;
    gap: 15px;
    align-items: center;
    justify-content: space-between;
}
.filter label {
    font-weight: bold;
    color: #333;
}
.filter input[type="text"],
.filter select {
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #ddd;
    font-size: 14px;
    width: 100%;
}
.filter button {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}
.filter button:hover {
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

</style>

<link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
<script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
    <script>
  // Initialize Flatpickr after the DOM is loaded
  document.addEventListener("DOMContentLoaded", function() {
            flatpickr("#fromDate", {
                dateFormat: "Y-m-d",
                maxDate: "today", // Restricts future dates
                defaultDate: "today", // Optionally sets default date to today
            });
            flatpickr("#toDate", {
                dateFormat: "Y-m-d",
                maxDate: "today", // Restricts future dates
                defaultDate: "today", // Optionally sets default date to today
            });
        });
</script>

<script>
function toggleMonthDropdown() {
    var yearInput = document.getElementById('year');
    var monthDropdown = document.getElementById('month');
    monthDropdown.disabled = yearInput.value.trim() === "";
}
window.onload = function() {
    toggleMonthDropdown(); // Initial check
}
</script>
</head>
<body>
<%
    String msg = (String)request.getAttribute("msg");
    int id = -1;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        e.printStackTrace();
        // Handle the error or redirect to an error page
    }
    String role2=request.getParameter("role");
    
    Connection con = DBConnect.getConnection();
    EmpDao eDao = new EmpDao(con);
    HttpSession sess = request.getSession();
    int mid=((Employees)sess.getAttribute("employee")).getEmpId();
    String sesrole= eDao.getRoleById(mid);
%>
<%@include file="navbar.jsp"%>

<div class="container">
    <div class="content">
        <div class="sidebar">
            <div class="tools">
                <h3>Attendance</h3>
                <div class="button-container">
                    <a href="EmpLeaves.jsp?id=<%= id %>&role=<%= role2 %>">Leaves</a>
                    <a href="EmpAttend.jsp?id=<%= id %>&role=<%= role2 %>">Attendance</a>
                    <a href="Detail.jsp?id=<%= id %>&role=<%= role2 %>">Detail</a>
                    
                        <%if(role2!=null && role2.equals("Manager")) 
                    { 
                   %>
                   <a href="Managers.jsp?id=<%= id %>&role=<%= role2 %>">Add Reportees</a>
					<%} %> 
					
					<%if(sesrole!=null && !sesrole.equals("Trainee")) 
                    { 
                   %>
                   <a href="ReporteeLeave.jsp?id=<%= id %>&role=<%= role2 %>">Apply Leave</a>
					<%} %>   
					  
                </div>
                <% if (msg != null) { %>
                    <p><%= msg %></p>
                <% } %>
            </div>
            <div class="tools"></div>
        </div>
        <div class="main-content">
            <div class="form-container">
                <h2>Employee Details</h2>
                <div class="filter">
                    <form action="filterAttendance" method="get">
                        <label for="year">Year:</label>
                        <input type="text" id="year" name="year" onkeyup="toggleMonthDropdown()" value="<%= request.getParameter("year") != null ? request.getParameter("year") : "" %>">
                        <input type="hidden" name="origin" value="EmpAttend">
                        <label for="month">Month:</label>
                        <select id="month" name="month">
                            <option value="" <%= "".equals(request.getParameter("month")) ? "selected" : "" %>>Select Month</option>
                            <option value="01" <%= "01".equals(request.getParameter("month")) ? "selected" : "" %>>January</option>
                            <option value="02" <%= "02".equals(request.getParameter("month")) ? "selected" : "" %>>February</option>
                            <option value="03" <%= "03".equals(request.getParameter("month")) ? "selected" : "" %>>March</option>
                            <option value="04" <%= "04".equals(request.getParameter("month")) ? "selected" : "" %>>April</option>
                            <option value="05" <%= "05".equals(request.getParameter("month")) ? "selected" : "" %>>May</option>
                            <option value="06" <%= "06".equals(request.getParameter("month")) ? "selected" : "" %>>June</option>
                            <option value="07" <%= "07".equals(request.getParameter("month")) ? "selected" : "" %>>July</option>
                            <option value="08" <%= "08".equals(request.getParameter("month")) ? "selected" : "" %>>August</option>
                            <option value="09" <%= "09".equals(request.getParameter("month")) ? "selected" : "" %>>September</option>
                            <option value="10" <%= "10".equals(request.getParameter("month")) ? "selected" : "" %>>October</option>
                            <option value="11" <%= "11".equals(request.getParameter("month")) ? "selected" : "" %>>November</option>
                            <option value="12" <%= "12".equals(request.getParameter("month")) ? "selected" : "" %>>December</option>
                        </select>
                        <label for="fromDate">From Date:</label>
                        <input type="text" id="fromDate" name="fromDate" placeholder="yyyy-mm-dd" value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">
                        <label for="toDate">To Date:</label>
                        <input type="text" id="toDate" name="toDate" placeholder="yyyy-mm-dd" value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit">Filter</button>
                    </form>
                </div>
              
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Date</th>
                                <th scope="col">CheckIn</th>
                                <th scope="col">CheckOut</th>
                                <th scope="col">Remarks</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                HttpSession ses = request.getSession();
                                EmpDao er = new EmpDao(DBConnect.getConnection());
                                List<Attendance> list1 = (List<Attendance>) request.getAttribute("filteredAttendance");
                                                            if (list1 == null) {
                                list1 = er.getAttRecordById(id);
                            }

                            for (Attendance e : list1) {
                        %>
                        <tr>
                            <td scope="row"><%= e.getDate() %></td>
                            <td><%= e.getCheckin() %></td>
                            <td><%= e.getCheckout() %></td>
                            <td><%= e.getRemarks() %></td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
               
        </div>
    </div>
</div>
</div>
</body>
</html>                             