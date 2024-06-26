package com.empmngt.enities;

public class User_credentials {
	
	private int empId;
	private String username;
	private String password;
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "User_credentials [empId=" + empId + ", username=" + username + ", password=" + password + "]";
	}
	
	

}
