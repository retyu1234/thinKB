package com.kb.star.dto;

public class MeetingRooms {

	private int roomId;
	private String roomTitle;
	private String Description;
	private int departmentId;
	private int teamId;
	private int roomManagerId;
	private int stageId;
	private boolean isDelete;
	private String endDate;
	private String createdAt;

	// getter setter

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getRoomTitle() {
		return roomTitle;
	}

	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public int getTeamId() {
		return teamId;
	}

	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}

	public int getRoomManagerId() {
		return roomManagerId;
	}

	public void setRoomManagerId(int roomManagerId) {
		this.roomManagerId = roomManagerId;
	}

	public int getStageId() {
		return stageId;
	}

	public void setStageId(int stageId) {
		this.stageId = stageId;
	}

	public boolean isDelete() {
		return isDelete;
	}

	public void setDelete(boolean isDelete) {
		this.isDelete = isDelete;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "MeetingRooms [roomId=" + roomId + ", roomTitle=" + roomTitle + ", Description=" + Description
				+ ", departmentId=" + departmentId + ", teamId=" + teamId + ", roomManagerId=" + roomManagerId
				+ ",stageId=" + stageId + "" + "isDelete=" + isDelete + ",endDate=" + endDate + ",createdAt="
				+ createdAt + "]";
	}
}
