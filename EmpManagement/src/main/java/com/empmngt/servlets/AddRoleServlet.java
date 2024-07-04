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

@WebServlet("/AddRoleServlet")
public class AddRoleServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String roleName = req.getParameter("newRole");
		try (Connection con = DBConnect.getConnection()) {

			EmpDao eDao = new EmpDao(con);
			String msg = eDao.insertRole(roleName);
			if(!msg.isEmpty())
			{
				req.setAttribute("msg", msg);
				req.getRequestDispatcher("addEmp.jsp").forward(req, resp);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
