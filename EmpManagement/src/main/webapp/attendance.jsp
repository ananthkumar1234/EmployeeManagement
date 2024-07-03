<%@ page import="java.util.List"%>
<%@ page import="com.empmngt.enities.Roles"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="com.empmngt.enities.Attendance"%>

<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.Duration"%>

<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html>
<head>
<title>Attendance</title>
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
	max-width: 100%;
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

.filter input[type="text"], .filter input[type="date"], .filter select {
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
	color: #333;
	margin: 10px;
}

.popup textarea {
	width: 95%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.popup input.sub {
	width: 50%;
	padding: 10px;
	margin-top: 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

.popup input.sub:hover {
	background-color: #0056b3;
}

.warning {
	margin: 10px;
}

.msg {
	margin: 15px;
}

/* Styling for form container */
.PopupForm {
	max-width: 400px;
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Styling for form labels */
.PopupForm label {
	display: block;
	margin-bottom: 5px;
	color: #333333;
	font-weight: bold;
}

/* Styling for form inputs */
.PopupForm input[type="text"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #cccccc;
	border-radius: 4px;
	font-size: 14px;
}

/* Styling for submit button */
.PopupForm input[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: #ffffff;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.PopupForm input[type="submit"]:hover {
	background-color: #0056b3;
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
<%Boolean f = (Boolean) request.getAttribute("flag");
if (f != null && f) {%>
	document.getElementById("myPopup").style.display = "block";
<%}%>
	}

	function openPopup() {
		document.getElementById("myPopup").style.display = "block";
	}

	function openPopup2(AttenId, Date, CITime, COTime) {
		document.getElementById("attenId").value = AttenId;
		document.getElementById("date").value = Date;
		document.getElementById("cit").value = CITime;
		document.getElementById("cot").value = COTime;
		document.getElementById("myPopup2").style.display = "block";
	}

	function closePopup(popupId) {
		document.getElementById(popupId).style.display = "none";
	}
</script>
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<%
	String msg = (String) request.getAttribute("msg");
	HttpSession ses = request.getSession();
	Employees emp = (Employees) ses.getAttribute("employee");
	int eid = emp.getEmpId();
	EmpDao empDao = new EmpDao(DBConnect.getConnection());
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("filteredAttendance");
	String empName = emp.getFname() + " " + emp.getLname();
	%>

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
					%>
					<p><%=msg%></p>
					<%
					}
					%>
				</div>
			</div>
			<div class="main-content">
				<div class="form-container">
					<h2>Attendance List</h2>
					<div class="filter">
						<form action="filterAttendance" method="get">
							<input type="hidden" name="id" value="<%=eid%>"> <input
								type="hidden" name="origin" value="attendance"> <label
								for="year">Year:</label> <input type="text" id="year"
								name="year" onkeyup="toggleMonthDropdown()"
								value="<%=request.getParameter("year") != null ? request.getParameter("year") : ""%>">
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
							<button type="submit">Filter</button>
						</form>
					</div>
					<table>
						<thead>
							<tr>
								<th>Date</th>
								<th>Check In Time</th>
								<th>Check Out Time</th>
								<th>Total Hours</th>
								<th>Remarks</th>
								<th>Request Update</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (attendanceList == null) {
								attendanceList = empDao.getAttRecordById(eid);
							}
							for (Attendance attendance : attendanceList) {
								boolean highlightRow = (attendance.getCheckin() != null && attendance.getCheckout() == null)
								&& (LocalDate.now().isAfter(LocalDate.parse(attendance.getDate(), formatter)));
							%>
							<tr <%=highlightRow ? "style='background-color: #949494;'" : ""%>>
								<td><%=attendance.getDate()%></td>
								<td><%=attendance.getCheckin()%></td>
								<td><%=attendance.getCheckout()%></td>
								<td>
									<%
									if (attendance.getCheckin() != null && attendance.getCheckout() != null) {
										try {
											LocalTime st = LocalTime.parse(attendance.getCheckin());
											LocalTime et = LocalTime.parse(attendance.getCheckout());
											Duration difference = Duration.between(st, et);
											long hours = difference.toHours();
											long minutes = difference.toMinutes() % 60;
											out.print(hours + "h : " + minutes + "m");
										} catch (Exception ex) {
											out.print("Invalid time format");
										}
									} else if (attendance.getCheckin() != null && attendance.getCheckout() == null
											&& LocalDate.now().isAfter(LocalDate.parse(attendance.getDate(), formatter))) {
										out.print("Checkout is missing");
									} else {
										out.print("-");
									}
									%>
								</td>
								<td>
									<%
									if (attendance.getRemarks() == null)
										out.print("-");
									else
										out.print(attendance.getRemarks());
									%>
								</td>

								<td>
									<%
									if (attendance.isButtonClicked() == 0 && 
								    !("Weekend".equals(attendance.getRemarks()) || 
								      "Holiday".equals(attendance.getRemarks()) || 
								      "Leave".equals(attendance.getRemarks()))) {
									%>
									<button
										onclick="openPopup2('<%=attendance.getAttendId()%>', '<%=attendance.getDate()%>', '<%=attendance.getCheckin()%>', '<%=attendance.getCheckout()%>')">Request Update</button> 
										<% } else {
											 out.print("-");
										 }
										 %>

								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>

					<!-- Attendance Update Popup -->
					<div id="myPopup2" class="popup">
						<span class="close-btn" onclick="closePopup('myPopup2')">&times;</span>
						<h2>Update Attendance</h2>
						<form action="requestUpdate" method="get" class="PopupForm">
							<label for="attenId"></label> 
							<input type="hidden" id="attenId" name="attenId"> 
							<input type="hidden" name="empName" value="<%=empName%>"> 
							<label for="date">Date:</label> 
							<input type="text" id="date" name="date" readonly> 
							<label for="cit">Check In Time:</label> 
							<input type="text" id="cit" name="cit" placeholder="HH:MM:SS (24hr)"> 
							<label for="cot">Check Out Time:</label> 
							<input type="text" id="cot" name="cot" placeholder="HH:MM:SS (24hr)"> 
							<input type="submit" value="Request Update">
						</form>
					</div>

					<!-- General Notification Popup -->
					<div id="myPopup" class="popup">
						<span class="close-btn" onclick="closePopup('myPopup')">&times;</span>
						<h2>Warning!</h2>
						<form action="insertYES" method="post">
							<input type="hidden" name="eid" value="<%=eid%>"> <input
								type="hidden" name="leaveid" id="leaveid">
							<div class="warning">
								<h5>Today it's not a working day (Holiday!)</h5>
							</div>
							<div class="msg">Are you sure you want to login?</div>
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
</html>