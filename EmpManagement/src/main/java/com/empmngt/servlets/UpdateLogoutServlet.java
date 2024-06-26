package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;


@WebServlet("/updateLogout")
public class UpdateLogoutServlet extends HttpServlet{

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		Employees emp = (Employees) session.getAttribute("employee");

		if (emp != null) {
		    int eid = emp.getEmpId();
		    try (Connection con = DBConnect.getConnection()) {
		        EmpDao eDao = new EmpDao(con);
		        String msg = eDao.getLogout(eid);
		        req.setAttribute("msg", msg);
		        req.getRequestDispatcher("attendance.jsp").forward(req, resp);
		    } catch(Exception e) {
		        e.printStackTrace();
		        System.out.println("Error");
		    }
		} else {
		    // Handle case where employee is not in session
		    req.setAttribute("msg", "Employee not found in session.");
		    req.getRequestDispatcher("attendance.jsp").forward(req, resp);
		}

	}
}
