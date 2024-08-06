package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.BestDto;

public interface BestDao {

	// 베스트 직원 목록(ID,이름,이미지)+토탈마일리지 가져오기
	List<BestDto> getBestEmployees();
	
	// 베스트 사용횟수 팀 정보(팀ID, 팀이름, 사용횟수) 가져오기
	List<BestDto> getBestUsage();

} 