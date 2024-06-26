package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.Employees;
import com.empmngt.jdbc.DBConnect;


@WebServlet("/updateEmployee")
public class UpdateEmpServlet extends HttpServlet {

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int id= Integer.parseInt(req.getParameter("id"));
//		System.out.println("emp id : "+id);
		String fname= req.getParameter("firstName");
		String lname = req.getParameter("lastName");
		String dob = req.getParameter("dob");
		String email = req.getParameter("email");
		String phoneNo = req.getParameter("phone");
		String address = req.getParameter("address");
		String hireDate = req.getParameter("hireDate");
		int role = Integer.parseInt(req.getParameter("role"));
		String tempadd = req.getParameter("tempadd");
		String ms = req.getParameter("ms");
		String gender = req.getParameter("gender");
		String ec = req.getParameter("ec");
		String ecn = req.getParameter("ecn");
		String bg = req.getParameter("bg");
		
		
		Employees e=new Employees();
		e.setEmpId(id);
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
		
		
		try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);
            
            eDao.updateEmp(e);
//            req.getRequestDispatcher("empDetails.jsp").forward(req, resp);
            resp.sendRedirect("empDetails.jsp");
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}
	}
	

}
