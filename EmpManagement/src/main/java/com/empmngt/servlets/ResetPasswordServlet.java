package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.empmngt.dao.EmpDao;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        //System.out.println("new : "+newPassword+" confirm : "+confirmPassword);
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Database connection
        if(newPassword.equals(confirmPassword))
		{
			String hashPwd = BCrypt.hashpw(confirmPassword, BCrypt.gensalt());
		
			 try (Connection con = DBConnect.getConnection()) {
	          	 EmpDao eDao = new EmpDao(con);
	          	 
	          	 boolean f = eDao.changePassword(hashPwd,username);
	          	 if(f)System.out.println("Method success");
	          	 else System.out.println("method failed!!!");
	          	 request.setAttribute("msg","Password Updated successfully!!!");
	          	 request.getRequestDispatcher("login.jsp").forward(request, response);
//	            response.sendRedirect("login.jsp?message=Password reset successful");
	        } catch (Exception e) {
	            e.printStackTrace();
	         	 request.setAttribute("msg","An error occurred. Please try again...!!!");
	          	 request.getRequestDispatcher("resetpwd.jsp").forward(request, response);
//	            response.sendRedirect("resetpwd.jsp?message=An error occurred. Please try again.");
	        }
	
		}else
		{
			request.setAttribute("msg", "password doesn't match!!");
			request.getRequestDispatcher("resetpwd.jsp").forward(request, response);
//            response.sendRedirect("resetpwd.jsp?message=");

		}
        
        
        
        
        
       
    }
}

