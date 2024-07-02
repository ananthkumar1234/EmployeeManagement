<%@ page import="java.util.List"%>
<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="com.empmngt.enities.Leaves"%>
<%@ page import="com.empmngt.enities.Attendance"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Employee Leaves</title>
<style>
/* styles.css */

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
    display: flex;
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
.filter input[type="date"],
.filter select {
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #ddd;
    font-size: 14px;
    width: 150px;
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

.button-container a:hover {
    background-color: #0056b3;
}

.form-container {
    flex: 1;
    width: 100%;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.form-container h2, .right-column h2 {
    text-align: center;
    background-color: #333;
    color: white;
    padding: 10px;
    margin-bottom: 20px;
    border-radius: 4px 4px 0 0;
}

/* Form row and group styling */
.form-container .form-row, .form-container .form-group-full {
    margin-bottom: 20px;
}

.form-container .form-group, .form-container .form-group-full {
    display: flex;
    flex-direction: column;
}

.form-container label {
    font-weight: bold;
    margin-bottom: 5px;
}

/* Input and select styling */
.form-container input[type="text"],
.form-container input[type="date"],
.form-container select,
.form-container textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
}

/* Submit button styling */
.form-container input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.form-container input[type="submit"]:hover {
    background-color: #0056b3;
}

.error-message {
	color: red;
	font-size: 0.9em;
	display: none;
}

.star {
	color: red;
	font-size: 20px;
}


</style>
<link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
         <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
	HttpSession ses1 = request.getSession();
	EmpDao er1 = new EmpDao(DBConnect.getConnection());

    String msg = (String)request.getAttribute("msg");
    int id = Integer.parseInt(request.getParameter("id"));
    String role2=request.getParameter("role");
    
    int mid=((Employees)ses1.getAttribute("employee")).getEmpId();
    String sesrole= er1.getRoleById(mid);
    
    int n = er1.availDays(id);
%>
<%@include file="navbar.jsp"%>
<div class="container">
    <div class="sidebar">
        <div class="tools">
            <h3>Links</h3>
            <div class="button-container">
                <!-- Add your links here -->
                <a href="EmpLeaves.jsp?id=<%= id%>&role=<%= role2 %>">Leaves</a>
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
            <% 
            if(msg != null) {
                out.print(msg);
            }
            %>
        </div>
    </div>
    <div class="main-content">
        <div class="form-container">
        <% if(request.getAttribute("message") != null) { %>
                <div class="form-group-full">
                 <center>   <label style="color: red;"><%= request.getAttribute("message") %></label></center>
                </div>
            <% } %>
        <h2>Apply Leave</h2>
        <form id="leaveForm" action="ApplyLeaveServlet" method="post">
            <div class="form-group-full">
                <label for="toDate">Available Leaves: <%= n %></label>
            </div>
            <input type="hidden" name="id" value="<%=id %>">
             <input type="hidden" name="origin" value="Reportees">
            <div class="form-row">
                <div class="form-group">
                    <label for="fromDate">From Date<span class="star">*</span></label>
                    <input type="text" id="fromDate" name="fromDate">
                    <span class="error-message" id="fromDateError">Please select a date.</span>
                </div>
                <div class="form-group">
                    <label for="toDate">To Date<span class="star">*</span></label>
                    <input type="text" id="toDate" name="toDate">
                    <span class="error-message" id="toDateError">Please select a date.</span>
                </div>
                <div class="form-group">
                    <label for="leaveType">Leave Type<span class="star">*</span></label>
                    <select id="leaveType" name="leaveType">
                        <option value="">Select Leave</option>
                        <option value="Casual Leave">Casual Leave</option>
                        <option value="Sick Leave">Sick Leave</option>
                        <option value="Annual Leave">Annual Leave</option>
                    </select>
                    <span class="error-message" id="leaveTypeError">Please select leave type.</span>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group-full">
                    <label for="reason">Leave Reason<span class="star">*</span></label>
                    <textarea id="reason" name="reason" rows="4"></textarea>
                    <span class="error-message" id="reasonError">Please enter reason.</span>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group-full">
                    <input type="submit" value="Apply Leave">
                </div>
            </div>
            
        </form>
        
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            flatpickr("#fromDate");
            flatpickr("#toDate");

            document.getElementById("leaveForm").addEventListener("submit", function(event) {
                let isValid = true;

                const fromDate = document.getElementById("fromDate");
                const fromDateError = document.getElementById("fromDateError");
                if (!fromDate.value) {
                    fromDateError.style.display = "inline";
                    isValid = false;
                } else {
                    fromDateError.style.display = "none";
                }

                const toDate = document.getElementById("toDate");
                const toDateError = document.getElementById("toDateError");
                if (!toDate.value) {
                    toDateError.style.display = "inline";
                    isValid = false;
                } else {
                    toDateError.style.display = "none";
                }

                const leaveType = document.getElementById("leaveType");
                const leaveTypeError = document.getElementById("leaveTypeError");
                if (!leaveType.value) {
                    leaveTypeError.style.display = "inline";
                    isValid = false;
                } else {
                    leaveTypeError.style.display = "none";
                }

                const reason = document.getElementById("reason");
                const reasonError = document.getElementById("reasonError");
                if (!reason.value) {
                    reasonError.style.display = "inline";
                    isValid = false;
                } else {
                    reasonError.style.display = "none";
                }

                if (!isValid) {
                    event.preventDefault();
                }
            });
        });
    </script>
        
        
    </div>
        </div>
    </div>
</body>
</html>