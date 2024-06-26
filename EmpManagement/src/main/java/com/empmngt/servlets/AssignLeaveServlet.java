package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.empmngt.dao.EmpDao;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/addlev")
public class AssignLeaveServlet extends HttpServlet{

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int n = Integer.parseInt(req.getParameter("addl"));
//		int n=2;
		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            eDao.addLeavesStock(n);
            req.getRequestDispatcher("empDetails.jsp").forward(req, resp);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

}
