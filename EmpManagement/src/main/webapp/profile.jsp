
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

        .main {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            padding: 8px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
      
        .rightColumn {
            width: 100%;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
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

        .form-row {
            display: flex;
            justify-content: space-between;
        }
        
        .form-row2 {
            display: flex;
            width: 100%;
            justify-content: space-between;
        }

        .form-column {
            flex: 1;
            margin: 0 10px;
        }

        h3 {
            background-color: #333;
            color: white;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px 4px 0 0;
            text-align: center;
        }
    </style>
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
    Employees emp = (Employees)sess.getAttribute("employee");
    String role1 = (String)sess.getAttribute("role");
    int eid2 = emp.getEmpId();
    %>

    <div class="main">
       

<div class="rightColumn">
    <h2>Profile</h2>
    <form action="updateEmployee" method="post">
        <div class="form-row">
            <div class="form-column">
                <div class="form-section">
                    <h3>Personal Details</h3>
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" id="firstName" name="firstName" value="<%= emp.getFname() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" id="lastName" name="lastName" value="<%= emp.getLname() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="dob">Date of Birth:</label>
                        <input type="date" id="dob" name="dob" value="<%= emp.getDOB() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender:</label>
                        <select id="gender" name="gender" readonly>
                            <option value="">Select Gender</option>
                            <option value="Male" <%= "Male".equals(emp.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= "Female".equals(emp.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="Others" <%= "Others".equals(emp.getGender()) ? "selected" : "" %>>Others</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="ms">Marital Status:</label>
                        <select id="ms" name="ms" readonly>
                            <option value="">Select Marital Status</option>
                            <option value="Single" <%= "Single".equals(emp.getMaritalStatus()) ? "selected" : "" %>>Single</option>
                            <option value="Married" <%= "Married".equals(emp.getMaritalStatus()) ? "selected" : "" %>>Married</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="bg">Blood Group:</label>
                        <select id="bg" name="bg" readonly>
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
                </div>
            </div>
            <div class="form-column">
                <div class="form-section">
                    <h3>Contact Details</h3>
                    <div class="form-group">
                        <label for="phone">Personal Contact Number:</label>
                        <input type="text" id="phone" name="phone" value="<%= emp.getPhoneNo() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="email">Personal Email:</label>
                        <input type="email" id="email" name="email" value="<%= emp.getEmail() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="ecn">Emergency Contact Name:</label>
                        <input type="text" id="ecn" name="ecn" value="<%= emp.getEmergencyContactName() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="ec">Emergency Contact Number:</label>
                        <input type="text" id="ec" name="ec" value="<%= emp.getEmergencyContact() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="address">Permanent Address:</label>
                        <textarea id="address" name="address" readonly><%= emp.getAddress() %></textarea>
                    </div>
                    <div class="form-group">
                        <label for="tempadd">Temporary Address:</label>
                        <input type="text" id="tempadd" name="tempadd" value="<%= emp.getTempAddress() %>" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row2">
            <div class="form-column">
                <div class="form-section">
                    <h3>Employee Details</h3>
                    <div class="form-group">
                        <label for="hireDate">Hire Date:</label>
                        <input type="date" id="hireDate" name="hireDate" value="<%= emp.getHiredate() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="role">Role:</label>
                        <select id="role" name="role" readonly>
                            <option value="">Select Role</option>
                            <% for (Roles r : list) { %>
                                <option value="<%= r.getRoleId() %>" <%= (r.getRoleId() == emp.getRoleId()) ? "selected" : "" %>><%= r.getRoleName() %></option>
                            <% } %>
                        </select>
                    </div>
                   
                </div>
            </div>
        </div>
    </form>
</div>

    </div>
</body>
</html>
