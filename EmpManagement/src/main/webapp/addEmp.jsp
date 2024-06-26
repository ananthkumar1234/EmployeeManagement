<%@ page import="java.util.List" %>
<%@ page import="com.empmngt.enities.Roles" %>
<%@ page import="com.empmngt.jdbc.DBConnect" %>
<%@ page import="com.empmngt.dao.EmpDao" %>
<%@ page import="java.sql.Connection" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
    <style>
        body {
            background-color: #ADD8E6;
            background-image: url("Images/bg.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            
            font-family: verdana;
            margin: 0;
            padding: 0;
        }

        .container {
        max-width:100%;
    	margin: 40px;
    	padding: 20px;
    	background-color: rgba(255, 255, 255, 0.8);
    	border-radius: 8px;
    	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            background-color: #333;
            color: white;
            padding: 10px;
            border-radius: 8px 8px 0 0;
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
            width: 25%;
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

        /* Add specific styles for improved consistency */
        .form-section {
            background: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            border: 1px solid #ccc;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #007bff;
        }

        input[type="submit"] {
            background-color: #28a745;
        }

        input[type="submit"]:hover {
            background-color: #218838;
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

    <div class="container">
        <h2>Add Employee</h2>
        <form action="AddEmployeeServlet" method="post">
            <div class="form-row">
                <div class="form-column">
                    <div class="form-section">
                        <h3>Personal Details</h3>
                        <div class="form-group">
                            <label for="firstName">First Name:</label>
                            <input type="text" id="firstName" name="firstName" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name:</label>
                            <input type="text" id="lastName" name="lastName" required>
                        </div>
                        <div class="form-group">
                            <label for="dob">Date of Birth:</label>
                            <input type="date" id="dob" name="dob" required>
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender:</label>
                            <select id="gender" name="gender" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Others">Others</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ms">Marital Status:</label>
                            <select id="ms" name="ms" required>
                                <option value="">Select Marital Status</option>
                                <option value="Single">Single</option>
                                <option value="Married">Married</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="bg">Blood Group:</label>
                            <select id="bg" name="bg" required>
                                <option value="">Select Blood Group</option>
                                <option value="A Positive">A Positive</option>
                                <option value="A Negative">A Negative</option>
                                <option value="B Positive">B Positive</option>
                                <option value="B Negative">B Negative</option>
                                <option value="O Positive">O Positive</option>
                                <option value="O Negative">O Negative</option>
                                <option value="AB Positive">AB Positive</option>
                                <option value="AB Negative">AB Negative</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-column">
                    <div class="form-section">
                        <h3>Contact Details</h3>
                        <div class="form-group">
                            <label for="phone">Personal Contact Number:</label>
                            <input type="text" id="phone" name="phone" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Personal Email:</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="ecn">Emergency Contact Name:</label>
                            <input type="text" id="ecn" name="ecn" required>
                        </div>
                        <div class="form-group">
                            <label for="ec">Emergency Contact Number:</label>
                            <input type="text" id="ec" name="ec" required>
                        </div>
                        <div class="form-group">
                            <label for="address">Permanent Address:</label>
                            <textarea id="address" name="address" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="tempadd">Temporary Address:</label>
                            <input type="text" id="tempadd" name="tempadd" required>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-column">
                    <div class="form-section">
                        <h3>Employee Details</h3>
                        <div class="form-group">
                            <label for="hireDate">Hire Date:</label>
                            <input type="date" id="hireDate" name="hireDate" required>
                        </div>
                        <div class="form-group">
                            <label for="role">Role:</label>
                            <select id="role" name="role" required>
                                <option value="">Select Role</option>
                                <% for(Roles r : list) { %>
                                    <option value="<%= r.getRoleId() %>"><%= r.getRoleName() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-column">
                    <div class="form-section">
                        <h3>Employee Credentials</h3>
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type="text" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required>
                        </div>
                    </div>
                </div>
            </div>
            
            <center><input type="submit" value="Save"></center> 
        </form>
    </div>
</body>
</html>
