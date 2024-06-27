<html>
<title>Navbar</title>
<head>
<style>
*
{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    width: 100%;
    font-family: Arial, sans-serif;
}

.navbar {
    width: 100%;
    overflow: hidden;
    background-color: #333;
    height: 8%;
    
}

.navbar a {
    display: inline-block;
    color: white;
    text-align: center;
    padding: 2% 1%;
    text-decoration: none;
}

.navbar a:hover {
    background-color: #ddd;
    color: black;
}

.navbar a.logout {
    float: right;
    background-color: #333;
}

.navbar a.logout:hover {
    background-color: #ff6347;
}

.header {
    color: orange;
    text-align: center;
    padding: 1% 0;
}

.dropdown .dropbtn img {
    width: 2.5%;
    height: auto;
    margin-bottom: 1%;
    position: absolute;
    right: 1%;
    top: 21%;
    transform: translateY(-20%);
}

.navbar a.avatar {
    width: 2.5%;
    height: auto;
    margin-bottom: -1%;
    margin-top: 1%;
    position: absolute;
    right: 14%;
    background-color: #333;
}

.dropdown {
    float: right;
    overflow: hidden;
}

/* Dropdown button */
.dropdown .dropbtn {
    cursor: pointer;
    font-size: 1.6vw; /* 16px */
    border: none;
    outline: none;
    color: white;
    padding: 2.8vw 4vw; /* 14px 20px */
    background-color: inherit;
    margin: 0;
}

/* Add a background color to the dropdown button on hover */
.navbar a:hover, .dropdown:hover .dropbtn {
    background-color: #ddd;
    color: black;
}

/* Dropdown content (hidden by default) */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 12.8vw; /* 160px */
    box-shadow: 0.32vw 0.64vw 1.28vw 0px rgba(0,0,0,0.2); /* 0px 8px 16px 0px */
    z-index: 1;
    right: 0;
}

/* Links inside the dropdown */
.dropdown-content a {
    float: none;
    color: black;
    padding: 1.6vw 2.13vw; /* 12px 16px */
    text-decoration: none;
    display: block;
    text-align: left;
}

/* Add a background color to dropdown links on hover */
.dropdown-content a:hover {
    background-color: #ddd;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
    display: block;
}

.count {
    background-color: red;
    color: white;
    border-radius: 50%;
    padding: 4px 8px;
    font-size: 0.8em;
    position:relative;
}


      
</style>


</head>
<body>
	<div class="navbar">
	
		<div class="header">
        <h1>Emvee Technologies</h1>
    	</div>
    	
		<a href="HRhome.jsp">Home</a> <a href="leaveReq.jsp">Leaves</a>
		<%
        HttpSession se = request.getSession();
    	Object role = se.getAttribute("role");
    	
        %>


		<% if (role.equals("HR")) { %>
		<a href="addEmp.jsp">Add Employee</a> 
		<a href="empDetails.jsp">Employees</a>
		<a href="AddHolidays.jsp">AddHolidays</a>
		<% } %>
		
		<% if (role.equals("HR") || role.equals("Manager")){ %>
		<a href="Leaves.jsp">Leave Requests<%
        Integer count = (Integer) session.getAttribute("count");
        if (count != null && count > 0) {
    %>
            <span class="count"><%= count %></span>
    <%
        }
    %></a>
    <%} %>
		
		<a href="attendance.jsp">Attendance</a>
		
	<%-- 	<button id="theme-switcher">Switch Theme</button>  --%>
		
		<% if (!role.equals("HR")) { %>
		<a href="ViewHolidays.jsp">Holidays</a>
		<%} %>
		
		<% if (role.equals("Manager")) { %>
		<a href="Reportees.jsp"> Reportees</a>
		
<%} %>
		<% if (role.equals("HR") || role.equals("Manager")) { %>
		<a href="AttendanceUpdateRequest.jsp">Attendance Update</a>
		<%} %>
		<div class="dropdown">
            <button class="dropbtn">
            <img alt="" src="Images/avatar2.png" style="height: 40px; width: 40px; margin-top:-55px; margin-right:-10px;">
                <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-content">
                <a href="profile.jsp">Profile</a>
                <a href="change_password.jsp">Change Password</a>
                <a href="LogoutServlet">Logout</a>
            </div>
        </div>
	</div>
	


</body>
</html>