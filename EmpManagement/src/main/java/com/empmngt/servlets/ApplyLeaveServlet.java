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
import com.empmngt.enities.Leaves;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/ApplyLeaveServlet")
public class ApplyLeaveServlet extends HttpServlet {

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		String fromDate = req.getParameter("fromDate");
		String toDate = req.getParameter("toDate");
		String leaveType = req.getParameter("leaveType");
		String reason = req.getParameter("reason");
		String date="";
		String origin= req.getParameter("origin");
		
		
		
		 int id = -1;
	        try {
	            id = Integer.parseInt(req.getParameter("id"));
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        }
		
		try (Connection con = DBConnect.getConnection()) {
			
			Leaves lev = new Leaves();
			
			
            EmpDao eDao = new EmpDao(con);
            String str[] = (String[])eDao.getCurrDateTime().split(" ");
            date = str[0];
            
            lev.setEmployeeID(id);
			lev.setFromDate(fromDate);
			lev.setToDate(toDate);
			lev.setLeaveType(leaveType);
			lev.setAppliedReason(reason);
			lev.setLeaveStatus("pending");
			lev.setAppliedDate(date);
			
			
			int n= eDao.availDays(id);
			System.out.println(n);
			int days = eDao.validateLeave(fromDate,toDate);
			System.out.println("NO of Days : "+days);
			
			if(days==0)
			{
				System.out.println("The applied date is a holiday!!!");
				req.setAttribute("message","The applied date is a holiday!!!");
				if ("leave".equals(origin)) {
		            req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
		        } else {
		            req.getRequestDispatcher("ReporteeLeave.jsp").forward(req, resp);
		        }
			}
			
			else if(days<=n)
			{
				lev.setTotalDays(days);
				//boolean res = eDao.applyLeave(lev);
				if(eDao.applyLeave(lev)) {
//				resp.sendRedirect("leaveReq.jsp?message=Leave applied");
					System.out.println("Leave applied");
				req.setAttribute("message"," Leave applied successfully");
				 if ("leave".equals(origin)) {
			            req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
			        } else {
			            req.getRequestDispatcher("ReporteeLeave.jsp").forward(req, resp);
			        }
					
				}
			}else
			{
				System.out.println("You don't have enough leaves!!!");
				req.setAttribute("message","You don't have enough leaves!!!");
				if ("leave".equals(origin)) {
		            req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
		        } else {
		            req.getRequestDispatcher("ReporteeLeave.jsp").forward(req, resp);
		        }
			}
			
		
	       
			
			
//            req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}
	}

}
