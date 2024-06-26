<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
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

</style>
<body>
<%
HttpSession sess = request.getSession();
String uname = (String)sess.getAttribute("username");
String msg = (String)request.getAttribute("msg");

%>
    <div class="form-container">
        <h2>Reset Password</h2>
        <form action="ResetPasswordServlet" method="post">
             <label for="username">UserName:</label>
            <input type="text" id="uname" name="uname" value="<%= uname %>" readonly>
            
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <input type="submit" value="Reset">
        </form>
        <%
        if(msg!=null && !msg.isEmpty())
        	out.print(msg);
        %>
        
    </div>
</body>
</html>
