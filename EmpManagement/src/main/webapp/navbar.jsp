<!DOCTYPE html>
<html>
<head>
    <title>Navbar</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            background-color: #333;
            padding: 10px 20px;
        }

        .navbar .header {
            color: orange;
            flex-grow: 1;
        }

        .navbar .header h1 {
            margin: 0;
        }

        .navbar .nav-links {
            display: flex;
            align-items: center;
        }

        .navbar a {
            display: inline-block;
            color: white;
            text-align: center;
            padding: 10px;
            text-decoration: none;
            transition: background-color 0.3s ease, color 0.3s ease;
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
        }

        .dropdown .dropbtn img {
            width: 40px;
            height: auto;
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
        }

        .dropdown-content a:hover {
            background-color: #ff9800;
            color: white;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .count {
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 4px 8px;
            font-size: 0.8em;
            position: absolute;
            top: 0;
            right: 0;
        }

        @media (max-width: 768px) {
            .navbar a, .dropdown .dropbtn {
                padding: 8px 5px;
                font-size: 14px;
            }

            .header h1 {
                font-size: 18px;
            }

            .dropdown .dropbtn img {
                width: 30px;
            }

            .dropdown-content {
                min-width: 120px;
            }

            .dropdown-content a {
                padding: 10px 12px;
            }
        }
    </style>
</head>
<body>
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
            <a href="Leaves.jsp" class="nav-link">Leave Requests<% Integer count = (Integer) session.getAttribute("count"); if (count != null && count > 0) { %>
            <span class="count"><%= count %></span>
            <% } %>
            </a>
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

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var links = document.querySelectorAll('.nav-link');
            var logoutButton = document.querySelector('.logout-btn');
            var homePageLink = "HRhome.jsp";

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
        });
    </script>
</body>
</html>
