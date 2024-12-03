package com.kb.star.util;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.AddVoteDto;
import com.kb.star.dto.AddVoteOptionsDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.dto.VoteParticipationsDto;

// 마이바티스 인터페이스
public interface AddVoteDao {

	// 새로운 투표 생성
	void insertNewVote(String title, String departmentId, String endDate, String id);

	int voteIdConfirm(String departmentId);

	void insertUserIntoVote(int addVoteId, String id);

	List<AddVoteDto> myAllVote(int id);

	AddVoteDto selectVoteByAddVoteId(int addVoteId);

	List<AddVoteOptionsDto> voteOptions(int addVoteId);

	List<AddVoteOptionsDto> voteOptionsAfter(int addVoteId);

	void insertVoteOption(int addVoteId, String optionText);

	Integer checkVoteParticipation(@Param("addVoteId") int addVoteId, @Param("userId") int userId);

	void updateVoteParticipation(@Param("optionId") int optionId, @Param("addVoteId") int addVoteId,
			@Param("userId") int userId);

	void incrementVoteCount(@Param("optionId") int optionId);

	void updateCompletedStatus();

	Integer getUserOptionIdForVote(Map<String, Object> params);

	List<UsersDto> whosVoteMaker();

	VoteParticipationsDto myVoteResult(int addVoteId, int userId);

	void voteUpdate(int optionId, int addVoteId, int userId);

	List<AddVoteOptionsDto> voteOptionsResult(int addVoteId);

}
