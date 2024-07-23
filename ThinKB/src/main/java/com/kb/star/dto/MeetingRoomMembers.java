package com.kb.star.dto;

public class MeetingRoomMembers {

    private int userID;
    private String userName;
    private String email;
    private int contributionCnt;
    private String departmentName;
    private String teamName;
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getContributionCnt() {
		return contributionCnt;
	}
	public void setContributionCnt(int contributionCnt) {
		this.contributionCnt = contributionCnt;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

}
