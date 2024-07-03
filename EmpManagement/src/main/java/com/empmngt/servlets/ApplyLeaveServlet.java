package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.EmailDetails;
import com.empmngt.enities.Leaves;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/ApplyLeaveServlet")
public class ApplyLeaveServlet extends HttpServlet {


	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


		String fromDate = req.getParameter("fromDate");
		String toDate = req.getParameter("toDate");
		String leaveType = req.getParameter("leaveType");
		String reason = req.getParameter("reason");
		String date="";
		String origin= req.getParameter("origin");

		HttpSession ses = req.getSession();
		String uname= (String) ses.getAttribute("username");

		int id = -1;
		try {
			id = Integer.parseInt(req.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		try (Connection con = DBConnect.getConnection()) {

			Leaves lev = new Leaves();


			EmpDao eDao = new EmpDao(con);
			String str[] = (String[])eDao.getCurrDateTime().split(" ");
			date = str[0];

			lev.setEmployeeID(id);
			lev.setFromDate(fromDate);
			lev.setToDate(toDate);
			lev.setLeaveType(leaveType);
			lev.setAppliedReason(reason);
			lev.setLeaveStatus("Pending");
			lev.setAppliedDate(date);


			int n= eDao.availDays(id);
			System.out.println(n);
			int days = eDao.validateLeave(fromDate,toDate);
			//System.out.println("NO of Days : "+days);

			if(days==0)
			{
				//System.out.println("The applied date is a holiday!!!");
				req.setAttribute("message","The applied date is a holiday!!!");
				if ("leave".equals(origin)) {
					req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
				} else {
					req.getRequestDispatcher("ReporteeLeave.jsp").forward(req, resp);
				}
			}

			else if(days<=n)
			{
				lev.setTotalDays(days);
				int leaveid=eDao.applyLeave(lev);
				if(leaveid!=0) {	
					eDao.updateLeavestock(leaveid);
					EmailDetails em = eDao.getEmails(id);

				    Leaves lastLeave = eDao.getLastLeaveRecord(id);
				    if (lastLeave != null) {
				        sendEmail("kananth494@gmail.com",em.getHrEmail(),em.getManagerEmail(), uname, lastLeave);
				    } 
					req.setAttribute("message"," Leave applied successfully");
					if ("leave".equals(origin)) {
						req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
					} else {
						req.getRequestDispatcher("ReporteeLeave.jsp").forward(req, resp);
					}

				}
			}else
			{
				//System.out.println("You don't have enough leaves!!!");
				req.setAttribute("message","You don't have enough leaves!!!");
				if ("leave".equals(origin)) {
					req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
				} else {
					req.getRequestDispatcher("ReporteeLeave.jsp").forward(req, resp);
				}
			}





			//            req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
		}catch(Exception e1)
		{
			e1.printStackTrace();
		}
	}
	
	
	
	public static void sendEmail(String from, String hr, String mgr, String uname, Leaves leave) throws MessagingException {
	    final String username = "kananth494@gmail.com";
	    final String password = "bwcu ypxs axgs fmcb"; // Use an App Password if less secure apps are disabled

	    // SMTP server information
	    String host = "smtp.gmail.com";
	    Properties properties = new Properties();
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.smtp.host", host);
	    properties.put("mail.smtp.port", "587");

	    // Get the Session object
	    Session session = Session.getInstance(properties, new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(username, password);
	        }
	    });

	    try {
	        // Create a default MimeMessage object
	        Message message = new MimeMessage(session);

	        // Set From: header field
	        message.setFrom(new InternetAddress(from));

	        // Set To: header field (including both HR and Manager emails)
	        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(hr + "," + mgr));

	        // Set Subject: header field
	        message.setSubject("Leave Request");

	        // Create the verification link
	        String verificationLink = "http://localhost:8080/EmpManagement/login.jsp";

	        // Set the actual message
	        String htmlContent = "<p>Employee " + uname + " has applied for leave.</p>"
	                           + "<p>Leave Details:</p>"
	                           + "<p>Start Date: " + leave.getFromDate() + "</p>"
	                           + "<p>End Date: " + leave.getToDate() + "</p>"
	                           + "<p>Reason: " + leave.getAppliedReason() + "</p>"
	                           + "<p>Click the link below to approve or reject the leave request:</p>"
	                           + "<a href=\"" + verificationLink + "\">Login to Manage Leave Requests</a>";

	        message.setContent(htmlContent, "text/html");

	        // Send the message
	        Transport.send(message);

	        System.out.println("Email sent successfully to HR and Manager.");

	    } catch (MessagingException e) {
	        e.printStackTrace();
	        throw new RuntimeException(e);
	    }
	}


}
