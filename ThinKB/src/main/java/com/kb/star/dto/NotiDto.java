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
    private int roomId;
    private Ideas idea; // noticeList.jsp에서 한 번의 반복문만 돌리기 위한 아이디어 정보 추가
    private String roomTitle; // noticeList.jsp에서 한 번의 반복문만 돌리기 위한 roomTitle 정보 추가


    
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
	public Ideas getIdea() {
		return idea;
	}
	public void setIdea(Ideas idea) {
		this.idea = idea;
	}
    public String getRoomTitle() {
		return roomTitle;
	}

	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	
	
}


