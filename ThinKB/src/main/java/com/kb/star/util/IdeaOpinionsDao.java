package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.IdeaOpinionsDto;

public interface IdeaOpinionsDao {

	// 의견 삭제 메서드
    void deleteNotification(int notificationID);

    // HatColor에 따라 의견 검색 메서드
    List<IdeaOpinionsDto> findByHatColor(String hatColor);

    // 의견 추가 메서드
    void insertOpinion(IdeaOpinionsDto opinionForm);

    // 알림 읽음 상태 업데이트 메서드
    void updateReadStatus(int notificationID);
    
    
}
