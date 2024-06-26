<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.empmngt.dao.EmpDao"%>
<%@ page import="com.empmngt.jdbc.DBConnect"%>
<%@ page import="com.empmngt.enities.Leaves"%>
<%@ page import="com.empmngt.enities.Employees"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Leave Records</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #ADD8E6;
    background-image: url("Images/bg.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 100%;
    margin: 20px auto;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

h4 {
    color: #888;
    text-align: center;
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

button {
    padding: 10px 20px;
    background-color: #FF0000;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
    width: 75%;
}

button:hover {
    background-color: #8B0000;
}

.app {
    background-color: #28a745;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
    width:75%;
}

.app:hover {
    background-color: #218838;
}

.center {
    text-align: center;
}

        .main-container {
        max-width:100%;
    	margin: 40px;
    	padding: 20px;
    	background-color: rgba(255, 255, 255, 0.8);
    	border-radius: 8px;
    	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

</style>
</head>

<script>
    function openPopup(leaveid) {
        document.getElementById("popupLeaveId").value = leaveid;
        document.getElementById("myPopup").style.display = "block";
    }

    function closePopup() {
        document.getElementById("myPopup").style.display = "none";
    }
</script>

<body>
    <jsp:include page="navbar.jsp" />
    <%
    EmpDao er = new EmpDao(DBConnect.getConnection());
    HttpSession ss = request.getSession();
    Employees emp = (Employees) ss.getAttribute("employee");
    int eid = emp.getEmpId();
    
    List<Leaves> list=null;
    if(ss.getAttribute("role").equals("HR"))
    {
     list = er.getPendingLeaves();
    }else if(ss.getAttribute("role").equals("Manager"))
    {
    list = er.getMgrPendingLeaves(eid);
    }
    	

    
    %>
<div class="main-container">
    <div class="container">
        <h2>Leave Requests</h2>
        <%
        if (list != null && !list.isEmpty()) {
        %>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">From Date</th>
                    <th scope="col">To Date</th>
                    <th scope="col">Total Days</th>
                    <th scope="col">Leave Type</th>
                    <th scope="col">Reason</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (Leaves e : list) {
                %>
                <tr>
                    <td scope="row"><%= e.getFname() + " " + e.getLname() %></td>
                    <td><%= e.getFromDate() %></td>
                    <td><%= e.getToDate() %></td>
                    <td><%= e.getTotalDays() %></td>
                    <td><%= e.getLeaveType() %></td>
                    <td><%= e.getAppliedReason() %></td>
                    <td>
                        <form action="updaterejectreason" method="post">
                            <input type="hidden" name="eid" value="<%= eid %>">
                            <input type="hidden" name="leaveid" id="leaveid" value="<%= e.getLeaveId() %>">
                            <input type="submit" value="Approve" class="app">
                        </form><br>
                        <button onclick="openPopup(<%= e.getLeaveId() %>)">Reject</button>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
        <div id="myPopup" class="popup">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <h2>Reject Reason</h2>
            <form action="updaterejectreason" method="post">
                <textarea rows="5" name="rejectreason" required></textarea>
                <input type="hidden" name="eid" value="<%= eid %>">
                <input type="hidden" name="leaveid" id="popupLeaveId">
                <input type="submit" value="Save" class="sub">
            </form>
        </div>
        <%
        } else {
        %>
        <h4>No Records!!</h4>
        <%
        }
        %>
    </div>
    </div>
</body>
</html>
