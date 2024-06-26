package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Leaves;
import com.empmngt.jdbc.DBConnect;


@WebServlet("/filterLeave")
public class FilterLeaveServlet extends HttpServlet{

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String year = req.getParameter("year");
        String month = req.getParameter("month");
        
        int id = -1;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        
        Connection con = null;
        List<Leaves> filteredAttendance = null;

        try {
            con = DBConnect.getConnection();
            EmpDao empDao = new EmpDao(con);

           if (year != null && !year.isEmpty() && month != null && !month.isEmpty()) {
                filteredAttendance = empDao.getLeaveByYearMonth(id, year, month);
            } else if (year != null && !year.isEmpty()) {
                filteredAttendance = empDao.getLeaveByYear(id, year);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        req.setAttribute("filteredAttendance", filteredAttendance);
        req.getRequestDispatcher("EmpLeaves.jsp").forward(req, resp);
    }



	}


