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
    
    // 팀별 인원 수
    int getUserCountByTeamId(int teamId);
    
    // ideaId, 견해별 작성된 의견 수
    int getOpinionCountByHatColorAndIdeaId(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 각 사용자가 작성한 전체 의견 수
    // int getUserOpinionCount(@Param("userId") int userId, @Param("ideaId") int ideaId);
    
    
    
    
    // ideaOpinions2.jsp
    // 이전 단계 의견을 가져오는 메서드
    List<IdeaOpinionsDto> getPreviousOpinionsByHatColor(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 의견 추가2
    void insertOpinion2(IdeaOpinionsDto opinion);
    
    // 모자 색상에 따라 현재 의견을 가져오는 메서드
    List<IdeaOpinionsDto> getCurrentOpinionsByHatColor(@Param("ideaId") int ideaId, @Param("hatColor") String hatColor);
    
    // 의견 삭제2 메서드
    void deleteOpinion2(int opinionId); // opinionId = 의견의 PK값
    
}




