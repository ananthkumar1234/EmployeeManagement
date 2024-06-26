<%@ page import="java.util.List"%>
<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="com.empmngt.enities.Attendance"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.Duration"%>


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
            font-family: Arial, sans-serif;
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

        .content {
            display: flex;
        }

        .sidebar {
            width: 25%;
            margin-right: 15px;
            background-color: white;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 0.5px solid black;
            border-radius: 8px;
        }

        .main-content {
            width: 75%;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        h1 {
            color: orange;
        }

        .tools {
            margin-bottom: 20px;
        }

        .tools h3 {
            background-color: #333;
            color: white;
            padding: 10px;
            margin: 0;
            border-radius: 4px 4px 0 0;
            text-align: center;
        }

        .button-container {
            display: flex;
            gap: 20px;
            padding: 15px;
            align-items: center;
            justify-content: center;
        }

        .button-container input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            width: 100px;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .button-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #333;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .filter {
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .filter form {
            display: flex;
            gap: 15px;
            align-items: center;
            justify-content: space-between;
        }

        .filter label {
            font-weight: bold;
            color: #333;
        }

        .filter input[type="text"],
        .filter input[type="date"],
        .filter select {
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 14px;
            width: 150px;
        }

        .filter button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .filter button:hover {
            background-color: #0056b3;
        }

        .popup {
            display: none;
            position: fixed;
            z-index: 9;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            border: 1px solid #888;
            border-radius: 8px;
            background-color: #fefefe;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 400px;
            text-align: center;
        }

        .close-btn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close-btn:hover, .close-btn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .popup h2 {
            color: orange;
            margin-bottom: 15px;
        }

        .warning {
            margin: 10px;
        }

        .msg {
            margin: 15px;
        }
    </style>
    
   

    <script>
        function toggleMonthDropdown() {
            var yearInput = document.getElementById('year');
            var monthDropdown = document.getElementById('month');
            monthDropdown.disabled = yearInput.value.trim() === "";
        }

        window.onload = function() {
            toggleMonthDropdown(); // Initial check

            <%
            Boolean f = (Boolean) request.getAttribute("flag");
            if (f != null && f) {
            %>
                document.getElementById("myPopup").style.display = "block";
            <% } %>
        }

        function openPopup() {
            document.getElementById("myPopup").style.display = "block";
        }

        function closePopup() {
            document.getElementById("myPopup").style.display = "none";
        }
    </script>
</head>
<body>
    <%
        String msg = (String) request.getAttribute("msg");
    %>

    <jsp:include page="navbar.jsp" />
    <div class="container">
        <div class="content">
            <div class="sidebar">
                <div class="tools">
                    <h3>Attendance</h3>
                    <div class="button-container">
                        <form action="insertLogin" method="post">
                            <input type="submit" value="Log In" name="login">
                        </form>

                        <form action="updateLogout" method="post">
                            <input type="submit" value="Log Out" name="logout">
                        </form>
                    </div>

                    <%
                        if (msg != null) {
                            out.print(msg);
                        }
                    %>
                </div>
                <div class="tools"></div>
            </div>

            <div class="main-content">
                <div class="form-container">
                    <h2>Attendance List</h2>

                    <!-- Filter Container -->
                    <div class="filter">
                        <form action="filterAttendance" method="get">
                            <input type="hidden" name="id" value="<%= ((Employees) request.getSession().getAttribute("employee")).getEmpId() %>">
                            <input type="hidden" name="origin" value="attendance">
                            <label for="year">Year:</label>
                            <input type="text" id="year" name="year" onkeyup="toggleMonthDropdown()" value="<%= request.getParameter("year") != null ? request.getParameter("year") : "" %>">
                            
                            <label for="month">Month:</label>
                            <select id="month" name="month">
                                <option value="" <%= "".equals(request.getParameter("month")) ? "selected" : "" %>>Select Month</option>
                                <option value="01" <%= "01".equals(request.getParameter("month")) ? "selected" : "" %>>January</option>
                                <option value="02" <%= "02".equals(request.getParameter("month")) ? "selected" : "" %>>February</option>
                                <option value="03" <%= "03".equals(request.getParameter("month")) ? "selected" : "" %>>March</option>
                                <option value="04" <%= "04".equals(request.getParameter("month")) ? "selected" : "" %>>April</option>
                                <option value="05" <%= "05".equals(request.getParameter("month")) ? "selected" : "" %>>May</option>
                                <option value="06" <%= "06".equals(request.getParameter("month")) ? "selected" : "" %>>June</option>
                                <option value="07" <%= "07".equals(request.getParameter("month")) ? "selected" : "" %>>July</option>
                                <option value="08" <%= "08".equals(request.getParameter("month")) ? "selected" : "" %>>August</option>
                                <option value="09" <%= "09".equals(request.getParameter("month")) ? "selected" : "" %>>September</option>
                                <option value="10" <%= "10".equals(request.getParameter("month")) ? "selected" : "" %>>October</option>
                                <option value="11" <%= "11".equals(request.getParameter("month")) ? "selected" : "" %>>November</option>
                                <option value="12" <%= "12".equals(request.getParameter("month")) ? "selected" : "" %>>December</option>
                            </select>

                            <label for="fromDate">From Date:</label>
                            <input type="date" id="fromDate" name="fromDate" value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">

                            <label for="toDate">To Date:</label>
                            <input type="date" id="toDate" name="toDate" value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">

                            <button type="submit">Filter</button>
                        </form>
                    </div>

                    <%
                        Connection con = DBConnect.getConnection();
                        EmpDao eDao = new EmpDao(con);
                        List<Roles> list = eDao.getRoles();
                    %>
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>TotalHours</th>
                                <th>Remarks</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                HttpSession ses = request.getSession();
                                Employees emp = (Employees) ses.getAttribute("employee");
                                int eid = emp.getEmpId();
                                EmpDao er = new EmpDao(DBConnect.getConnection());

                                // Fetch filtered attendance records
                                List<Attendance> list1 = (List<Attendance>) request.getAttribute("filteredAttendance");

                                // If no filtered records, fetch all records
                                if (list1 == null) {
                                    list1 = er.getAttRecordById(eid);
                                }

                                for (Attendance e : list1) {
                            %>
                            <tr>
    <td><%= e.getDate() %></td>
    <td><%= e.getCheckin() %></td>
    <td><%= e.getCheckout() %></td>
    
    <% 
        if (e.getCheckin() != null && e.getCheckout() != null) {
            try {
                LocalTime st = LocalTime.parse(e.getCheckin());
                LocalTime et = LocalTime.parse(e.getCheckout());
                Duration difference = Duration.between(st, et);

                long hours = difference.toHours();
                long minutes = difference.toMinutes() % 60;
    %>
                <td><%=hours + "h : " + minutes+ "m"%></td>
    <% 
            } catch (Exception ex) {
                // Handle the exception if the time string cannot be parsed
    %>
                <td>Invalid time format</td>
    <% 
            }
        } else {
    %>
        <td>Checkin or Checkout is missing</td>
    <% 
        }
    %>
    
    <td><%= e.getRemarks() %></td>
     
</tr>

                            <% } %>
                        </tbody>
                    </table>

                    <div id="myPopup" class="popup">
                        <span class="close-btn" onclick="closePopup()">&times;</span>
                        <h2>Warning!</h2>
                        <form action="insertYES" method="post">
                            <input type="hidden" name="eid" value="<%= eid %>">
                            <input type="hidden" name="leaveid" id="leaveid">
                            <div class="warning">
                                <h5>Today it's not working day (Holiday!)</h5>
                            </div>
                            <div class="msg">
                                Are you sure you want to login?
                            </div>
                            <div>
                                <input type="submit" value="Proceed to login" name="yes">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
