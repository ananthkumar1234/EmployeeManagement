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

import com.empmngt.dao.EmpDao;
import com.empmngt.enities.EmailDetails;
import com.empmngt.enities.Leaves;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/cancel")
public class DeleteLeaveRecordServlet extends HttpServlet{

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    int id = Integer.parseInt(req.getParameter("id"));
	    int eid = Integer.parseInt(req.getParameter("eid"));
	    System.out.println("leaveid : " + id + " and empid : " + eid);

	    try (Connection con = DBConnect.getConnection()) {
	        EmpDao empDao = new EmpDao(con);
	        EmailDetails em = empDao.getEmails(eid);
	        Leaves lev = empDao.getLeaveRecordById(id);
	        empDao.deleteLeaveRecord(id);
	        System.out.println("record deleted");
	        
	        // Make sure sendEmail method is defined to handle these parameters
	        sendEmail("kananth494@gmail.com", em.getManagerEmail(), em.getHrEmail(), lev);
	        System.out.println("sendmail method completed");

	        req.setAttribute("message", "Leave record deleted and email sent successfully.");
	        req.getRequestDispatcher("leaveReq.jsp").forward(req, resp);
	    } catch (Exception e) {
	        e.printStackTrace();
	        req.setAttribute("error", "An error occurred while processing the request: " + e.getMessage());
	        req.getRequestDispatcher("error.jsp").forward(req, resp);
	    }
	}

	
	
	
	public static void sendEmail(String from, String hr, String mgr,Leaves lev) throws MessagingException {
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
	        message.setSubject("Leave Request Cancel");

	        // Create the verification link
//	        String verificationLink = "http://localhost:8080/EmpManagement/login.jsp";

	        // Set the actual message
	        String htmlContent = "<p>" + lev.getFname() + " has cancelled leave request...</p>"
	                           + "<p>From Date: "+ lev.getFromDate() + "</p>"
	                           + "<p>To Date: "+ lev.getToDate() + " </p>";

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
