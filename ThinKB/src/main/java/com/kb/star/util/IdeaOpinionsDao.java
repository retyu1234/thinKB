package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;

public interface IdeaOpinionsDao {
	

    // 알림 테이블의 IdeaID컬럼으로 Ideas 테이블 정보 가져오기
    Ideas getIdeaTitleById(int ideaId); // IdeasDto =  Ideas
    
    // HHatColor에 따라 의견 검색
    List<IdeaOpinionsDto> findByHatColor(String hatColor);

    // 의견 추가
    void insertOpinion(IdeaOpinionsDto opinionForm);
    
    // 의견 삭제 메서드
    void deleteOpinion(int opinionId); // opinionId = 의견의 PK값
    

    
    // 알림 읽음 상태 업데이트 메서드
    void updateReadStatus(int notificationID);
    
    
}
