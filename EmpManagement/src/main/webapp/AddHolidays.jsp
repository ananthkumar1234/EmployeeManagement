<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.enities.AddHoliday"%>
<%@ page import="java.util.List"%>

<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Holiday</title>
<style>

/* Reset default browser styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

/* Style for the body */
body {
	font-family: Arial, sans-serif;
	background-image: url("Images/bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
}

/* Style for the main container */
.main-container {
	display: flex;
	max-width: 100%;
	margin: 40px;
	padding: 20px;
	background-color: rgba(255, 255, 255, 0.8);
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Style for the left column */
.left-column {
	flex: 1;
	width: 50%;
	margin: 10px; /* Adjust width as needed */
}

/* Style for the right column */
.right-column {
	flex: 2;
	width: 100%; /* Adjust width as needed */
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 10px;
	padding: 20px;
}

/* Style for the AddHoliday container */
.AddHoliday {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 20px;
}

/* Style for the AssignLeaves container */
.AssignLeaves {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

h2 {
	text-align: center;
	color: white;
	margin-bottom: 20px;
	background-color: #333;
	padding: 10px;
	border-radius: 4px 4px 0 0;
}

/* Style for input fields */
input[type="date"], input[type="text"], input[type="submit"] {
	width: 100%;
	padding: 10px;
	border-radius: 4px;
	border: 1px solid #ccc;
	margin-bottom: 10px;
	font-size: 16px;
}

/* Style for buttons */
button[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
	background-color: #555;
}

.table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	background-color: white;
}

.table thead {
	background-color: #333;
	color: #fff;
}

.table th, .table td {
	padding: 12px;
	border: 1px solid #ddd;
	text-align: center;
}

.table th {
	font-weight: bold;
}

.table tr:nth-child(even) {
	background-color: #f9f9f9;
}

.table tr td:last-child {
	text-align: center;
}

.right-column h2 {
	background-color: white;
	color: #333
}

.strikethrough {
	text-decoration: line-through;
	color: red;
}

.form-group {
	margin-bottom: 5px;
}

.error-message {
	color: red;
	font-size: 0.9em;
	display: none;
}

.star {
	color: red;
	font-size: 20px;
}
</style>

<link rel="stylesheet"
	href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">

</head>
<body>
	<%@include file="navbar.jsp"%>
	<div class="main-container">
		<div class="left-column">
			<div class="AddHoliday">
				<h2>Add a New Holiday</h2>

				<form id="holidayForm" action="AddHolidayServlet" method="post">

					<div class="form-group">
						<label for="date">Date<span class="star">*</span></label> <input
							type="text" id="date" name="date" placeholder="yyyy-mm-dd"><br>
						<span class="error-message" id="dateError">Please select a
							date.</span>
					</div>


					<label for="holidayName">Holiday Name<span class="star">*</span></label>
					<input type="text" id="holidayName" name="holidayName"><br>
					<span class="error-message" id="holidayNameError">Please
						enter a holiday Name.</span>


					<button type="submit">Add Holiday</button>
				</form>

				<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

				<script>
					document
							.addEventListener(
									"DOMContentLoaded",
									function() {
										flatpickr("#date");

										document
												.getElementById("holidayForm")
												.addEventListener(
														"submit",
														function(event) {
															let isValid = true;

															const fromDate = document
																	.getElementById("date");
															const fromDateError = document
																	.getElementById("dateError");
															if (!fromDate.value) {
																fromDateError.style.display = "inline";
																isValid = false;
															} else {
																fromDateError.style.display = "none";
															}

															const toDate = document
																	.getElementById("holidayName");
															const toDateError = document
																	.getElementById("holidayNameError");
															if (!toDate.value) {
																toDateError.style.display = "inline";
																isValid = false;
															} else {
																toDateError.style.display = "none";
															}

															if (!isValid) {
																event
																		.preventDefault();
															}
														});
									});
				</script>
			</div>

		</div>

		<div class="right-column">
			<%
			EmpDao er = new EmpDao(DBConnect.getConnection());
			List<AddHoliday> list = er.displayHolidays();

			String msg = (String) request.getAttribute("msg");
			%>
			<h2>List of Holidays</h2>
			<%
			if (msg != null) {
				out.print(msg);
			}
			%>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">Date</th>
						<th scope="col">Holiday Name</th>
						<th scope="col">Day</th>
						<th scope="col">Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					LocalDate today = LocalDate.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

					for (AddHoliday a : list) {
						LocalDate holidayDate = LocalDate.parse(a.getDate(), formatter);
						boolean isPast = holidayDate.isBefore(today);
					%>
					<tr class="<%=isPast ? "strikethrough" : ""%>">
						<td><%=a.getDate()%></td>
						<td><%=a.getName()%></td>
						<td><%=holidayDate.getDayOfWeek()%></td>
						<td><a href="deleteHoliday?id=<%=a.getId()%>">Delete</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

		</div>
	</div>
</body>
</html>