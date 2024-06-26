package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");
		
		HttpSession ses = req.getSession();
		Employees emp = (Employees)ses.getAttribute("employee");		
		
		if(newPassword.equals(confirmPassword))
		{
			String hashPwd = BCrypt.hashpw(confirmPassword, BCrypt.gensalt());
		
		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            eDao.updatePwd(emp.getEmpId(), hashPwd);
            resp.sendRedirect("login.jsp?message=password changed successfully");
            
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}
	
		}else
		{
            resp.sendRedirect("change_password.jsp?message=password doesn't match!!");

		}
	
	}
}


