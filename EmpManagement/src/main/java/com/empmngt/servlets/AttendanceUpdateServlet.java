package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.empmngt.dao.EmpDao;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/AttendanceUpdate")
public class AttendanceUpdateServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int ID = Integer.parseInt(request.getParameter("id"));
        String date = request.getParameter("Date");
        String ChIn = request.getParameter("CIT");
        String ChO = request.getParameter("COT");

        Connection con = null;
        String msg="";
        try {
			con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			
			msg=empDao.UpdateAttendance(ID,date,ChIn,ChO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
        request.setAttribute("message", msg);
        request.getRequestDispatcher("AttendanceUpdateRequest.jsp").forward(request, response);
        
	}

}
