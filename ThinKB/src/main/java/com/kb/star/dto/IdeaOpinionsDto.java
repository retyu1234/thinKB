package com.kb.star.dto;

import java.sql.Timestamp;

public class IdeaOpinionsDto {
	private int opinionID;
    private int ideaID;
    private int userID;
    private Integer step;
    private String opinionText;
    private String hatColor;
    private int likeNum;
    private boolean isDelete;
    private Timestamp createdAt;
    
    // 추가 필드
    private String currentTab; // 4가지 의견중 현재 탭
    private Integer roomId;  
    private Integer ideaId;  
    private Integer opinionId; // 의견 작성자의 id
    private String userName; 
    private boolean likedByCurrentUser; // 특정 사용자가 특정 의견에 대해 좋아요를 눌렀는지 여부
    
    // Getters and Setters
	public int getOpinionID() {
		return opinionID;
	}
	public void setOpinionID(int opinionID) {
		this.opinionID = opinionID;
	}
	public int getIdeaID() {
		return ideaID;
	}
	public void setIdeaID(int ideaID) {
		this.ideaID = ideaID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}

	public Integer getStep() {
		return step;
	}
	public void setStep(Integer step) {
		this.step = step;
	}
	public String getOpinionText() {
		return opinionText;
	}
	public void setOpinionText(String opinionText) {
		this.opinionText = opinionText;
	}
	public String getHatColor() {
		return hatColor;
	}
	public void setHatColor(String hatColor) {
		this.hatColor = hatColor;
	}
	public int getLikeNum() {
		return likeNum;
	}
	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
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
	public String getCurrentTab() {
        return currentTab;
    }

    public void setCurrentTab(String currentTab) {
        this.currentTab = currentTab;
    }
	public Integer getRoomId() {
		return roomId;
	}
	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}
	public Integer getIdeaId() {
		return ideaId;
	}
	public void setIdeaId(Integer ideaId) {
		this.ideaId = ideaId;
	}
	public Integer getOpinionId() {
		return opinionId;
	}
	public void setOpinionId(Integer opinionId) {
		this.opinionId = opinionId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public boolean isLikedByCurrentUser() {
		return likedByCurrentUser;
	}
	public void setLikedByCurrentUser(boolean likedByCurrentUser) {
		this.likedByCurrentUser = likedByCurrentUser;
	}


	
    
    
	
}