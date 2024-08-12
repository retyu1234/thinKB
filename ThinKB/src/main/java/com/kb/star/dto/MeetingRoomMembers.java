package com.kb.star.dto;

public class MeetingRoomMembers {

    private int userId;
    private String userName;
    private String email;
    private int contributionCnt;
    private String departmentName;
    private String teamName;
    private int roomId;
    private String birth;
    
    
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserID(int userId) {
		this.userId = userId;
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
