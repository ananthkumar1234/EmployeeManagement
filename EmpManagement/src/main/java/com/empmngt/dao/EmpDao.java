package com.empmngt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import com.empmngt.enities.AddHoliday;
import com.empmngt.enities.Attendance;
import com.empmngt.enities.Employees;
import com.empmngt.enities.Holidays;
import com.empmngt.enities.Leaves;
import com.empmngt.enities.Roles;
import com.empmngt.enities.User_credentials;


public class EmpDao {

	private Connection con;

	public EmpDao(Connection con) {
		this.con = con;
	}


	public String validateLogin(String uname,String pwd)throws SQLException
	{
		String query = "SELECT u.EmployeeID, u.Password, e.RoleID, r.RoleName FROM User_credentials u JOIN Employees e ON u.EmployeeID = e.EmployeeID JOIN Roles r ON e.RoleID = r.RoleID WHERE u.Username = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, uname);

		try {
			ResultSet rs = ps.executeQuery();
			rs.next();

			String pswd= rs.getString("password");
			String role = rs.getString("RoleName"); 
			//	         int id = rs.getInt("EmployeeID");

			if(BCrypt.checkpw(pwd, pswd)) {
				return role;
			}


		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return  "error";
	}


	public List<Roles> getRoles() throws Exception
	{
		List<Roles> list = new ArrayList<>();
		String qry = "select * from roles";
		PreparedStatement ps = con.prepareStatement(qry);
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			Roles r=new Roles();
			r.setRoleId(rs.getInt("RoleId"));
			r.setRoleName(rs.getString("RoleName"));
			list.add(r);
		}

		return list;
	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Add employee details
	public void addEmp(Employees emp,User_credentials uc)
	{
		try {
			String qry="insert into employees(FirstName,LastName,DateOfBirth,Email,Phone,Address,HireDate,RoleID,tempAddres,maritalstatus,gender,emergencyPhoneNo,emergencyContactpersonName,bloodGroup) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(qry);

			ps.setString(1,emp.getFname());
			ps.setString(2,emp.getLname());
			ps.setString(3, emp.getDOB());
			ps.setString(4,emp.getEmail());
			ps.setString(5, emp.getPhoneNo());
			ps.setString(6, emp.getAddress());
			ps.setString(7, emp.getHiredate());
			ps.setInt(8, emp.getRoleId());
			ps.setString(9, emp.getTempAddress());
			ps.setString(10, emp.getMaritalStatus());
			ps.setString(11, emp.getGender());
			ps.setString(12, emp.getEmergencyContact());
			ps.setString(13, emp.getEmergencyContactName());
			ps.setString(14, emp.getBloodgroup());

			int i=ps.executeUpdate();
			String qry2="SELECT employeeID FROM employees ORDER BY employeeID DESC LIMIT 1";
			ResultSet rs= con.prepareStatement(qry2).executeQuery();
			//				
			rs.next();
			int id=rs.getInt("employeeID");
			getCredentials(id,uc);

		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}





	public void updateEmp(Employees emp)
	{
		try {

			String qry="update employees set FirstName=?,LastName=?,DateOfBirth=?,Email=?,Phone=?,Address=?,HireDate=?,RoleID=?,tempAddres=?,maritalstatus=?,gender=?,emergencyPhoneNo=?,emergencyContactpersonName=?,bloodGroup=? where employeeid = ?";
			PreparedStatement ps=con.prepareStatement(qry);

			ps.setString(1,emp.getFname());
			ps.setString(2,emp.getLname());
			ps.setString(3, emp.getDOB());
			ps.setString(4,emp.getEmail());
			ps.setString(5, emp.getPhoneNo());
			ps.setString(6, emp.getAddress());
			ps.setString(7, emp.getHiredate());
			ps.setInt(8, emp.getRoleId());
			ps.setString(9, emp.getTempAddress());
			ps.setString(10, emp.getMaritalStatus());
			ps.setString(11, emp.getGender());
			ps.setString(12, emp.getEmergencyContact());
			ps.setString(13, emp.getEmergencyContactName());
			ps.setString(14, emp.getBloodgroup());
			ps.setInt(15, emp.getEmpId());


			int i=ps.executeUpdate();
			//				if(i>0)
			//				{
			//					System.out.println("Data updated");
			//				}else
			//				{
			//					System.out.println("Something gone wrong!!!!");
			//				}


		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}




	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Edit employee details


	public void getCredentials(int id,User_credentials uc)
	{

		try {
			String qry="insert into user_credentials values (?,?,?)";
			String qry1="insert into leavesStock(employeeid) values (?)";
			PreparedStatement ps=con.prepareStatement(qry);
			ps.setInt(1, id);
			ps.setString(2,uc.getUsername());
			ps.setString(3, uc.getPassword());

			int i=ps.executeUpdate();
			
			
			
			PreparedStatement ps1=con.prepareStatement(qry1);
			ps1.setInt(i, id);
			ps1.executeUpdate();

			//				addProfile(id,pic);
			

		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//get employee data based on username

	public Employees getEmpData(String uname) throws SQLException
	{
		Employees e1=new Employees();
		String qry ="select * from Employees where EmployeeID = (select EmployeeID from User_credentials where username =?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, uname);
		try {
			ResultSet rs = ps.executeQuery();
			rs.next();
			e1.setEmpId(rs.getInt("EmployeeID"));
			e1.setFname(rs.getString("FirstName"));
			e1.setLname(rs.getString("LastName"));
			e1.setDOB(rs.getString("DateOfBirth"));
			e1.setEmail(rs.getString("Email"));
			e1.setPhoneNo(rs.getString("Phone"));
			e1.setAddress(rs.getString("Address"));
			e1.setHiredate(rs.getString("Hiredate"));
			e1.setRoleId(rs.getInt("RoleID"));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return e1;
	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//get all employees from employee table

	public List<Employees> getAllEmployees() throws SQLException
	{
		List<Employees> l1 = new ArrayList<>();

		String qry="select EmployeeID,FirstName,LastName from Employees";
		PreparedStatement ps = con.prepareStatement(qry);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Employees e1  = new Employees();
			e1.setEmpId(rs.getInt("EmployeeID"));
			e1.setFname(rs.getString("FirstName"));
			e1.setLname(rs.getString("LastName"));

			l1.add(e1);
		}
		return l1;
	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//get only one employee data based on id

	public Employees GetEmpById(int eid) throws SQLException
	{
		Employees e1 = new Employees();
		Roles role=new Roles();
		String qry="select * from Employees where employeeID = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ResultSet rs = ps.executeQuery();
		rs.next();
		e1.setEmpId(rs.getInt("EmployeeID"));
		e1.setFname(rs.getString("FirstName"));
		e1.setLname(rs.getString("LastName"));
		e1.setDOB(rs.getString("DateOfBirth"));
		e1.setEmail(rs.getString("Email"));
		e1.setPhoneNo(rs.getString("Phone"));
		e1.setAddress(rs.getString("Address"));
		e1.setHiredate(rs.getString("Hiredate"));
		e1.setRoleId(rs.getInt("RoleID"));
		e1.setTempAddress(rs.getString("tempAddres"));
		e1.setMaritalStatus(rs.getString("maritalstatus"));
		e1.setGender(rs.getString("gender"));
		e1.setEmergencyContact(rs.getString("emergencyPhoneNo"));
		e1.setEmergencyContactName(rs.getString("emergencyContactpersonName"));
		e1.setBloodgroup(rs.getString("bloodGroup"));


		return e1;
	}


	//	    public void addProfile(int id,Blob pic) throws SQLException
	//	    {
	//	    	String qry="insert into EmployeeAttachments values (?,?)";
	//	    	PreparedStatement ps=con.prepareStatement(qry);
	//			ps.setInt(1, id);
	//			
	//	    }


	//	    public void getProfile(int eid)
	//	    {
	//	    	EmployeeAttachment ea = new EmployeeAttachment();
	//	    	try {
	//	    		String qry ="select fileType from employeeAttachments where employeeID =?";
	//	    		PreparedStatement ps = con.prepareStatement(qry);
	//	            ResultSet rs = ps.executeQuery();
	//	            rs.next();
	//	            ea.setPic(rs.getBlob("fileType"));
	//	    	}catch(Exception e){
	//	    		e.printStackTrace();
	//	    	}
	//	    }
	//	    

	//	    Date d=new Date();




	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// to get current date and time


	public String getCurrDateTime() {
		// Get current date and time in IST
		ZoneId istZone = ZoneId.of("Asia/Kolkata"); // Replace with "Asia/Calcutta" if needed
		ZonedDateTime nowIST = ZonedDateTime.now(istZone);

		// Format date and time with desired pattern
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss") ;


		String dateTime = nowIST.format(formatter);

		System.out.println("Current date" + dateTime);
		return dateTime;
	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// to insert login details

	public void insertLogin(int eid) throws SQLException
	{
		String str[] = getCurrDateTime().split(" ");
		String qry="insert into Attendance(EmployeeID,Date,CheckInTime)values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1,eid);
		ps.setString(2, str[0]);
		ps.setString(3, str[1]);

		int i = ps.executeUpdate();
		//	    	if(i>0)
		//	    	{
		//	    		return "Logged in successfully"+str[1];
		//	    	}else
		//	    	{
		//	    		System.out.println();
		//	    	}
		//	    	return "error";
	}



	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// to insert logout details

	public void updateLogout(int eid) throws SQLException
	{
		String str[] = getCurrDateTime().split(" ");
		String qry="update attendance set checkouttime=? where employeeid =? and date = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1,str[1]);
		ps.setInt(2, eid);
		ps.setString(3, str[0]);

		int i = ps.executeUpdate();
		//	    	if(i>0)
		//	    	{
		//	    		return "Logged Out successfully"+str[1];
		//	    	}else
		//	    	{
		//	    		System.out.println();
		//	    	}
		//	    	return "error";
	}



	public List<Attendance> getAttRecordById(int eid) throws SQLException
	{
		List<Attendance> list=new ArrayList<>();
		String qry = "SELECT Date, CheckInTime, CheckOutTime,remarks FROM attendance WHERE employeeID = ? AND MONTH(Date) = MONTH(CURRENT_DATE()) AND YEAR(Date) = YEAR(CURRENT_DATE()) ORDER BY AttendanceID DESC";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1,eid);
		ResultSet rs = ps.executeQuery();

		while(rs.next())
		{
			Attendance a = new Attendance();
			a.setDate(rs.getString("Date"));
			a.setCheckin(rs.getString("checkintime"));
			a.setCheckout(rs.getString("checkouttime"));
			a.setRemarks(rs.getString("remarks"));
			list.add(a);
		}
		return list;

	}



	public boolean getLogin(int id) throws SQLException {
		System.out.println("Login Click");
		String str[] = getCurrDateTime().split(" ");
		String qry = "select * from attendance where date = ? and employeeid = ?";
		boolean f=false;
		
		try (PreparedStatement ps = con.prepareStatement(qry)) {
			ps.setString(1, str[0]);
			ps.setInt(2, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next()) {
					f= true;
				}
			}
			if(f)
			{
				System.out.println("Not Logged in Already");
//				insertLogin(id);
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e; // or handle it as per your application needs
		}
		return false;

		
	}

	public String getLogout(int id) throws SQLException {
		String str[] = getCurrDateTime().split(" ");
		String qry = "select * from attendance where date = ? and employeeid = ?";

		try (PreparedStatement ps = con.prepareStatement(qry)) {
			ps.setString(1, str[0]);
			ps.setInt(2, id);

			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
				String time = rs.getString("checkouttime");
				if (time == null) {
					updateLogout(id);
					return "Logged Out!!!";
				}
				}
				else return "Not Logged in";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e; // or handle it as per your application needs
		}

		return "Already logged Out!!!";
	}






	public List<Employees> getEmployeesByRole(int roleId) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM employees WHERE roleid=?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, roleId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				emp.setRoleId(rs.getInt("roleId"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Employees> getEmployeesByName(String name) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM employees WHERE firstName LIKE ? OR lastName LIKE ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, "%" + name + "%");
			pstmt.setString(2, "%" + name + "%");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Employees> getEmployeesByRoleAndName(int roleId, String name) {
		List<Employees> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM employees WHERE roleid=? AND concat(firstName, ' ',lastName) LIKE ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, roleId);
			pstmt.setString(2,"%" +name+ "%");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Employees emp = new Employees();
				emp.setEmpId(rs.getInt("employeeid"));
				emp.setFname(rs.getString("firstName"));
				emp.setLname(rs.getString("lastName"));
				// set other fields
				list.add(emp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}




	public void updatePwd(int id,String pwd)
	{

		try {
			String qry="update user_credentials set password=? where employeeid =?";
			PreparedStatement ps=con.prepareStatement(qry);
			ps.setString(1,pwd);
			ps.setInt(2, id);

			int i=ps.executeUpdate();

		}catch(Exception e)
		{
			e.printStackTrace();
		}

	}



	public boolean changePwd(String uname,String pwd)
	{

		try {
			String qry="update user_credentials set password=? where username=?";
			PreparedStatement ps=con.prepareStatement(qry);
			ps.setString(1,pwd);
			ps.setString(2,uname);

			int i=ps.executeUpdate();
			if(i>0)
			{
				System.out.println("password updated");
				return true;
			}

		}catch(Exception e)
		{
			e.printStackTrace();
		}return false;

	}


	public List<Attendance> getAttendanceByYear(int eid, String year) {
		List<Attendance> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM attendance WHERE employeeid = ? AND YEAR(date) = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Attendance att = new Attendance();
				att.setDate(rs.getString("date"));
				att.setCheckin(rs.getString("checkintime"));
				att.setCheckout(rs.getString("checkouttime"));
				list.add(att);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Attendance> getAttendanceByYearMonth(int eid, String year, String month) {
		List<Attendance> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM attendance WHERE employeeid = ? AND YEAR(date) = ? AND MONTH(date) = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ps.setString(3, month);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Attendance att = new Attendance();
				att.setDate(rs.getString("date"));
				att.setCheckin(rs.getString("checkintime"));
				att.setCheckout(rs.getString("checkouttime"));
				list.add(att);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Attendance> getAttendanceByDateRange(int eid, String fromDate, String toDate) {
		List<Attendance> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM attendance WHERE employeeid = ? AND date BETWEEN ? AND ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, fromDate);
			ps.setString(3, toDate);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Attendance att = new Attendance();
				att.setDate(rs.getString("date"));
				att.setCheckin(rs.getString("checkintime"));
				att.setCheckout(rs.getString("checkouttime"));
				list.add(att);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}



	public boolean applyLeave(Leaves leave) {
		boolean isSuccess = false;
		String query = "INSERT INTO Leaves (EmployeeID, LeaveType, StartDate, EndDate, LeaveStatus, AppliedDate, reason,TotalDays) VALUES (?, ?, ?, ?, ?, ?, ?,?)";

		try (PreparedStatement pst = con.prepareStatement(query)) {
			pst.setInt(1, leave.getEmployeeID());
			pst.setString(2, leave.getLeaveType());
			pst.setString(3, leave.getFromDate());
			pst.setString(4, leave.getToDate());
			pst.setString(5, leave.getLeaveStatus());
			pst.setString(6, leave.getAppliedDate());
			pst.setString(7, leave.getAppliedReason());
			pst.setInt(8, leave.getTotalDays());

			int rowCount = pst.executeUpdate();
			if (rowCount > 0) {
				isSuccess = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}



	public List<Leaves> getPendingLeaveById(int eid) throws SQLException
	{
		String qry = "select leaveid,employeeid,applieddate,startdate,enddate,leavetype from leaves where employeeid = ? and leavestatus = 'pending' ";
		List<Leaves> list = new ArrayList<>();
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ResultSet res = ps.executeQuery();
		while(res.next())
		{
			Leaves l = new Leaves();
			l.setLeaveId(res.getInt("leaveid"));
			l.setEmployeeID(res.getInt("employeeid"));
			l.setAppliedDate(res.getString("applieddate"));
			l.setFromDate(res.getString("startdate"));
			l.setToDate(res.getString("enddate"));
			l.setLeaveType(res.getString("leavetype"));
			list.add(l);
		}

		return list;
	}


	public List<Leaves> getLeaveRecordsById(int eid) throws SQLException
	{
		String qry = "select leaves.*, emp_approvedby.firstname, emp_approvedby.lastname FROM leaves JOIN employees AS emp_approvedby ON leaves.approvedby = emp_approvedby.employeeid WHERE leaves.employeeid = ? AND leaves.leavestatus != 'pending'";
		List<Leaves> list = new ArrayList<>();
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ResultSet res = ps.executeQuery();
		while(res.next())
		{
			Leaves l = new Leaves();
			l.setLeaveId(res.getInt("leaveid"));
			l.setEmployeeID(res.getInt("employeeid"));
			l.setLeaveType(res.getString("leavetype"));
			l.setAppliedDate(res.getString("applieddate"));
			l.setFromDate(res.getString("startdate"));
			l.setToDate(res.getString("enddate"));
			l.setLeaveStatus(res.getString("leavestatus"));
			l.setApprovedDate(res.getString("approveddate"));
			l.setApprovedBy(res.getInt("approvedby"));
			l.setAppliedReason(res.getString("reason"));
			l.setRejectReason(res.getString("rejectreason"));
			l.setApprovedByFname(res.getString("firstname"));
			l.setApprovedByLname(res.getString("lastname"));
			l.setTotalDays(res.getInt("TotalDays"));

			list.add(l);
		}

		return list;
	}
	
	
	public void deleteLeaveRecord(int lid) throws SQLException
	{
		String qry="delete from leaves where leaveid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, lid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			System.out.println("Leave Record deleted");
		}else
		{
			System.out.println("Leave Record Not Deleted");
		}
	}
	
	
	
	
	
	
	
	


	public boolean addHolidays(Holidays h) throws SQLException
	{
		String qry="insert into holidays(holidayDate,holidayName) values (?,?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, h.getDate());
		ps.setString(2, h.getHolidayname());
		int i = ps.executeUpdate();
		if(i>0)
		{
			System.out.println("Data inserted");
			return true;
		}else
		{
			System.out.println("Not inserted");
		}
		return false;
	}




	public int validateLeave(String date,String date2) throws SQLException
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate fromdate = LocalDate.parse(date,formatter);
		LocalDate todate = LocalDate.parse(date2,formatter);
		int cnt =0;
		for(LocalDate d=fromdate;!d.isAfter(todate);d=d.plusDays(1))
		{
			DayOfWeek dw = d.getDayOfWeek();

			if(checkHoliday(d.format(formatter)))
			{
				if(dw != DayOfWeek.SATURDAY && dw != DayOfWeek.SUNDAY)
				{
					cnt++;	
				}
			}

		}
		return cnt;

	}



	public boolean checkHoliday(String date) throws SQLException
	{	
		System.out.println("Checking Holiday");
		String qry="select holidayDate from holidays where holidayDate = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, date);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			System.out.println("Holiday");
			return false;
		}

		return true;
	}
	
	
	
	public void addLeavesStock(int n) throws SQLException
	{
		String qry="update leavesStock set availableLeaves = availableLeaves+? ";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1,n);
		ps.executeUpdate();
	}
	
	
	public int availDays(int eid) throws SQLException
	{
		String qry="select availableLeaves from LeavesStock where employeeid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
		int n =rs.getInt("AvailableLeaves");
		return n;
		}
		return 0;
	}
	
	
	
	public List<Leaves> getPendingLeaves() throws SQLException
	{
		List<Leaves> list = new ArrayList<>();
		String qry="SELECT l.leaveid,l.startdate, l.enddate, l.totaldays, l.leavetype, l.reason, e.firstname, e.lastname FROM leaves l JOIN employees e ON l.employeeid = e.EmployeeID WHERE l.leaveStatus = 'pending'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(qry);
		while(rs.next())
		{
			Leaves l = new Leaves();
			l.setLeaveId(rs.getInt("leaveid"));
			l.setFromDate(rs.getString("startdate"));
			l.setToDate(rs.getString("enddate"));
			l.setTotalDays(rs.getInt("totaldays"));
			l.setLeaveType(rs.getString("leavetype"));
			l.setAppliedReason(rs.getString("reason"));
			l.setFname(rs.getString("firstname"));
			l.setLname(rs.getString("lastname"));
			list.add(l);
		}
		return list;
	}
	
	
	public void updaterejectreason(String rs,int eid,int leaveid,String status) throws SQLException
	{
		String[] str = getCurrDateTime().split(" ");
		String qry="update leaves set rejectreason =?,leavestatus=?,approveddate=?,approvedby=? where leaveid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1,rs);
		ps.setString(2, status);
		ps.setString(3, str[0]);
		ps.setInt(4, eid);
		ps.setInt(5, leaveid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			System.out.println("Inserted");
		}else
		{
			System.out.println("Not inserted");
		}
	}
	
	
	
	public boolean validateAttendance(int eid) throws SQLException
	{
		System.out.println("Checking Leave");
		String[] str = getCurrDateTime().split(" ");
		String qry="select * from leaves where employeeid=? and leavestatus='approved' and ? between startdate and enddate";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, eid);
		ps.setString(2, str[0]);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			System.out.println("On Leave");
			return true;
		}
		return false;
		
	}
	
	
	public boolean validateAttendanceHoliday() throws SQLException
	{
		
		String[] str = getCurrDateTime().split(" ");
		if(checkHoliday(str[0]))
		{
			System.out.println("CHecking Weekend");
			return checkWeekend(str[0]);
		}
		return false;
	}
	
	
	public boolean checkWeekend(String date)
	{
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate date1 = LocalDate.parse(date,formatter);
		if(date1.getDayOfWeek() != DayOfWeek.SATURDAY && date1.getDayOfWeek() != DayOfWeek.SUNDAY) {
			System.out.println("Not weekend");
			return true;
		}
		return false;
	}
	
	
	
	
	public void updateLeavestock(int leaveid) throws SQLException
	{
		String qry="select employeeid,leavestatus,totaldays from leaves where leaveid=?";
		PreparedStatement ps=con.prepareStatement(qry);
		ps.setInt(1, leaveid);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int empid = rs.getInt("employeeid");
		String status = rs.getString("leavestatus");
		int totaldays = rs.getInt("totaldays");

		if(status.equals("Approved")) {
		updateAvailLeaves(totaldays,empid);
		}
		ps.close();
		rs.close();
		
		
	}
	
	public void updateAvailLeaves(int totaldays,int empid) throws SQLException
	{
		String qry2="update leavesStock set availableleaves = availableleaves - ?,consumedleaves = consumedleaves + ? where employeeid=?";
		PreparedStatement ps2=con.prepareStatement(qry2);
		ps2.setInt(1, totaldays);
		ps2.setInt(2, totaldays);
		ps2.setInt(3, empid);
		int i = ps2.executeUpdate();
		if(i>0)
		{
			System.out.println("Leaves Updated");
		}else
		{
			System.out.println("Not updated");
		}
	}

	
	
	public int getPendingLeavesCount() throws SQLException {
	    String qry = "select count(leaveid) as count from leaves where leavestatus='pending'";
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery(qry);
	    rs.next();
	    int n = rs.getInt("count");
	    System.out.println("No of LeavePending : " + n);
	    return n;
	}
	
	
	public List<Leaves> getLeaveByYear(int eid, String year) {
		List<Leaves> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM leaves WHERE EmployeeID = ? AND YEAR(StartDate) = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leaves lev = new Leaves();
				lev.setFromDate(rs.getString("startDate"));
				lev.setToDate(rs.getString("endDate"));
				lev.setTotalDays(rs.getInt("TotalDays"));
				lev.setLeaveType(rs.getString("LeaveType"));
				lev.setLeaveStatus(rs.getString("LeaveStatus"));
				list.add(lev);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Leaves> getLeaveByYearMonth(int eid, String year, String month) {
		List<Leaves> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM leaves WHERE EmployeeID= ? AND YEAR(StartDate) = ? AND MONTH(StartDate) = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, eid);
			ps.setString(2, year);
			ps.setString(3, month);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Leaves lev = new Leaves();
				lev.setFromDate(rs.getString("startDate"));
				lev.setToDate(rs.getString("endDate"));
				lev.setTotalDays(rs.getInt("TotalDays"));
				lev.setLeaveType(rs.getString("LeaveType"));
				lev.setLeaveStatus(rs.getString("LeaveStatus"));
				list.add(lev);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<AddHoliday> displayHolidays ()
	{
		List<AddHoliday> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM holidays WHERE Year(holidayDate) = Year(CURRENT_DATE())";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next()) {
				
				AddHoliday ad = new AddHoliday();
				
				ad.setId(rs.getInt("holidayid"));
				ad.setDate(rs.getString("holidayDate"));
				ad.setName(rs.getString("holidayName"));
				
				list.add(ad);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(list);
		return list;
	}
	
	public String getRoleById(int id) throws SQLException
	{
		String query = "SELECT r.RoleName FROM Employees e JOIN Roles r ON e.RoleId = r.RoleId WHERE e.employeeId = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setInt(1, id);
		ResultSet rs=ps.executeQuery();
		
		rs.next();
		String role=rs.getString("RoleName");
		System.out.print(role);
		
		return role;
	}
	
	public List<Employees> getEmployees() throws Exception {
	    List<Employees> list = new ArrayList<>();
	    String qry = "SELECT e.EmployeeID, e.FirstName, e.LastName " +
	                 "FROM Employees e " +
	                 "JOIN Roles r ON r.RoleId = e.RoleId " +
	                 "WHERE r.RoleName = 'Trainee' " +
	                 "AND e.EmployeeID NOT IN (SELECT employee FROM Manager)";
	    PreparedStatement ps = con.prepareStatement(qry);
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
	        Employees r = new Employees();
	        r.setEmpId(rs.getInt("EmployeeId"));
	        r.setFname(rs.getString("FirstName"));
	        r.setLname(rs.getString("LastName"));
	        list.add(r);
	    }
	    return list;
	}

	
	public String AddReportees(int mgrId, int empId) throws SQLException {
	    String qry = "INSERT INTO manager (manager, employee) VALUES (?, ?)";
	    try (PreparedStatement ps = con.prepareStatement(qry)) {
	        ps.setInt(1, mgrId);
	        ps.setInt(2, empId);
	        int i = ps.executeUpdate();
	        return i > 0 ? "Added" : "Something went wrong";
	    }
	}
	
	public List<Employees> getReportees(int mId) throws SQLException
	{
		List<Employees> l1 = new ArrayList<>();

		String qry=" SELECT e.EmployeeId, e.FirstName,e.LastName FROM Employees e JOIN Manager m ON e.EmployeeId = m.employee WHERE m.Manager = ?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, mId);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Employees e1  = new Employees();
			e1.setEmpId(rs.getInt("EmployeeID"));
			e1.setFname(rs.getString("FirstName"));
			e1.setLname(rs.getString("LastName"));

			l1.add(e1);
		}
		return l1;
	}
	
	
	
	public String deleteHolidayRecord(int lid) throws SQLException
	{
		String qry="delete from holidays where holidayid=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setInt(1, lid);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return "Holiday record deleted!!!";
		}else
		{
			return "Something went Wrong!!!";
		}
	}
	
	
	
	public int getPendingLeavesForMgrCount(int mid) throws SQLException {
	    String qry = "SELECT count(l.leaveid)as count FROM Leaves l JOIN Manager m ON l.employeeId = m.employee WHERE m.manager =?  and l.leavestatus='pending'";
	    PreparedStatement ps = con.prepareStatement(qry);
	    ps.setInt(1, mid);
	    ResultSet rs = ps.executeQuery();
	    rs.next();
	    int n = rs.getInt("count");
	    System.out.println("No of LeavePending : " + n);
	    return n;
	}
	
	
	public List<Leaves> getMgrPendingLeaves(int mid) throws SQLException
	{
		List<Leaves> list = new ArrayList<>();
		String qry="SELECT l.leaveid,l.startdate,l.enddate,l.totaldays,l.leavetype,l.reason, e.firstname, e.lastname FROM Leaves l JOIN Manager m ON l.employeeid = m.employee JOIN Employees e ON l.employeeid = e.employeeid WHERE m.manager = ? AND l.leaveStatus = 'pending'";
		PreparedStatement ps = con.prepareStatement(qry);
		 ps.setInt(1, mid);
		 ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			Leaves l = new Leaves();
			l.setLeaveId(rs.getInt("leaveid"));
			l.setFromDate(rs.getString("startdate"));
			l.setToDate(rs.getString("enddate"));
			l.setTotalDays(rs.getInt("totaldays"));
			l.setLeaveType(rs.getString("leavetype"));
			l.setAppliedReason(rs.getString("reason"));
			l.setFname(rs.getString("firstname"));
			l.setLname(rs.getString("lastname"));
			list.add(l);
		}
		return list;
	}
	
	
	public boolean validateEmail(String uname,String email) throws SQLException
	{
		String qry="select email from employees where employeeid =(select employeeid from user_credentials where username=?)";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, uname);
		ResultSet rs = ps.executeQuery();
		rs.next();
		if(email.equals(rs.getString("email")))
		{
//			System.out.println("true in validatemethod");
			return true;
		
		}
		return false;
	}
	
	
	public boolean changePassword(String pwd,String uname) throws SQLException
	{
		String qry="update user_credentials set password=? where username=?";
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, pwd);
		ps.setString(2, uname);
		int i = ps.executeUpdate();
		if(i>0)
		{
			return true;
		}
		return false;
	}

}




	


