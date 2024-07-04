<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>

<!DOCTYPE html>
<html>
<head>
<title>Navbar</title>
<style>
/* Your existing CSS here */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    width: 100%;
    font-family: Arial, sans-serif;
}

.navbar-container {
    width: 100%;
    background-color: #333;
}

.navbar {
    display: flex;
    align-items: center;
    max-width: 100%;
    margin: 0 auto;
    height: 60px;
}

.navbar .header {
    color: orange;
}

.navbar .header h1 {
    margin: 0;
    font-size: 24px;
    margin-left: 15px;
}

.navbar .nav-links {
    display: flex;
    align-items: center;
    margin-left: auto;
}

.navbar a {
    display: inline-flex;
    align-items: center;
    color: white;
    text-align: center;
    padding: 0 10px;
    text-decoration: none;
    transition: background-color 0.3s ease, color 0.3s ease;
    height: 60px;
    position: relative;
}

.navbar a:hover, .navbar a:focus, .navbar a:active, .navbar a.active {
    background-color: #ff9800;
    color: white;
    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
}

.navbar a.logout {
    background-color: #333;
}

.navbar a.logout:hover {
    background-color: #ff6347;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown .dropbtn {
    cursor: pointer;
    font-size: 16px;
    border: none;
    outline: none;
    color: white;
    background-color: inherit;
    height: 60px;
    padding: 0 10px;
    position: relative;
    display: flex;
    align-items: center;
}

.dropdown .dropbtn img {
    width: 40px;
    height: 40px;
    vertical-align: middle;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    z-index: 1;
    right: 0;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    height: auto;
}

.dropdown-content a:hover {
    background-color: #ff9800;
    color: white;
}

.dropdown:hover .dropdown-content {
    display: block;
}

.count {
    background-color: red;
    color: white;
    border-radius: 50%;
    padding: 2px 6px;
    font-size: 0.75em;
    margin-left: 5px;
}

.dropdown .dropbtn .count-wrapper {
    margin-left: 5px;
}

.dropdown-content .count {
    margin-left: 5px;
}



@media ( max-width : 768px) {
    .navbar {
        padding: 0 10px;
    }
    .navbar a, .dropdown .dropbtn {
        padding: 0 5px;
        font-size: 14px;
    }
    .navbar .header h1 {
        font-size: 18px;
    }
    .dropdown .dropbtn img {
        width: 30px;
        height: 30px;
    }
    .dropdown-content {
        min-width: 120px;
    }
}
/* Add or modify these CSS rules */
.dropdown.active .dropbtn, 
.navbar .nav-dropdown.active,
.dropdown.active > .dropbtn {
    background-color: #ff9800;
    color: white;
    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
}

