package com.kb.star.dto;

public class StageParticipationIdeas {
	private int participationId; 
	private int ideaId; 
	private int stageId; 
	private int userId; 
	private int roomId;
	private boolean status;
	private String title;
	public int getParticipationId() {
		return participationId;
	}
	public void setParticipationId(int participationId) {
		this.participationId = participationId;
	}
	public int getIdeaId() {
		return ideaId;
	}
	public void setIdeaId(int ideaId) {
		this.ideaId = ideaId;
	}
	public int getStageId() {
		return stageId;
	}
	public void setStageId(int stageId) {
		this.stageId = stageId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
