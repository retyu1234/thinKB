package com.kb.star.dto;

import java.sql.Timestamp;

public class IdeaOpinionsDto {
	private int opinionID;
    private int ideaID;
    private int userID;
    private Integer parentOpinionID;
    private String opinionText;
    private String hatColor;
    private int likeNum;
    private boolean isDelete;
    private Timestamp createdAt;
    private String currentTab; // 추가
    
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
	public Integer getParentOpinionID() {
		return parentOpinionID;
	}
	public void setParentOpinionID(Integer parentOpinionID) {
		this.parentOpinionID = parentOpinionID;
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
    
    
	
}