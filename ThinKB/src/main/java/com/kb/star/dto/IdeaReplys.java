package com.kb.star.dto;

public class IdeaReplys {
    private int ideaReplyId;
    private int ideaId;
    private int userId;
    private int roomId;
    private int replyStep;
    private boolean isDelete;
    private String replyContent;

    // Default constructor
    public IdeaReplys() {}

    // Parameterized constructor
    public IdeaReplys(int ideaReplyId, int ideaId, int userId, int roomId, int replyStep, boolean isDelete, String replyContent) {
        this.ideaReplyId = ideaReplyId;
        this.ideaId = ideaId;
        this.userId = userId;
        this.roomId = roomId;
        this.replyStep = replyStep;
        this.isDelete = isDelete;
        this.replyContent = replyContent;
    }

    // Getters and Setters
    public int getIdeaReplyId() {
        return ideaReplyId;
    }

    public void setIdeaReplyId(int ideaReplyId) {
        this.ideaReplyId = ideaReplyId;
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
                "ideaReplyId=" + ideaReplyId +
                ", ideaId=" + ideaId +
                ", userId=" + userId +
                ", roomId=" + roomId +
                ", replyStep=" + replyStep +
                ", isDelete=" + isDelete +
                ", replyContent='" + replyContent + '\'' +
                '}';
    }
}
