package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Holidays;
import com.empmngt.jdbc.DBConnect;

//@SuppressWarnings("serial")
@WebServlet("/AddHolidayServlet")
public class AddHolidayServlet extends HttpServlet {

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
try (Connection con = DBConnect.getConnection()) {
	 EmpDao eDao = new EmpDao(con);
	 String date = req.getParameter("date");
	 String holidayName = req.getParameter("holidayName");
	 
	 Holidays h = new Holidays();
	 
	 h.setDate(date);
	 h.setHolidayname(holidayName);
	 
	 boolean f = eDao.addHolidays(h);
	 if(f)
	 {
		 System.out.println("data inserted");
	 }else
	 {
		 System.out.println("Not inserted");
	 }
			
			
            req.getRequestDispatcher("AddHolidays.jsp").forward(req, resp);
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}
	}

}
