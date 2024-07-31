package com.kb.star.dto;

public class TodoDto {

    private String dueDate;
    private String roomTitle;
    private String stageStatus;
    private int roomId;
    private int stageId;
    
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public int getStageId() {
		return stageId;
	}
	public void setStageId(int stageId) {
		this.stageId = stageId;
	}
	public String getDueDate() {
		return dueDate;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	public String getRoomTitle() {
		return roomTitle;
	}
	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}
	public String getStageStatus() {
		return stageStatus;
	}
	public void setStageStatus(String stageStatus) {
		this.stageStatus = stageStatus;
	}
    @Override
    public String toString() {
        return "TodoDto{" +
                "dueDate='" + dueDate + '\'' +
                ", roomTitle='" + roomTitle + '\'' +
                ", stageStatus='" + stageStatus + '\'' +
                '}';
    }
}
