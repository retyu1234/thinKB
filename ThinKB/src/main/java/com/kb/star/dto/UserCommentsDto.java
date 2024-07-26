package com.kb.star.dto;

import java.sql.Timestamp;

public class UserCommentsDto {
    private int commentId;
    private int x;
    private int y;
    private int abTestId;
    private int userID;
    private String userName;
    private String commentText;
    private Timestamp timestamp;
    private int roomId;
    private int ideaId;
    private boolean isDelete;

    public boolean isDelete() {
		return isDelete;
	}

	public void setDelete(boolean isDelete) {
		this.isDelete = isDelete;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	// Getters and Setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getAbTestId() {
        return abTestId;
    }

    public void setAbTestId(int abTestId) {
        this.abTestId = abTestId;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomID(int roomId) {
        this.roomId = roomId;
    }

    public int getIdeaId() {
        return ideaId;
    }

    public void setIdeaId(int ideaId) {
        this.ideaId = ideaId;
    }
}
