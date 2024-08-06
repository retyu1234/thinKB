package com.kb.star.dto;

public class MeetingRoomMember {
	
	private int roomId;
	private int userId;
	private String role;
	private int contributionCnt;
	private boolean isDelete;
	
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getContributionCnt() {
		return contributionCnt;
	}
	public void setContributionCnt(int contributionCnt) {
		this.contributionCnt = contributionCnt;
	}
	public boolean isDelete() {
		return isDelete;
	}
	public void setDelete(boolean isDelete) {
		this.isDelete = isDelete;
	}
	
	

}
