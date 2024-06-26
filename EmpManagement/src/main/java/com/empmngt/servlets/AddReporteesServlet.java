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

@WebServlet("/AddReportees")
public class AddReporteesServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int managerId = 0;
        int empId = 0;

        try {
            managerId = Integer.parseInt(req.getParameter("id"));
            empId = Integer.parseInt(req.getParameter("emp"));
        } catch (Exception e) {
            System.out.println(e);
        }
        
        try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            String msg = eDao.AddReportees(managerId, empId);
            req.setAttribute("msg", msg != null ? msg : "Something went wrong");
            req.getRequestDispatcher("Managers.jsp?id=" + managerId + "&role=Manager").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}