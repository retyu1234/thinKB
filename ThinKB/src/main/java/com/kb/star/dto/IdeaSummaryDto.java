package com.kb.star.dto;

public class IdeaSummaryDto {
    private int ideaId;
    private String ideaTitle;
    private String opinionText;
    private String hatColor;
    private int likeNum;
    private String opinionUserName;
    
	public String getOpinionUserName() {
		return opinionUserName;
	}
	public void setOpinionUserName(String opinionUserName) {
		this.opinionUserName = opinionUserName;
	}
	public int getIdeaId() {
		return ideaId;
	}
	public void setIdeaId(int ideaId) {
		this.ideaId = ideaId;
	}
	public String getIdeaTitle() {
		return ideaTitle;
	}
	public void setIdeaTitle(String ideaTitle) {
		this.ideaTitle = ideaTitle;
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
    
}
