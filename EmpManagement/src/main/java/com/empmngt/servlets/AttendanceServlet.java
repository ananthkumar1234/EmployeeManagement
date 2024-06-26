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

@WebServlet("/insertLogin")
public class AttendanceServlet extends HttpServlet{


	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


		//String yes = req.getParameter("yes");
		//String no = req.getParameter("no");


		HttpSession session = req.getSession();
		Employees emp = (Employees) session.getAttribute("employee");
		//		int id = emp.getEmpId();

		if (emp != null) {
			int eid = emp.getEmpId();
			try (Connection con = DBConnect.getConnection()) {
				EmpDao eDao = new EmpDao(con);
				if(eDao.getLogin(eid))
				{
					if(eDao.validateAttendance(eid))
					{
						System.out.println("You are on leave");
						req.setAttribute("msg","You are on leave");
						req.getRequestDispatcher("attendance.jsp").forward(req, resp);
					}else
					{
						if(eDao.validateAttendanceHoliday())
						{
							System.out.println("In Holiday Validation true");
							eDao.insertLogin(eid);
							req.setAttribute("msg","Logged in !!!");
							req.getRequestDispatcher("attendance.jsp").forward(req, resp);
						}
						else
						{
							System.out.println("In Holiday Validation false");
							req.setAttribute("flag", true);
							req.setAttribute("msg","Today it's not working day(Holiday!)");
							req.getRequestDispatcher("attendance.jsp").forward(req, resp);
						}

					}

				}else
				{
					req.setAttribute("msg","Already Logged in!!!");
					req.getRequestDispatcher("attendance.jsp").forward(req, resp);
				}


			}
			catch(Exception e) {
				e.printStackTrace();
				System.out.println("Error");
			}
		}



	}
}


