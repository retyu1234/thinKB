package com.kb.star.dto;

import java.sql.Timestamp;

public class AddVoteDto {
	private int AddVoteId; // 테스트 방 번호
	private String Title; // 테스트 제목
	private boolean isDelete; // 삭제 여부
	private Timestamp createdAt; // 생성 시간
	private String endDate;
	private int departmentId;
	private boolean isCompleted;

	private Integer votedOptionId; // 투표된 옵션 ID
	
	private int createUserID;

	// Getters and setters
	
	

	public Integer getVotedOptionId() {
		return votedOptionId;
	}

	public int getCreateUserID() {
		return createUserID;
	}

	public void setCreateUserID(int createUserID) {
		this.createUserID = createUserID;
	}

	public void setVotedOptionId(Integer votedOptionId) {
		this.votedOptionId = votedOptionId;
	}

	public int getAddVoteId() {
		return AddVoteId;
	}

	public void setAddVoteId(int addVoteId) {
		AddVoteId = addVoteId;
	}

	public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
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

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public void setCompleted(boolean isCompleted) {
		this.isCompleted = isCompleted;
	}

	public boolean getIsCompleted() {
		return isCompleted;
	}

	public void setIsCompleted(boolean isCompleted) {
		this.isCompleted = isCompleted;
	}

}