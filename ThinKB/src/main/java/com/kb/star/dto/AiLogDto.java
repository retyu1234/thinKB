package com.kb.star.dto;

public class AiLogDto {

	private int aiLogId;
	private int userId;
	private String aiContent;
	private String aiQuestion;
	private int roomId;
	private String userName;
	private String profileImg;
	
	public int getAiLogId() {
		return aiLogId;
	}
	public void setAiLogId(int aiLogId) {
		this.aiLogId = aiLogId;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getAiContent() {
		return aiContent;
	}
	public void setAiContent(String aiContent) {
		this.aiContent = aiContent;
	}
	public String getAiQuestion() {
		return aiQuestion;
	}
	public void setAiQuestion(String aiQuestion) {
		this.aiQuestion = aiQuestion;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
