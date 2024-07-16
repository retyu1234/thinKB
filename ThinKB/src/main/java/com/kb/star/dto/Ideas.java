package com.kb.star.dto;

public class Ideas {
    private int ideaID;
    private int userID;
    private int roomID;
    private String title;
    private String description;
    private boolean isDelete;
    private int stageID;
    private int pickNum;

    // 기본 생성자
    public Ideas() {}

    // 모든 필드를 포함하는 생성자
    public Ideas(int ideaID, int userID, int roomID, String title, String description, boolean isDelete, int stageID, int pickNum) {
        this.ideaID = ideaID;
        this.userID = userID;
        this.roomID = roomID;
        this.title = title;
        this.description = description;
        this.isDelete = isDelete;
        this.stageID = stageID;
        this.pickNum = pickNum;
    }

    // Getter 및 Setter 메소드
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

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public int getStageID() {
        return stageID;
    }

    public void setStageID(int stageID) {
        this.stageID = stageID;
    }

    public int getPickNum() {
        return pickNum;
    }

    public void setPickNum(int pickNum) {
        this.pickNum = pickNum;
    }

    // toString 메소드 (선택 사항)
    @Override
    public String toString() {
        return "Idea{" +
                "ideaID=" + ideaID +
                ", userID=" + userID +
                ", roomID=" + roomID +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", isDelete=" + isDelete +
                ", stageID=" + stageID +
                ", pickNum=" + pickNum +
                '}';
    }
}
