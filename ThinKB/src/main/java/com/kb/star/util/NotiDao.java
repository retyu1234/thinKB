package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.NotiDto;

public interface NotiDao {

	// 알림 목록(모든정보) 가져오기
	public List<NotiDto> getAllNoti(int userId);

	// 알림 테이블의 IdeaID컬럼으로 Ideas 테이블 정보 가져오기
    Ideas getIdeaById(int ideaId); // IdeasDto =  Ideas
    
    // 알림 읽음 상태 업데이트
    void updateReadStatus(int notificationId);
    
    
}
