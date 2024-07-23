package com.kb.star.dto;

import java.sql.Timestamp;

public class VoteParticipationsDto {
	private int ParticipationID; // 투표 참가 번호
	private int AddVoteId; // 투표방 번호
	private int UserId; // 투표자 아이디
	private String OptionId; // 투표 항목 번호
	private Timestamp VotedAt; // 투표 등록 시간

	// Getters and setters
	public int getParticipationID() {
		return ParticipationID;
	}

	public void setParticipationID(int participationID) {
		ParticipationID = participationID;
	}

	public int getAddVoteId() {
		return AddVoteId;
	}

	public void setAddVoteId(int addVoteId) {
		AddVoteId = addVoteId;
	}

	public int getUserId() {
		return UserId;
	}

	public void setUserId(int userId) {
		UserId = userId;
	}

	public String getOptionId() {
		return OptionId;
	}

	public void setOptionId(String optionId) {
		OptionId = optionId;
	}

	public Timestamp getVotedAt() {
		return VotedAt;
	}

	public void setVotedAt(Timestamp votedAt) {
		VotedAt = votedAt;
	}

}