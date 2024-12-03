package com.kb.star.dto;

public class BestDto {

	// 베스트 직원
	// Users 테이블
	private int userId;
	private String userName;
	private String profileImg;
	// MeetingRoomMembers 테이블에서 total마일리지 계산한 것
	private int totalContribution;
	
	// 베스트 사용량(팀별)
	private int teamId;
    private String teamName;
    private int teamCount;
	
	
	// getter setter
	public int getUserId() {
		return userId;
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

	public int getTeamId() {
		return teamId;
	}

	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public int getTeamCount() {
		return teamCount;
	}

	public void setTeamCount(int teamCount) {
		this.teamCount = teamCount;
	}

	
	
	
}
