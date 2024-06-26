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

@WebServlet("/cancel")
public class DeleteLeaveRecordServlet extends HttpServlet{

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	int id = Integer.parseInt(req.getParameter("id"));
	
	try (Connection con = DBConnect.getConnection()) {
		EmpDao empDao = new EmpDao(con);
		empDao.deleteLeaveRecord(id);
		req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
	}catch(Exception e)
	{
		
	}
	}

}
