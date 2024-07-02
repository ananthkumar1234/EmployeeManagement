<%@ page import="com.empmngt.dao.EmpDao" %>
<%@ page import="com.empmngt.jdbc.DBConnect" %>

<!DOCTYPE html>
<html>
<head>
    <title>Navbar</title>
    <style>
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
    margin-left: auto; /* Add this line */
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
    position: relative; /* Add this line */
}

.navbar a:hover,
.navbar a:focus,
.navbar a:active,
.navbar a.active {
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
    right: 0;  /* Position the dropdown menu to the right */
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
    position: absolute;
    top: 40px;
    right: 6px;
    transform: translate(50%, -50%);
}

@media (max-width: 768px) {
    .navbar {
        padding: 0 10px;
    }

    .navbar a,
    .dropdown .dropbtn {
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

    </style>
</head>
<body>

    <%
        EmpDao empDao = new EmpDao(DBConnect.getConnection());
        int pendingLeavesCount = empDao.getPendingLeavesCount();
    %>
    <div class="navbar-container">
        <div class="navbar">
            <div class="header">
                <h1>Emvee Technologies</h1>
            </div>

            <div class="nav-links">
                <a href="HRhome.jsp" class="nav-link">Home</a>
                <a href="leaveReq.jsp" class="nav-link">Leaves</a>
                <% HttpSession se = request.getSession(); Object role = se.getAttribute("role"); %>
                <% if (role.equals("HR")) { %>
                <a href="addEmp.jsp" class="nav-link">Add Employee</a>
                <a href="empDetails.jsp" class="nav-link">Employees</a>
                <a href="AddHolidays.jsp" class="nav-link">Add Holidays</a>
                <% } %>
                <% if (role.equals("HR") || role.equals("Manager")) { %>
                <a href="Leaves.jsp" class="nav-link leave-requests">Leave Requests <span class="count" style="display: none;"></span></a>
                <% } %>
                <a href="attendance.jsp" class="nav-link">Attendance</a>
                <% if (!role.equals("HR")) { %>
                <a href="ViewHolidays.jsp" class="nav-link">Holidays</a>
                <% } %>
                <% if (role.equals("Manager")) { %>
                <a href="Reportees.jsp" class="nav-link">Reportees</a>
                <% } %>
                <% if (role.equals("HR") || role.equals("Manager")) { %>
                <a href="AttendanceUpdateRequest.jsp" class="nav-link">Attendance Update</a>
                <% } %>

                <div class="dropdown">
                    <button class="dropbtn">
                        <img alt="Avatar" src="Images/avatar2.png">
                    </button>
                    <div class="dropdown-content">
                        <a href="profile.jsp">Profile</a>
                        <a href="change_password.jsp">Change Password</a>
                        <a href="LogoutServlet" class="logout-btn">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var links = document.querySelectorAll('.nav-link');
            var logoutButton = document.querySelector('.logout-btn');
            var homePageLink = "HRhome.jsp";
            var leaveRequestCount = <%= pendingLeavesCount %>;
            var leaveRequestsLink = document.querySelector('.leave-requests .count');

            function setActiveLink() {
                var activeLink = localStorage.getItem('activeLink');
                if (activeLink) {
                    links.forEach(function(link) {
                        if (link.href === activeLink) {
                            link.classList.add('active');
                        }
                    });
                }
            }

            setActiveLink();

            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    links.forEach(function(link) {
                        link.classList.remove('active');
                    });
                    this.classList.add('active');
                    localStorage.setItem('activeLink', this.href);
                });
            });

            if (logoutButton) {
                logoutButton.addEventListener('click', function() {
                    localStorage.setItem('activeLink', homePageLink);
                });
            }
            
            function updateLeaveRequestBadge(count) {
                if (count > 0) {
                    leaveRequestsLink.textContent = count;
                    leaveRequestsLink.style.display = 'inline';
                } else {
                    leaveRequestsLink.style.display = 'none';
                }
            }

            // Call the function to update the badge based on the count
            updateLeaveRequestBadge(leaveRequestCount);
        });
    </script>
</body>
</html>
