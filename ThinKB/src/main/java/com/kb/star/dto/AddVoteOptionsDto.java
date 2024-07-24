package com.kb.star.dto;

import java.sql.Timestamp;

public class AddVoteOptionsDto {
	private int optionId;
	private int addVoteId;
	private String optionText;
	private int voteCount;

	public int getOptionId() {
		return optionId;
	}

	public void setOptionId(int optionId) {
		this.optionId = optionId;
	}

	public int getAddVoteId() {
		return addVoteId;
	}

	public void setAddVoteId(int addVoteId) {
		this.addVoteId = addVoteId;
	}

	public String getOptionText() {
		return optionText;
	}

	public void setOptionText(String optionText) {
		this.optionText = optionText;
	}

	public int getVoteCount() {
		return voteCount;
	}

	public void setVoteCount(int voteCount) {
		this.voteCount = voteCount;
	}

	// Getters and setters

}