package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.AorBDto;

public interface AorBDao {

	// A/B테스트 생성 
	public void makeAorB(final String TestName, final String VariantA, final String VariantB);

	//  A/B테스트 목록(모든정보) 가져오기
	public List<AorBDto> getAorBList();

}
