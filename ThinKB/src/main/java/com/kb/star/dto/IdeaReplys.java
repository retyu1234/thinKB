package com.kb.star.dto;

public class IdeaReplys {
    private int ideaReply;
    private int ideaId;
    private int userId;
    private int roomId;
    private int replyStep;
    private boolean isDelete;
    private String replyContent;
    private int replyCount; // 추가된 필드
    

    // Default constructor
    public IdeaReplys() {}

    // Parameterized constructor
    public IdeaReplys(int ideaReply, int ideaId, int userId, int roomId, int replyStep, boolean isDelete, String replyContent) {
        this.ideaReply = ideaReply;
        this.ideaId = ideaId;
        this.userId = userId;
        this.roomId = roomId;
        this.replyStep = replyStep;
        this.isDelete = isDelete;
        this.replyContent = replyContent;
    }

    // Getters and Setters
    public int getIdeaReply() {
        return ideaReply;
    }

    public void setIdeaReply(int ideaReply) {
        this.ideaReply = ideaReply;
    }

    public int getIdeaId() {
        return ideaId;
    }

    public void setIdeaId(int ideaId) {
        this.ideaId = ideaId;
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

    public int getReplyStep() {
        return replyStep;
    }

    public void setReplyStep(int replyStep) {
        this.replyStep = replyStep;
    }

    public boolean getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    @Override
    public String toString() {
        return "IdeaReplys{" +
                "ideaReply=" + ideaReply +
                ", ideaId=" + ideaId +
                ", userId=" + userId +
                ", roomId=" + roomId +
                ", replyStep=" + replyStep +
                ", isDelete=" + isDelete +
                ", replyContent='" + replyContent + '\'' +
                '}';
    }

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
}
