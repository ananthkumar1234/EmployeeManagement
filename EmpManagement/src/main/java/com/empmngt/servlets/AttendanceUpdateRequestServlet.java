package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/requestUpdate")
public class AttendanceUpdateRequestServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int ID = Integer.parseInt(request.getParameter("attenId"));
        System.out.println("attendId"+ID);
        String date = request.getParameter("date");
        String ChIn = request.getParameter("cit");
        String ChO = request.getParameter("cot");
        String name=request.getParameter("empName");

        Connection con = null;
        HttpSession ses= request.getSession();
        Employees emp=(Employees)ses.getAttribute("employee");
        String msg="";
        try {
			con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			msg=empDao.UpdateAttendanceTable(ID,name,date,ChIn,ChO,emp.getEmpId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
        request.setAttribute("message", msg);
        request.getRequestDispatcher("attendance.jsp").forward(request, response);
        
	}

}
