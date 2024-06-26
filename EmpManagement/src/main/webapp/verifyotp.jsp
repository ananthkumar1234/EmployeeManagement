<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
</head>
<style>
 body {
            font-family: Arial, sans-serif;
           background-image: url("Images/bg.jpg");
 background-repeat: none;
  background-size: cover;
  background-position: center;
  background-attachment:fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }


 .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        
         label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            text-align: left;
        }

        input[type="text"]
        {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
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
String msg = (String)request.getAttribute("msg");
%>
    <div class="form-container">
        <h2>Verify OTP</h2>
        <form action="VerifyOTPServlet" method="post">
            <label for="otp">Enter OTP : </label>
            <input type="text" id="otp" name="otp" required><br>
            <input type="submit" value="Verify">
        </form>
        
         <%
        if(msg!=null && !msg.isEmpty())
        	out.print(msg);
        %>
    </div>
</body>
</html>
