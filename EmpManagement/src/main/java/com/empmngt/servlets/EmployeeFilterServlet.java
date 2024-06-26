package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/EmployeeFilterServlet")
public class EmployeeFilterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roleidStr = request.getParameter("role");
        String name = request.getParameter("name");
        System.out.println(" roleID : "+roleidStr);
        Connection con=null;
		try {
			con = DBConnect.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        EmpDao empDao = new EmpDao(con);

        List<Employees> employeesList=null;
        
        try {
            if ((roleidStr == null || roleidStr.isEmpty()) && (name == null || name.isEmpty())) {
                // Initially display all employees
                employeesList = empDao.getAllEmployees();
            } else if (roleidStr != null && !roleidStr.isEmpty() && (name == null || name.isEmpty())) {
                // Filter by role only
                int roleId = Integer.parseInt(roleidStr);
                employeesList = empDao.getEmployeesByRole(roleId);
            } else if (roleidStr != null && !roleidStr.isEmpty() && name != null && !name.isEmpty()) {
                // Filter by both role and name
                int roleId = Integer.parseInt(roleidStr);
                employeesList = empDao.getEmployeesByRoleAndName(roleId, name);
            } else if ((roleidStr == null || roleidStr.isEmpty()) && name != null && !name.isEmpty()) {
                // Filter by name only
                employeesList = empDao.getEmployeesByName(name);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        

//        request.setAttribute("roleid", roleid);
//        System.out.println(employeesList);
        request.setAttribute("empList", employeesList);
        request.getRequestDispatcher("empDetails.jsp").forward(request, response);
    }
}
