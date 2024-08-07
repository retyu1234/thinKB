package com.kb.star.dto;

public class AdminDto {
	
	// 모든 사용자 정보 가져오기
	private String email;
    private String birth;
    private boolean isDelete;
    private String teamName;
	
	// 베스트 직원
	// Users 테이블
	private int userId;
	private String userName;
	private String profileImg;
	// MeetingRoomMembers 테이블에서 total마일리지 계산한 것
	private int totalContribution;
	
	// 베스트 사용량(팀별)
	private int departmentId;
    private String departmentName;
    private int departmentCount;
	
	
	// getter setter
	public int getUserId() {
		return userId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public int getTotalContribution() {
		return totalContribution;
	}

	public void setTotalContribution(int totalContribution) {
		this.totalContribution = totalContribution;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public int getDepartmentCount() {
		return departmentCount;
	}

	public void setDepartmentCount(int departmentCount) {
		this.departmentCount = departmentCount;
	}
	
	
	
}
