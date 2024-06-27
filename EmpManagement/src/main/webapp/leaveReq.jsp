<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="com.empmngt.enities.Leaves"%>
<%@ page import="java.util.List" %>
<%@ page import="com.empmngt.enities.Attendance"%>

<!DOCTYPE html>
<html>
<head>
<title>Apply Leave</title>
<style>
/* General styling for body */
body {
    background-color: #ADD8E6;
    background-image: url("Images/bg.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    font-family: Arial, sans-serif;
    color: #333;
}

/* Main container for layout */
.main {
    display: flex;
    max-width: 100%;
    margin: 40px;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Styling for form container */
.form-container {
    flex: 1;
    width: 50%;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.right-column {
    flex: 3;
    width: 50%;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    margin-left: 10px;
}

/* Header styling */
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

/* Table styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: white;
    border-radius: 8px;
    overflow: visible; /* Changed from hidden to visible */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #007bff;
    color: white;
}

tr:hover {
    background-color: #f1f1f1;
}

/* Tooltip styling */
.tooltip {
    position: relative;
    display: inline-block;
    cursor: pointer;
}

.tooltip .tooltiptext {
    visibility: hidden;
    width: 150px;
    background-color: #555;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px;
    position: absolute;
    z-index: 9999;
    bottom: 125%;
    left: 50%;
    margin-left: -75px;
    opacity: 0;
    transition: opacity 0.3s;
}

.tooltip .tooltiptext::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
    visibility: visible;
    opacity: 1;
}

.pending {
    margin-bottom: 20px;
    margin-top: 20px; /* Add margin bottom to create space */
}

.ExceptPending {
    margin-top: 20px; /* Add margin top to create space */
}

.AssignLeaves {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
}
</style>
</head>
<body>
<%@include file="navbar.jsp"%>

<%
HttpSession ses2 = request.getSession();
Employees emp2 = (Employees)ses2.getAttribute("employee");
int eid2 = emp2.getEmpId();

String r= (String)ses2.getAttribute("role");

EmpDao er2 = new EmpDao(DBConnect.getConnection());
int n = er2.availDays(eid2);
%>

<div class="main">
    <div class="form-container">
        <h2>Apply Leave</h2>
        <form action="ApplyLeaveServlet" method="post">
            <div class="form-group-full">
                <label for="toDate">Available Leaves: <%= n %></label>
            </div>
            <input type="hidden" name="id" value="<%=eid2 %>">
             <input type="hidden" name="origin" value="leave">
            <div class="form-row">
                <div class="form-group">
                    <label for="fromDate">From Date:</label>
                    <input type="date" id="fromDate" name="fromDate" required>
                </div>
                <div class="form-group">
                    <label for="toDate">To Date:</label>
                    <input type="date" id="toDate" name="toDate" required>
                </div>
                <div class="form-group">
                    <label for="leaveType">Leave Type:</label>
                    <select id="leaveType" name="leaveType" required>
                        <option value="">Select Leave</option>
                        <option value="Casual Leave">Casual Leave</option>
                        <option value="Sick Leave">Sick Leave</option>
                        <option value="Annual Leave">Annual Leave</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group-full">
                    <label for="reason">Leave Reason:</label>
                    <textarea id="reason" name="reason" rows="4" required></textarea>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group-full">
                    <input type="submit" value="Apply Leave">
                </div>
            </div>
            <% if(request.getAttribute("message") != null) { %>
                <div class="form-group-full">
                   <script> 
                   alert(" <%= request.getAttribute("message")%> ");
                   </script>
                </div>
            <% } %>
        </form>
        <%if(r.equals("HR")){ %>
        <div class="AssignLeaves">
				<h2>Assign Leaves</h2>
				
				<br>
				<form action="addlev" method="get">
					<input type="text" name="addl" placeholder="Enter No of Leaves">
					<input type="submit" value="Assign">
				</form>
			</div>
			<%} %>
    </div>
            
    <div class="right-column">
    <div class="pending">
  
        <h2>Pending Records</h2>
  <% 
            HttpSession ses = request.getSession();
            Employees emp = (Employees)ses.getAttribute("employee");
            int eid = emp.getEmpId();

            EmpDao er = new EmpDao(DBConnect.getConnection());
            List<Leaves> l = (List<Leaves>)er.getPendingLeaveById(eid);
            
            if(l != null && !l.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>AppliedDate</th>
                    <th>FromDate</th>
                    <th>ToDate</th>
                    <th>LeaveType</th>
                    <th>Cancel</th>
                </tr>
            </thead>
            <tbody>
                <% for (Leaves e : l) { %>
                <tr>
                    <td><%= e.getAppliedDate() %></td>
                    <td><%= e.getFromDate() %></td>
                    <td><%= e.getToDate() %></td>
                    <td><%= e.getLeaveType() %></td>
                    <td><a href="cancel?id=<%= e.getLeaveId() %>" class="btn btn-sm btn-danger">Cancel</a></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <h4><center>No Records!!</center></h4>
        <% } %>
        </div>
        <div class="ExceptPending">
            <h2>Leave Records</h2>
            <% 
                HttpSession ses1 = request.getSession();
                Employees emp1 = (Employees)ses1.getAttribute("employee");
                int eid1 = emp1.getEmpId();
                EmpDao er1 = new EmpDao(DBConnect.getConnection());
                List<Leaves> l1 = er1.getLeaveRecordsById(eid1);

                if (l1 != null && !l1.isEmpty()) {
            %>
            <table>
                <thead>
                    <tr>
                        <th>AppliedDate</th>
                        <th>FromDate</th>
                        <th>ToDate</th>
                        <th>LeaveType</th>
                        <th>LeaveStatus</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Leaves e : l1) { %>
                    <tr>
                        <td><%= e.getAppliedDate() %></td>
                        <td><%= e.getFromDate() %></td>
                        <td><%= e.getToDate() %></td>
                        <td><%= e.getLeaveType() %></td>
                        <td>
                            <div class="tooltip">
                                <%= e.getLeaveStatus() %>
                                <% if ("rejected".equalsIgnoreCase(e.getLeaveStatus())) { %>
                                <span class="tooltiptext">Reason:<br><%= e.getRejectReason() %><br><br>Rejected by:<br><%= e.getApprovedByFname() + " " + e.getApprovedByLname() %></span>
                                <% } else { %>
                                <span class="tooltiptext">Approved Date:<br><%= e.getApprovedDate() %><br><br>Approved by:<br><%= e.getApprovedByFname() + " " + e.getApprovedByLname() %></span>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <h4><center>No Records!!</center></h4>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
