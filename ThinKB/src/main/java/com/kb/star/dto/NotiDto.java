package com.kb.star.dto;

import java.sql.Timestamp;

public class NotiDto {
	private int notificationID; // 알림 ID
    private int userID;         // 사용자 ID
    private int ideaID;         // 아이디어 ID
    private String message;     // 알림 메시지
    private boolean isRead;     // 읽음 여부
    private boolean isDelete;   // 삭제 여부
    private Timestamp createdAt;// 생성 시간

    
    // Getters and setters
	public int getNotificationID() {
		return notificationID;
	}
	public void setNotificationID(int notificationID) {
		this.notificationID = notificationID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public int getIdeaID() {
		return ideaID;
	}
	public void setIdeaID(int ideaID) {
		this.ideaID = ideaID;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isRead() {
		return isRead;
	}
	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}
	public boolean isDelete() {
		return isDelete;
	}
	public void setDelete(boolean isDelete) {
		this.isDelete = isDelete;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	
}


