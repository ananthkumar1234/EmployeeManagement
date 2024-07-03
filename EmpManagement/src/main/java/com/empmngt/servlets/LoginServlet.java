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
import com.empmngt.enities.EmployeeAttachment;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uname = req.getParameter("username");
        String pwd = req.getParameter("password");

        try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            String info = eDao.validateLogin(uname, pwd);

            Employees emp = eDao.getEmpData(uname);

            EmployeeAttachment ea = new EmployeeAttachment();
            HttpSession session = req.getSession();
            session.setAttribute("username", uname);
            session.setAttribute("role", info);

            if (info.equals("HR")) {
                session.setAttribute("employee", emp);
                req.getRequestDispatcher("HRhome.jsp").forward(req, resp);
            } else if (info.equals("Manager")) {
                session.setAttribute("employee", emp);
                req.getRequestDispatcher("EmpHome.jsp").forward(req, resp);
            } else if (info.equals("error")) {
                resp.sendRedirect("login.jsp?message=Invalid username or password");
            } else {
                session.setAttribute("employee", emp);
                req.getRequestDispatcher("EmpHome.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?message=An error occurred, please try again.");
        }
    }
}
