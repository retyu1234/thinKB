package com.kb.star.dto;

import java.sql.Timestamp;

public class TimersDto {

	private int roomId;
	private int ideaId;
	private String startTime;
	private String endTime;
	private String ideaTitle;
	private long remainingTime;
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
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getIdeaTitle() {
		return ideaTitle;
	}
	public void setIdeaTitle(String ideaTitle) {
		this.ideaTitle = ideaTitle;
	}
	public long getRemainingTime() {
		return remainingTime;
	}
	public void setRemainingTime(long remainingTime) {
		this.remainingTime = remainingTime;
	}
	
}
