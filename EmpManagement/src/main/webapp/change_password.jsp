<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url("Images/bg.jpg");
 background-repeat: none;
  background-size: cover;
  background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .star
        {
        color:red;
        size:16px;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Change Password</h2>
        <form action="ChangePasswordServlet" method="post">
            
            <label for="newPassword">New Password<span class="star">*</span></label>
            <input type="password" id="newPassword" name="newPassword" required 
                   pattern="(?=.*\d)(?=.*[A-Z]).{6,}" 
                   title="Password must be at least 6 characters long, contain at least one numeric digit, and one uppercase letter.">
            
            <label for="confirmPassword">Confirm Password<span class="star">*</span></label>
            <input type="password" id="confirmPassword" name="confirmPassword" required 
                   pattern="(?=.*\d)(?=.*[A-Z]).{6,}" 
                   title="Password must be at least 6 characters long, contain at least one numeric digit, and one uppercase letter.">
            
            <input type="submit" value="Change Password">
        </form>
        <% String message = request.getParameter("message"); if (message != null) { %>
		<script> alert("<%= message %>"); </script>
		<% } %>
    </div>
</body>
</html>
