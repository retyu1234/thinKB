package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.NotiDto;

public interface NotiDao {

	// 알림 목록(모든정보) 가져오기
	public List<NotiDto> getAllNoti(int userId);

}
