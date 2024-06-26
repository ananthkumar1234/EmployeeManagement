package com.empmngt.enities;

public class Attendance {

	private int attendId;
	private int empId;
	private String date;
	private String checkin;
	private String checkout;
	private String remarks;
	
	
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getAttendId() {
		return attendId;
	}
	public void setAttendId(int attendId) {
		this.attendId = attendId;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	@Override
	public String toString() {
		return "Attendance [attendId=" + attendId + ", empId=" + empId + ", date=" + date + ", checkin=" + checkin
				+ ", checkout=" + checkout + "]";
	}
	
	
}
