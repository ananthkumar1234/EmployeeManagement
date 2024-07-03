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

@WebServlet("/updaterejectreason")
public class UpdateRejectReasonServlet extends HttpServlet {


	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session= req.getSession();
		 String uname = (String)session.getAttribute("username");
		String rs=req.getParameter("rejectreason");
		String status="Approved";
		System.out.println(req.getParameter("rejectreason"));
		if(rs!= null && !rs.isEmpty())
		{
			rs=req.getParameter("rejectreason");
			status="Rejected";
		}

		int eid = Integer.parseInt(req.getParameter("eid"));
		//System.out.println("Approvedby "+eid);
		int leaveid=0;
		try {
			leaveid = Integer.parseInt(req.getParameter("leaveid"));
		}catch(NumberFormatException ne)
		{
			System.out.println(ne);
		}
		System.out.println("LeaveId "+leaveid);
		try (Connection con = DBConnect.getConnection()) {
			EmpDao eDao = new EmpDao(con);
			Employees em = eDao.getEmpData(uname);
			eDao.updaterejectreason(rs, eid,leaveid,status);
			eDao.updateLeavestock(leaveid);

			if(session.getAttribute("role").equals("HR")) {
				int n = eDao.getPendingLeavesCount();
				//System.out.println("Count of Reocrds: "+n);
				session.setAttribute("count", n);

				req.getRequestDispatcher("Leaves.jsp").forward(req, resp);
			}
			else if(session.getAttribute("role").equals("Manager")) 
			{
				int n = eDao.getPendingLeavesForMgrCount(em.getEmpId());
				//System.out.println("Count of Reocrds: "+n);
				session.setAttribute("count", n);

				req.getRequestDispatcher("Leaves.jsp").forward(req, resp);
			}


		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}


}
