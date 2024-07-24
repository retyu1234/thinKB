package com.kb.star.util;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.AddVoteDto;
import com.kb.star.dto.AddVoteOptionsDto;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.Teams;
import com.kb.star.dto.UserListDto;
import com.kb.star.dto.UsersDto;

// 마이바티스 인터페이스
public interface AddVoteDao {

	// 새로운 투표 생성
	void insertNewVote(String title, String departmentId, String endDate);

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

}
