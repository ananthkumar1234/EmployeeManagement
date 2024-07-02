<%@ page import="java.util.List" %>
<%@ page import="com.empmngt.enities.Roles" %>
<%@ page import="com.empmngt.jdbc.DBConnect" %>
<%@ page import="com.empmngt.dao.EmpDao" %>
<%@ page import="java.sql.Connection" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            
            font-family: verdana;
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

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            background-color: #333;
            color: white;
            padding: 10px;
            border-radius: 8px 8px 0 0;
        }

        .form-section {
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            background: #f9f9f9;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 25px;
        }

        .form-group label {
            font-weight: bold;
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f1f1f1;
        }

        input[type="submit"] {
            width: 25%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            text-align: center;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
        }

        .form-column {
            flex: 1;
            margin: 0 10px;
        }

        h3 {
            background-color: #333;
            color: white;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px 4px 0 0;
            text-align: center;
        }

        .form-section {
            background: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            border: 1px solid #ccc;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #007bff;
        }

        input[type="submit"] {
            background-color: #28a745;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .star {
            color: red;
            font-size: 20px;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
            display: none;
            margin-top: 5px;
        }
    </style>
    <link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
    <script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            flatpickr("#dob");
            flatpickr("#hireDate");
        });
    </script>
</head>
<body>
    <% 
        Connection con = DBConnect.getConnection();
        EmpDao eDao = new EmpDao(con);
        List<Roles> list = eDao.getRoles();
    %>
    
    <%@include file="navbar.jsp" %>

    <div class="container">
        <% if(request.getAttribute("msg") != null) { %>
            <script>alert("<%= request.getAttribute("msg") %>");</script>
        <% } %>

        <h2>Add Employee</h2>
        <form id="empForm" action="AddEmployeeServlet" method="post">
            <div class="form-row">
                <div class="form-column">
                    <div class="form-section">
                        <h3>Personal Details</h3>
                        <div class="form-group">
                            <label for="firstName">First Name<span class="star">*</span></label>
                            <input type="text" id="firstName" name="firstName">
                            <span class="error-message" id="fNameError">Please enter FirstName.</span>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name<span class="star">*</span></label>
                            <input type="text" id="lastName" name="lastName">
                            <span class="error-message" id="lNameError">Please enter LastName.</span>
                        </div>
                        <div class="form-group">
                            <label for="dob">Date of Birth<span class="star">*</span></label>
                            <input type="text" id="dob" name="dob" placeholder="yyyy-mm-dd">
                            <span class="error-message" id="dobError">Please select DateOfBirth.</span>
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender<span class="star">*</span></label>
                            <select id="gender" name="gender">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Others">Others</option>
                            </select>
                            <span class="error-message" id="genderError">Please select Gender.</span>
                        </div>
                        <div class="form-group">
                            <label for="ms">Marital Status<span class="star">*</span></label>
                            <select id="ms" name="ms">
                                <option value="">Select Marital Status</option>
                                <option value="Single">Single</option>
                                <option value="Married">Married</option>
                            </select>
                            <span class="error-message" id="msError">Please select MaritalStatus.</span>
                        </div>
                        <div class="form-group">
                            <label for="bg">Blood Group<span class="star">*</span></label>
                            <select id="bg" name="bg">
                                <option value="">Select Blood Group</option>
                                <option value="A Positive">A Positive</option>
                                <option value="A Negative">A Negative</option>
                                <option value="B Positive">B Positive</option>
                                <option value="B Negative">B Negative</option>
                                <option value="O Positive">O Positive</option>
                                <option value="O Negative">O Negative</option>
                                <option value="AB Positive">AB Positive</option>
                                <option value="AB Negative">AB Negative</option>
                            </select>
                            <span class="error-message" id="bgError">Please select BloodGroup.</span>
                        </div>
                    </div>
                </div>

                <div class="form-column">
                    <div class="form-section">
                        <h3>Contact Details</h3>
                        <div class="form-group">
                            <label for="phone">Personal Contact Number<span class="star">*</span></label>
                            <input type="text" id="phone" name="phone">
                            <span class="error-message" id="phoneError">Please enter PhoneNumber.</span>
                        </div>
                        <div class="form-group">
                            <label for="email">Personal Email<span class="star">*</span></label>
                            <input type="email" id="email" name="email">
                            <span class="error-message" id="emailError">Please enter Valid Email.</span>
                        </div>
                        <div class="form-group">
                            <label for="ecn">Emergency Contact Name</label>
                            <input type="text" id="ecn" name="ecn">
                        </div>
                        <div class="form-group">
                            <label for="ec">Emergency Contact Number</label>
                            <input type="text" id="ec" name="ec">
                        </div>
                        <div class="form-group">
                            <label for="address">Permanent Address<span class="star">*</span></label>
                            <textarea id="address" name="address"></textarea>
                            <span class="error-message" id="addressError">Please enter Valid Address.</span>
                        </div>
                        <div class="form-group">
                            <label for="tempadd">Temporary Address</label>
                            <input type="text" id="tempadd" name="tempadd">
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-column">
                    <div class="form-section">
                        <h3>Employee Details</h3>
                        <div class="form-group">
                            <label for="hireDate">Hire Date<span class="star">*</span></label>
                            <input type="text" id="hireDate" name="hireDate" placeholder="yyyy-mm-dd">
                            <span class="error-message" id="hireDateError">Please select hireDate.</span>
                        </div>
                        <div class="form-group">
                            <label for="role">Role<span class="star">*</span></label>
                            <select id="role" name="role">
                                <option value="">Select Role</option>
                                <% for(Roles r : list) { %>
                                    <option value="<%= r.getRoleId() %>"><%= r.getRoleName() %></option>
                                <% } %>
                            </select>
                            <span class="error-message" id="roleError">Please select Role.</span>
                        </div>
                    </div>
                </div>

                <div class="form-column">
                    <div class="form-section">
                        <h3>Employee Credentials</h3>
                        <div class="form-group">
                            <label for="username">Username<span class="star">*</span></label>
                            <input type="text" id="username" name="username">
                            <span class="error-message" id="unameError">Please enter userName.</span>
                        </div>
                        <div class="form-group">
                            <label for="password">Password<span class="star">*</span></label>
                            <input type="password" id="password" name="password">
                            <span class="error-message" id="pwdError">Please enter Password.</span>
                        </div>
                    </div>
                </div>
            </div>

            <center><input type="submit" value="Save"></center>
        </form>

        <script>
            document.addEventListener("DOMContentLoaded", function() {
                document.getElementById("empForm").addEventListener("submit", function(event) {
                    let isValid = true;

                    const fields = [
                        { id: "firstName", errorId: "fNameError", message: "Please enter FirstName." },
                        { id: "lastName", errorId: "lNameError", message: "Please enter LastName." },
                        { id: "dob", errorId: "dobError", message: "Please select DateOfBirth." },
                        { id: "gender", errorId: "genderError", message: "Please select Gender." },
                        { id: "ms", errorId: "msError", message: "Please select MaritalStatus." },
                        { id: "bg", errorId: "bgError", message: "Please select BloodGroup." },
                        { id: "phone", errorId: "phoneError", message: "Please enter PhoneNumber." },
                        { id: "email", errorId: "emailError", message: "Please enter Valid Email." },
                        { id: "address", errorId: "addressError", message: "Please enter Valid Address." },
                        { id: "hireDate", errorId: "hireDateError", message: "Please select hireDate." },
                        { id: "role", errorId: "roleError", message: "Please select Role." },
                        { id: "username", errorId: "unameError", message: "Please enter userName." },
                        { id: "password", errorId: "pwdError", message: "Please enter Password." }
                    ];

                    fields.forEach(function(field) {
                        const input = document.getElementById(field.id);
                        const error = document.getElementById(field.errorId);
                        if (!input.value) {
                            error.style.display = "block";
                            isValid = false;
                        } else {
                            error.style.display = "none";
                        }
                    });

                    if (!isValid) {
                        event.preventDefault();
                    }
                });
            });
        </script>
    </div>
</body>
</html>
