package com.kb.star.util;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.AorBDto;
import com.kb.star.dto.UserCommentsDto;

public interface AorBDao {

	// A/B테스트 목록(모든정보) 가져오기
	public List<AorBDto> getAorBList(@Param("userId") int userId);

	// A/B테스트 생성
	void makeAorB(@Param("testName") String testName, @Param("variantA") String variantA,
			@Param("variantB") String variantB);

	// ab테스트 개별방리스트
	AorBDto abTestDetail(int ABTestID);

	// abtest 결과 insert
	void insertABResult(@Param("abTestId") int abTestId, @Param("userId") int userId, @Param("pick") int pick);

	// A선택시 update
	void voteForVariantA(@Param("abTestId") int abTestId);

	// B선택시 update
	void voteForVariantB(@Param("abTestId") int abTestId);

	// 11:08 추가
	List<AorBDto> getAorBFeedbackList(@Param("departmentId") int departmentId);

	public Integer myPick(int abTestId, int userId);


}
