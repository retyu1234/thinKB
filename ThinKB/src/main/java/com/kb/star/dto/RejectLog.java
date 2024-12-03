package com.kb.star.dto;

public class RejectLog {
	
	private int rejectId;
	private int roomId;
	private int ideaId;
	private String rejectContents;
	private String rejectIdeaTitle;
	private String description;
	
	public int getRejectId() {
		return rejectId;
	}
	public void setRejectId(int rejectId) {
		this.rejectId = rejectId;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public int getIdeaId() {
		return ideaId;
	}
	public void setIdeaId(int ideaId) {
		this.ideaId = ideaId;
	}
	public String getRejectContents() {
		return rejectContents;
	}
	public void setRejectContents(String rejectContents) {
		this.rejectContents = rejectContents;
	}
	public String getRejectIdeaTitle() {
		return rejectIdeaTitle;
	}
	public void setRejectIdeaTitle(String rejectIdeaTitle) {
		this.rejectIdeaTitle = rejectIdeaTitle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	

}
