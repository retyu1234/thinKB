package com.kb.star.util;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRoomMember;
import com.kb.star.dto.MeetingRoomMembers;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.StageParticipationIdeas;
import com.kb.star.dto.RejectLog;
import com.kb.star.dto.TimersDto;
import com.kb.star.dto.UserListDto;
import com.kb.star.dto.UsersDto;

public interface RoomDao {

	MeetingRooms roomDetailInfo(int roomId);

	String roomTimerInfo(int roomId);
	
	// 새로 추가
	String roomTimer(int roomId);

	void submitIdea(int id, int roomId, String title, String contents);

	void updateParticipantStage1(int roomId, int id);

	boolean isParticipantsStage1(int roomId, int id);

	List<Ideas> ideaInfo(int roomId, int id);

	void updateStage(@Param("roomId") int roomId);

	void isDeleteUpdate(int id, int roomId);

	List<Ideas> ideaList(int roomId, int stage);

	void updateParticipantStage2(int roomId);

	List<Integer> RoomForUserList(int roomId);

	void insertForwardStage2(Integer list, int roomId);

	void stageTwoTimerUpdate(int roomId, String formattedTime);
	
	MeetingRooms selectRoomId(@Param("roomId") int roomId);
	
	List<TimersDto> selectTimersByRoomId(@Param("roomId") int roomId);

	List<Ideas> selectIdeasByRoomId(@Param("roomId") int roomId);
	
	void roomMangeTimerUpdate(int roomId,String formattedTime,String ideaId);
	
	void updateRoomInfo(String title,String Description, String endDate,int roomId);
	
	List<MeetingRoomMembers> selectCurrentMembers(@Param("roomId") int roomId);
	
	List<UserListDto>selectAvailableEmployees(@Param("roomId") int roomId,@Param("departmentId") int departmentId);

	void updateRejectLog(int roomId, int rejectId, String rejectContents);

	void isRejectUpdate(int rejectId);

	String rejectLogSelect(int ideaID);

	void makeNotification(Integer user, int ideaNum, String notification);

	void addMeetingRoomMembers(@Param("roomId") int roomId, @Param("userIds") List<Integer> userIds);
	
	void insertStageParticipations(@Param("roomId") int roomId,@Param("stageId") int stageId, @Param("userIds") List<Integer> userIds);
	
	void deleteMembers(int roomId, int userId);

	void contributionUpdate(int roomId, int id);

	void updateIdeaStage3(int firstIdeaId);

	int pickedIdeaUser(int firstIdeaId, int roomId);

	void updateYesPickNContribution(int roomId, int userId1);

	void insertNewTimerForIdea(int roomId, int firstIdeaId, String formattedTime);

	void insertForwardStage3(int firstIdeaId, Integer list, int roomId);

	List<Ideas> yesPickIdeaList(int roomId);

	List<Ideas> ideaPickNum(int roomId);
	
	int selectTop2IdeasForRoom(@Param("roomId") int roomId);

	List<StageParticipationIdeas>getStatusIdeasTitle(@Param("roomId") int roomId);
	
	void insertParticipation(@Param("ideaId") int ideaId,@Param("stageId") int stageId,@Param("userId") int userId,@Param("roomId") int roomId);
	
	void updateParticipation(@Param("ideaId") int ideaId,@Param("stageId") int stageId,@Param("userId") int userId,@Param("roomId") int roomId);
	
	List<Integer> getTopIdeaIds(@Param("roomId") int roomId);
	
	int checkExistingEntry(@Param("ideaId") int ideaId,@Param("stageId") int stageId,@Param("userId") int userId,@Param("roomId") int roomId);

	List<Ideas> ideaListUnreject(int roomId, int stage);

	Ideas alreadySubmitIdea(int roomId, int id);

	Ideas rejectedIdea(int roomId, int id);

	RejectLog whatsRejectLog(int ideaID);

	int totalRoomUsers(int roomId);

	int submitRoomUser(int roomId);

	void insertNotifiNonParti(@Param("roomId") int roomId,@Param("stageId") int stageId, List<StageParticipationIdeas> ideaList);

	int voteRoomUsers(int roomId);

	void insertNotifications(@Param("userIdList") List<Integer> userIdList,@Param("message") String message,@Param("roomId") int roomId);

	List<Integer> roomIdFormember(int roomId);

	UsersDto whosMember(int id);

	List<Ideas> totalIdea(int roomId);

	List<IdeaOpinionsDto> ideaIdForOpinion(int firstNum);

	List<MeetingRoomMember> memberForRoomId(int roomId);

	List<RejectLog> rejectList(int roomId, int id);

}
