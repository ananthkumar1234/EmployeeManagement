<!-- login.jsp -->
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<style>
body {
	font-family: Arial, sans-serif;
	 background-image: url("Images/bg.jpg");
 background-repeat: none;
  background-size: cover;
  background-position: center;
  background-attachment:fixed;
	margin: 0;
	padding: 0;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.login-container {
   /* background-color: rgba(255, 255, 255, 0.5); /* Set the background color with transparency */
    padding: 20px;
    border-radius: 5px;
    box-shadow: 2px 4px 4px rgba(0, 0, 0, 0.1);
    text-align: center;
    width: 300px;
    backdrop-filter: blur(30px); /* Apply a blur effect to the background */
    border:2px solid #ccc;
    border-radius: 10px;
}

.login-container < * {
    opacity: 0.4; /* Reset opacity for children */
}

h2 {
    color: black;
}

label {
    display: block;
    margin-bottom: 10px;
    color: white;
    opacity: 1;
}

input[type="text"],
input[type="password"],
input[type="submit"] {
    width: 100%;
    padding: 8px;
    margin-bottom: 15px;
    box-sizing: border-box;
    border-radius: 7px;
    border: 1px solid #ccc;
    font-size: 14px;
    background-color: white;
}

input[type="submit"] {
    background-color: #007bff;
    color: white;
    cursor: pointer;
    border-radius:8px;
    padding:10px;
    width:100%;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

.login-container .password-container {
    position: relative;
    width: 100%;
}

.login-container .password-container input[type="password"],
.login-container .password-container input[type="text"] {
    padding-right: 40px;
}



.login-container .password-container .toggle-password {
    position: absolute;
    right: 10px;
    top: 35%;
    transform: translateY(-50%);
    cursor: pointer;
    font-size: 16px;
    color: #aaa;
}

.forgot
{
margin-top:20px;

}


</style>

<script>
function togglePasswordVisibility() {
    var passwordInput = document.getElementById('password');
    var togglePassword = document.querySelector('.toggle-password');
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        togglePassword.classList.remove('fa-eye');
        togglePassword.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        togglePassword.classList.remove('fa-eye-slash');
        togglePassword.classList.add('fa-eye');
    }
}
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<div class="login-container">
		<img alt="" src="Images/comLogo.png">
		<h2>Login</h2>
		<form action="LoginServlet" method="post">
			<label for="username">Username:</label> <input type="text"
				id="username" name="username" required><br>
			<label for="password">Password:</label>
        <div class="password-container">
            <input type="password" id="password" name="password" required> <span><i class="fas fa-eye toggle-password" onclick="togglePasswordVisibility()"></i></span>
            
        </div>
			<div>
			<br> <input type="submit" value="Login">
			</div>
			<div>
			<span class="forgot"><a href="forgotpwd.jsp">Forgot Password!</a></span>
			</div>
		</form>
		<% String message = request.getParameter("message"); if (message != null) { %>
		<script> alert("<%= message %>"); </script>
		<% } %>
	</div>
</body>
</html>
