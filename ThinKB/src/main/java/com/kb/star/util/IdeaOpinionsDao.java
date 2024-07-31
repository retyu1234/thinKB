package com.kb.star.util;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;

public interface IdeaOpinionsDao {
	

	// ideaOpinionsList.jsp
    // 각 모자 색상에 따른 의견 5개 목록 검색
    List<IdeaOpinionsDto> findTop5ByHatColor(String hatColor);
    
    
	// ideaOpinions.jsp
    // 알림 테이블의 IdeaID컬럼으로 Ideas 테이블 정보 가져오기
    Ideas getIdeaTitleById(int ideaId); // IdeasDto =  Ideas
    
    // ideaId, 견해별 의견 가져오기
    // List<IdeaOpinionsDto> findByHatColor(String hatColor);
    List<IdeaOpinionsDto> findByHatColor(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);

    // 의견 추가
    void insertOpinion(IdeaOpinionsDto opinionForm);
    
    // 의견 삭제 메서드
    void deleteOpinion(int opinionId); // opinionId = 의견의 PK값
    
    // 회의방 총 참여자 수
    int getUserCount(int roomId);
    
    // ideaId, 견해별 작성된 의견 수
    int getOpinionCountByHatColorAndIdeaId(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 사용자가 각 탭에 작성한 댓글 수
    List<String> getUserCommentedTabs(@Param("userId") int userId, @Param("ideaId") int ideaId);
    
    // 각 사용자가 작성한 전체 의견 수
    int getUserOpinionCount(@Param("userId") int userId, @Param("ideaId") int ideaId);
    
    // 2개 이상 의견 작성시 StageParticipation테이블의 status 업데이트
    void updateStatus(@Param("userId") int userId, @Param("ideaId") int ideaId, @Param("roomId") int roomId, @Param("status") boolean status);
    // 2개 이상 의견 작성시 MeetingRoomMembers테이블의 기여도 +1 / -1
    void updateContribution(@Param("ideaId") int ideaId, @Param("userId") int userId, @Param("roomId") int roomId, @Param("status") boolean status);
    
    // 타이머
    String getEndTime(@Param("roomId") int roomId, @Param("ideaId") int ideaId);
    
    // MeetingRooms테이블에서 방장ID 가져오기
    int getRoomManagerId(@Param("roomId") int roomId);
    
    // 방장전용 - stage3 완료자 수 
    int getDoneUserCount(@Param("roomId") int roomId, @Param("ideaId") int ideaId);
    
    
    
    
    
    // 다음단계
	// Timer 시간 새로 insert 해주기
	void updateNewTimer(@Param("roomId") int roomId, @Param("ideaId") int ideaId, @Param("formattedTime") String formattedTime);
    
    // MeetingRooms에서 stage 4로 변경
    void updateStage(@Param("roomId") int roomId);
    
    // Ideas에서 아이디어 StageID 4로 변경
	void updateIdeaStage(@Param("ideaId") int ideaId);
	
	// 방번호별 userList
	List<Integer> RoomForUserList(@Param("roomId") int roomId);
	// StageParticipation에서 참여자별 StageID 4로 새로 생성해서 Status 0으로 일괄 넣기
	void insertStageParticipation(@Param("roomId") int roomId, @Param("ideaId") int ideaId, @Param("list") Integer list);
    

	
    
    
    // ideaOpinions2.jsp
    // 이전 단계 의견을 가져오는 메서드
    List<IdeaOpinionsDto> getPreviousOpinionsByHatColor(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 의견 추가2
    void insertOpinion2(IdeaOpinionsDto opinion);
    // 모자 색상에 따라 현재 의견을 가져오는 메서드
    List<IdeaOpinionsDto> getCurrentOpinionsByHatColor(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 의견 삭제2 메서드 (opinionId = 의견의 PK값)
    void deleteLike(int opinionId); // 좋아요 삭제
    void deleteOpinion2(int opinionId); // 의견 삭제 
    
    
    // 중복작성 방지
    // 사용자가 각 탭에 작성한 댓글 수
    List<String> getUserCommentedTabs2(@Param("userId") int userId, @Param("ideaId") int ideaId);
    // 사용자가 작성한 전체 의견 수(전체 탭)
    int getUserOpinionCount2(@Param("userId") int userId, @Param("ideaId") int ideaId);
    // 1개 이상 의견 작성시 StageParticipation테이블의 status 업데이트
    void updateStatus2(@Param("userId") int userId, @Param("ideaId") int ideaId, @Param("roomId") int roomId, @Param("status") boolean status);
    // 2개 이상 의견 작성시 MeetingRoomMembers테이블의 기여도 +1 / -1
    void updateContribution2(@Param("ideaId") int ideaId, @Param("userId") int userId, @Param("roomId") int roomId, @Param("status") boolean status);
    // 사용자별 특정 탭에 이미 작성한 의견이 있는지 확인하는 메서드(중복작성방지)
    int countUserOpinionsInTab(@Param("userId") int userId, @Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 좋아요 수 증가
    void increaseLikeNum(@Param("opinionId") int opinionId);
    // 좋아요 수 감소
    void decreaseLikeNum(@Param("opinionId") int opinionId);
    // 현재 좋아요 수 가져오기
    int getLikeNum(@Param("opinionId") int opinionId);
    // 좋아요 수만큼 MeetingRoomMembers테이블의 기여도 증가
    void updateContributionLikeNum(@Param("ideaId") int ideaId, @Param("userId") int userId, @Param("roomId") int roomId, @Param("status") boolean status);
    // 사용자가 특정 의견에 좋아요를 눌렀는지 확인
    boolean checkUserLikedOpinion(@Param("userId") int userId, @Param("opinionId") int opinionId);
    // 좋아요 추가
    void addUserLike(@Param("userId") int userId, @Param("opinionId") int opinionId);
    // 좋아요 제거
    void removeUserLike(@Param("userId") int userId, @Param("opinionId") int opinionId);
    
    
    // 방장전용 - stage4 완료자 수 
    int getDoneUserCount2(@Param("roomId") int roomId, @Param("ideaId") int ideaId);
    
    
    // 다음단계
    // MeetingRooms에서 stage 5로 변경
    void updateStage5(@Param("roomId") int roomId);
    
    // Ideas에서 아이디어 StageID 5로 변경
	void updateIdeaStage5(@Param("ideaId") int ideaId);
	
	// 방번호별 userList
	List<Integer> RoomForUserList5(@Param("roomId") int roomId);
	// StageParticipation에서 참여자별 StageID 4로 새로 생성해서 Status 0으로 일괄 넣기
	void insertStageParticipation5(@Param("roomId") int roomId, @Param("ideaId") int ideaId, @Param("list") Integer list);

	
	
	// ideaOpinionsClear2.jsp
	// Ideas 테이블에서 제목, stageID 가져오기
	List<Ideas> getIdeasInfo(@Param("roomId") int roomId); // Ideas = IdeasDto


    
}




