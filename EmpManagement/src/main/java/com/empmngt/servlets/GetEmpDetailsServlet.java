package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/view")
public class GetEmpDetailsServlet extends HttpServlet{

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            List<Employees> list = eDao.getAllEmployees();
            
            System.out.println(list);
            req.setAttribute("list", list);
            req.getRequestDispatcher("empDetails.jsp").forward(req, resp);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	
}
