package com.empmngt.servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.enities.User_credentials;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/AddEmployeeServlet")
public class AddEmpServlet extends HttpServlet{

	InputStream ns = null;
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String fname= req.getParameter("firstName");
		String lname = req.getParameter("lastName");
		String dob = req.getParameter("dob");
		String email = req.getParameter("email");
		String phoneNo = req.getParameter("phone");
		String address = req.getParameter("address");
		String hireDate = req.getParameter("hireDate");
		int role = Integer.parseInt(req.getParameter("role"));
		System.out.println(role);
		String uname = req.getParameter("username");
		String pwd = req.getParameter("password");
		String tempadd = req.getParameter("tempadd");
		String ms = req.getParameter("ms");
		String gender = req.getParameter("gender");
		String ec = req.getParameter("ec");
		String ecn = req.getParameter("ecn");
		String bg = req.getParameter("bg");
//		Blob pic =(Blob) req.getPart("picture");
		
		
		Employees e=new Employees();
		e.setFname(fname);
		e.setLname(lname);
		e.setDOB(dob);
		e.setEmail(email);
		e.setPhoneNo(phoneNo);
		e.setAddress(address);
		e.setHiredate(hireDate);
		e.setRoleId(role);
		e.setTempAddress(tempadd);
		e.setMaritalStatus(ms);
		e.setGender(gender);
		e.setEmergencyContact(ec);
		e.setEmergencyContactName(ecn);
		e.setBloodgroup(bg);
		
		System.out.println(e+"\n");
		
		User_credentials uc=new User_credentials();
		uc.setUsername(uname);
		
		//ECRYPTION
		String hashPwd = BCrypt.hashpw(pwd, BCrypt.gensalt());

		uc.setPassword(hashPwd);
		System.out.println(uc);
		
		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            String qry="Select username from user_credentials where BINARY username=?";
            PreparedStatement ps=con.prepareStatement(qry);
            ps.setString(1,uc.getUsername());
            ResultSet rs=ps.executeQuery();
            if(!rs.next())
            {
            boolean f=eDao.addEmp(e,uc);
            
            	if(f) 
            	{
            		req.setAttribute("msg", "Employee Added");
            		req.getRequestDispatcher("addEmp.jsp").forward(req, resp);
            	}
            	else
            	{
            		req.setAttribute("msg", "Employee not added - Ensure the details entered are correct");
            		req.getRequestDispatcher("addEmp.jsp").forward(req, resp);
            	}
            }
            else
            {
            	req.setAttribute("msg", "Username Already exists");
            	req.getRequestDispatcher("addEmp.jsp").forward(req, resp);
            }
  
            
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}

		
	}



}
