package com.empmngt.enities;

public class Roles {

	private int RoleId;
	private  String RoleName;
	public int getRoleId() {
		return RoleId;
	}
	public void setRoleId(int roleId) {
		RoleId = roleId;
	}
	public String getRoleName() {
		return RoleName;
	}
	public void setRoleName(String roleName) {
		RoleName = roleName;
	}
	@Override
	public String toString() {
		return "Roles [RoleId=" + RoleId + ", RoleName=" + RoleName + "]";
	}
	
	
}
