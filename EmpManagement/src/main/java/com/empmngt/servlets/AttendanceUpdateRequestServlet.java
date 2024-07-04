package com.empmngt.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
import com.empmngt.enities.Attendance;
import com.empmngt.enities.EmailDetails;
import com.empmngt.enities.Employees;
import com.empmngt.enities.Leaves;
import com.empmngt.jdbc.DBConnect;

@WebServlet("/requestUpdate")
public class AttendanceUpdateRequestServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int ID = Integer.parseInt(request.getParameter("attenId"));
        System.out.println("attendId"+ID);
        String date = request.getParameter("date");
        String ChIn = request.getParameter("cit");
        String ChO = request.getParameter("cot");
        String name=request.getParameter("empName");

        Connection con = null;
        HttpSession ses= request.getSession();
        Employees emp=(Employees)ses.getAttribute("employee");
        String msg="";
        try {
			con = DBConnect.getConnection();
			EmpDao empDao = new EmpDao(con);
			EmailDetails em = empDao.getEmails(emp.getEmpId());
			
			msg=empDao.UpdateAttendanceTable(ID,name,date,ChIn,ChO,emp.getEmpId());
			Attendance att = empDao.GetAttendanceUpdateForEmail(ID);
			sendEmail("ananthtd234@gmail.com","mrrookie1221@gmail.com","ananthtd234@gmail.com",att,em);
//			System.out.println("Attendance obj after request update : "+att);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        request.setAttribute("message", msg);
        request.getRequestDispatcher("attendance.jsp").forward(request, response);
        
	}
	
	public static void sendEmail(String from, String hr, String mgr, Attendance att,EmailDetails em) throws MessagingException {
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
	        message.setSubject("AttendanceUpdate Request");

	        // Create the verification link
	        String verificationLink = "http://localhost:8080/EmpManagement/login.jsp";

	        // Set the actual message
	        String htmlContent = "<p>Employee " + em.getUsername() + " is requesting for attendance update..</p>"
	                           + "<p>Attendance Date: "+ att.getDate() + "</p>"
	                           + "<p>Old CheckIn Time: "+ att.getCheckin() + " </p>"
	                           + "<p>Old CheckOut Time: "+ att.getCheckout() + " </p>"
	                           + "<p>New CheckIn Time: "+ att.getNewcheckin() + "</p>"
	                           + "<p>New CheckOut Time: "+ att.getNewcheckout() + " </p>"
	                           + "<p>Click the link below to approve request:</p>"
	                           + "<a href=\"" + verificationLink + "\">Login to Manage Attendance Requests</a>";

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
