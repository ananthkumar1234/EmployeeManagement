package com.empmngt.enities;

import com.mysql.cj.jdbc.Blob;

public class EmployeeAttachment {

	private int empAttachId;
	private Blob pic;
	public int getEmpAttachId() {
		return empAttachId;
	}
	public void setEmpAttachId(int empAttachId) {
		this.empAttachId = empAttachId;
	}
	
	
	public Blob getPic() {
		return pic;
	}
	public void setPic(Blob blob) {
		this.pic = blob;
	}
	@Override
	public String toString() {
		return "EmployeeAttachment [empAttachId=" + empAttachId + ", pic=" + pic + "]";
	}
	public EmployeeAttachment() {
		super();
	}
	public void setPic(java.sql.Blob blob) {
		// TODO Auto-generated method stub
		
	}
	
	
}
