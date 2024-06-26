package com.empmngt.enities;

public class Holidays {
	
	private int holidayid;
	private String date;
	private String holidayname;
	public int getHolidayid() {
		return holidayid;
	}
	public void setHolidayid(int holidayid) {
		this.holidayid = holidayid;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHolidayname() {
		return holidayname;
	}
	public void setHolidayname(String holidayname) {
		this.holidayname = holidayname;
	}
	@Override
	public String toString() {
		return "Holidays [holidayid=" + holidayid + ", date=" + date + ", holidayname=" + holidayname + "]";
	}
	
	

}