.dropdown-content a.active {
    background-color: #ff9800;
    color: white;
}
</style>
</head>
<body>
    <%
        HttpSession se = request.getSession(); 
        Object role = se.getAttribute("role");
        int empid = ((Employees)(se.getAttribute("employee"))).getEmpId();
        int pendingLeavesCount = 0;
        int attendanceUpdateCount = 0;
        EmpDao empDao = new EmpDao(DBConnect.getConnection());
        if(role.equals("HR")){
            pendingLeavesCount = empDao.getPendingLeavesCount();
            attendanceUpdateCount = empDao.getAttendanceUpdateCount();
        } else if(role.equals("Manager")) {
            pendingLeavesCount = empDao.getPendingLeavesForMgrCount(empid);
            attendanceUpdateCount = empDao.getMgrAttendanceUpdateCount(empid);
        }

        // Get the current page name
        String currentPage = request.getServletPath();
    %>
    <div class="navbar-container">
        <div class="navbar">
            <div class="header">
                <h1>Emvee Technologies</h1>
            </div>

            <div class="nav-links">
                <a href="HRhome.jsp" class="nav-link <%= currentPage.equals("/HRhome.jsp") ? "active" : "" %>">Home</a>

                <% if (role.equals("HR")) { %>
                <div class="dropdown <%= currentPage.equals("/addEmp.jsp") || currentPage.equals("/empDetails.jsp") ? "active" : "" %>">
                    <button class="dropbtn nav-dropdown">Employees</button>
                    <div class="dropdown-content">
                        <a href="addEmp.jsp" class="nav-link <%= currentPage.equals("/addEmp.jsp") ? "active" : "" %>">Add Employee</a>
                        <a href="empDetails.jsp" class="nav-link <%= currentPage.equals("/empDetails.jsp") ? "active" : "" %>">Employees</a>
                    </div>
                </div>
                <% } %>

                <% if (role.equals("HR") || role.equals("Manager")) { %>
                <div class="dropdown <%= currentPage.equals("/leaveReq.jsp") || currentPage.equals("/Leaves.jsp") ? "active" : "" %>">
                    <button class="dropbtn nav-dropdown">
                        Leaves
                        <span class="count-wrapper">
                            <span class="count leaves-count" id="leavesMainCount"></span>
                        </span>
                    </button>
                    <div class="dropdown-content">
                        <a href="leaveReq.jsp" class="nav-link <%= currentPage.equals("/leaveReq.jsp") ? "active" : "" %>">Leaves</a>
                        <a href="Leaves.jsp" class="nav-link leave-requests <%= currentPage.equals("/Leaves.jsp") ? "active" : "" %>">
                            Leave Requests <span class="count leaves-count" id="leavesSubCount"></span>
                        </a>
                    </div>
                </div>
                <% } else { %>
                <a href="leaveReq.jsp" class="nav-link <%= currentPage.equals("/leaveReq.jsp") ? "active" : "" %>">Leaves</a>
                <% } %>

                <% if (role.equals("HR") || role.equals("Manager")) { %>
                <div class="dropdown <%= currentPage.equals("/attendance.jsp") || currentPage.equals("/AttendanceUpdateRequest.jsp") ? "active" : "" %>">
                    <button class="dropbtn nav-dropdown">
                        Attendance
                        <span class="count-wrapper">
                            <span class="count attendance-count" id="attendanceMainCount"></span>
                        </span>
                    </button>
                    <div class="dropdown-content">
                        <a href="attendance.jsp" class="nav-link <%= currentPage.equals("/attendance.jsp") ? "active" : "" %>">Attendance</a>
                        <a href="AttendanceUpdateRequest.jsp" class="nav-link attendance-update <%= currentPage.equals("/AttendanceUpdateRequest.jsp") ? "active" : "" %>">
                            Attendance Update <span class="count attendance-count" id="attendanceSubCount"></span>
                        </a>
                    </div>
                </div>
                <% } else { %>
                <a href="attendance.jsp" class="nav-link <%= currentPage.equals("/attendance.jsp") ? "active" : "" %>">Attendance</a>
                <% } %>

                <% if (role.equals("Manager")) { %>
                <a href="Reportees.jsp" class="nav-link <%= currentPage.equals("/Reportees.jsp") ? "active" : "" %>">Reportees</a>
                <% } %>

                <% if (role.equals("HR")) { %>
                <a href="AddHolidays.jsp" class="nav-link <%= currentPage.equals("/AddHolidays.jsp") ? "active" : "" %>">Add Holidays</a>
                <% } %>

                <% if (!role.equals("HR")) { %>
                <a href="ViewHolidays.jsp" class="nav-link <%= currentPage.equals("/ViewHolidays.jsp") ? "active" : "" %>">Holidays</a>
                <% } %>

                <div class="dropdown">
                    <button class="dropbtn nav-dropdown">
                        <img alt="Avatar" src="Images/avatar2.png">
                    </button>
                    <div class="dropdown-content">
                        <a href="profile.jsp" class="<%= currentPage.equals("/profile.jsp") ? "active" : "" %>">Profile</a>
                        <a href="change_password.jsp" class="<%= currentPage.equals("/change_password.jsp") ? "active" : "" %>">Change Password</a>
                        <a href="LogoutServlet" class="logout-btn">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Your existing JavaScript for badge updates
        var leaveRequestCount = <%= pendingLeavesCount %>;
        var attendanceUpdateCount = <%= attendanceUpdateCount %>;
        var leavesMainBadge = document.getElementById('leavesMainCount');
        var leavesSubBadge = document.getElementById('leavesSubCount');
        var attendanceMainBadge = document.getElementById('attendanceMainCount');
        var attendanceSubBadge = document.getElementById('attendanceSubCount');

        function updateBadge(element, count) {
            if (count > 0) {
                element.textContent = count;
                element.style.display = 'inline';
            } else {
                element.style.display = 'none';
            }
        }

        function updateLeavesBadges(count) {
            updateBadge(leavesMainBadge, count);
            updateBadge(leavesSubBadge, count);
        }

        function updateAttendanceBadges(count) {
            updateBadge(attendanceMainBadge, count);
            updateBadge(attendanceSubBadge, count);
        }
     
        updateLeavesBadges(leaveRequestCount);
        updateAttendanceBadges(attendanceUpdateCount);
    </script>
</body>
</html>