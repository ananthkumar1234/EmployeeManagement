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
        /* Your existing CSS styles */
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
        
    </style>
    
    <link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
    <script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            flatpickr("#hireDate", {
                dateFormat: "Y-m-d",
                maxDate: "today",
            });
            flatpickr("#dob", {
                dateFormat: "Y-m-d",
                maxDate: "today",
            });
        });
    </script>
</head>
<body>
    <% 
        Connection con = DBConnect.getConnection();
        EmpDao eDao = new EmpDao(con);
        List<Roles> list = eDao.getRoles();
    %>
    
    <%@include file="navbar.jsp" %>

    <%
        HttpSession sess = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        int mid = ((Employees) sess.getAttribute("employee")).getEmpId();
        Employees emp = eDao.GetEmpById(id);

        String role2 = eDao.getRoleById(id);
        String sesrole = eDao.getRoleById(mid);

        boolean isHR = "HR".equals(sesrole);
    %>

<div class="container">
    <div class="sidebar">
        <div class="tools">
            <h3>Employee Links</h3>
            <div class="button-container">
                <a href="EmpLeaves.jsp?id=<%= id %>&role=<%= role2 %>">Leaves</a>
                <a href="EmpAttend.jsp?id=<%= id %>&role=<%= role2 %>">Attendance</a>
                <a href="Detail.jsp?id=<%= id %>&role=<%= role2 %>">Detail</a>
                <% if (role2 != null && role2.equals("Manager")) { %>
                <a href="Managers.jsp?id=<%= id %>&role=<%= role2 %>">Add Reportees</a>
                <% } %>  
                <% if (sesrole != null && !sesrole.equals("Trainee")) { %>
                <a href="ReporteeLeave.jsp?id=<%= id %>&role=<%= role2 %>">Apply Leave</a>
                <% } %>  
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="form-container">
            <h2>Edit Employee</h2>
            <form action="updateEmployee" method="post">
                <h3>Personal Details</h3>
                <div class="form-group">
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" value="<%= emp.getFname() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" value="<%= emp.getLname() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth:</label>
                    <input type="text" id="dob" name="dob" placeholder="yyyy-mm-dd" value="<%= emp.getDOB() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" <%= !isHR ? "disabled" : "" %>>
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equals(emp.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(emp.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Others" <%= "Others".equals(emp.getGender()) ? "selected" : "" %>>Others</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="ms">Marital Status:</label>
                    <select id="ms" name="ms" <%= !isHR ? "disabled" : "" %>>
                        <option value="">Select Marital Status</option>
                        <option value="Single" <%= "Single".equals(emp.getMaritalStatus()) ? "selected" : "" %>>Single</option>
                        <option value="Married" <%= "Married".equals(emp.getMaritalStatus()) ? "selected" : "" %>>Married</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="bg">Blood Group:</label>
                    <select id="bg" name="bg" <%= !isHR ? "disabled" : "" %>>
                        <option value="">Select Blood Group</option>
                        <option value="A Positive" <%= "A Positive".equals(emp.getBloodgroup()) ? "selected" : "" %>>A Positive</option>
                        <option value="A Negative" <%= "A Negative".equals(emp.getBloodgroup()) ? "selected" : "" %>>A Negative</option>
                        <option value="B Positive" <%= "B Positive".equals(emp.getBloodgroup()) ? "selected" : "" %>>B Positive</option>
                        <option value="B Negative" <%= "B Negative".equals(emp.getBloodgroup()) ? "selected" : "" %>>B Negative</option>
                        <option value="O Positive" <%= "O Positive".equals(emp.getBloodgroup()) ? "selected" : "" %>>O Positive</option>
                        <option value="O Negative" <%= "O Negative".equals(emp.getBloodgroup()) ? "selected" : "" %>>O Negative</option>
                        <option value="AB Positive" <%= "AB Positive".equals(emp.getBloodgroup()) ? "selected" : "" %>>AB Positive</option>
                        <option value="AB Negative" <%= "AB Negative".equals(emp.getBloodgroup()) ? "selected" : "" %>>AB Negative</option>
                    </select>
                </div>
                
                <h3>Contact Details</h3>
                <div class="form-group">
                    <label for="phone">Personal Contact Number:</label>
                    <input type="text" id="phone" name="phone" value="<%= emp.getPhoneNo() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="email">Personal Email:</label>
                    <input type="email" id="email" name="email" value="<%= emp.getEmail() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="ecn">Emergency Contact Name:</label>
                    <input type="text" id="ecn" name="ecn" value="<%= emp.getEmergencyContactName() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="ec">Emergency Contact Number:</label>
                    <input type="text" id="ec" name="ec" value="<%= emp.getEmergencyContact() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="address">Permanent Address:</label>
                    <textarea id="address" name="address" <%= !isHR ? "readonly" : "" %>><%= emp.getAddress() %></textarea>
                </div>
                <div class="form-group">
                    <label for="tempadd">Temporary Address:</label>
                    <input type="text" id="tempadd" name="tempadd" value="<%= emp.getTempAddress() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                
                <h3>Employee Details</h3>
                <div class="form-group">
                    <label for="hireDate">Hire Date:</label>
                    <input type="text" id="hireDate" name="hireDate" placeholder="yyyy-mm-dd" value="<%= emp.getHiredate() %>" <%= !isHR ? "readonly" : "" %>>
                </div>
                <div class="form-group">
                    <label for="role">Role:</label>
                    <select id="role" name="role" <%= !isHR ? "disabled" : "" %>>
                        <option value="">Select Role</option>
                        <% for (Roles r : list) { %>
                            <option value="<%= r.getRoleId() %>" <%= (r.getRoleId() == emp.getRoleId()) ? "selected" : "" %>><%= r.getRoleName() %></option>
                        <% } %>
                    </select>
                </div>
                <div>
                    <input type="hidden" name="id" value="<%= id %>">
                </div>
                <% if (isHR) { %>
                    <center><input type="submit" value="Update"></center>
                <% } %>
            </form>
        </div>
    </div>
</div>
</body>
</html>
