package com.kb.star.util;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.AorBDto;
import com.kb.star.dto.PinTestsDto;
import com.kb.star.dto.UserCommentsDto;

public interface PinTestsDao {

	// 좌표 삽입 (ABTest 기준)
	void insertCoordinate(@Param("x") int x, @Param("y") int y, @Param("abTestId") int abTestId,
			@Param("userId") int userId);

	// AB테스트 좌표에 메모 남기기
	void insertComment(@Param("x") int x, @Param("y") int y, @Param("abTestId") int abTestId,
			@Param("userId") int userId, @Param("commentText") String commentText);

	// 특정 AbTestId에 대한 모든 댓글 가져오기
	List<UserCommentsDto> getCommentsByAbTestId(@Param("abTestId") int abTestId);

	// 코멘트 삭제 (IsDelete를 1로 업데이트)
	boolean deleteComment(@Param("commentId") String commentId);

	// 새로운 핀테스트 생성
	void insertPinTest(@Param("testName") String testName, @Param("fileName") String fileName,
			@Param("userId") int userId, @Param("departmentId") int departmentId);

	// pinTestId로 테스트 가져오기
	PinTestsDto getPinTestById(@Param("pinTestId") int pinTestId);

	// 핀테스트 좌표에 메모 남기기
	void insertCommentPinId(@Param("x") int x, @Param("y") int y, @Param("pinTestId") int pinTestId,
			@Param("userId") int userId, @Param("commentText") String commentText);

	// 특정 pinTestId에 대한 모든 댓글 가져오기
	List<UserCommentsDto> getCommentsByPinTestId(@Param("pinTestId") int pinTestId);

	// 핀테스트 목록 가져오기
	List<PinTestsDto> getAllPinTests(int departmentId);

	// 핀테스트 수정
	void updatePinTest(@Param("pinTestId") int pinTestId, @Param("testName") String testName,
			@Param("fileName") String fileName);

	// 핀테스트 삭제 (IsDelete를 1로 업데이트)
	void deletePinTest(@Param("pinTestId") int pinTestId);

	// 핀테스트 종료 (status를 1로 업데이트)
	void updatePinTestStatus(@Param("pinTestId") int pinTestId);
}
