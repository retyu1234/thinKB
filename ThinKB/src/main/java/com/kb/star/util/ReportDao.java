package com.kb.star.util;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.DepartmentReportDto;
import com.kb.star.dto.IdeaSummaryDto;
import com.kb.star.dto.ReportDetailsDto;
import com.kb.star.dto.ReportMemberDto;
import com.kb.star.dto.ReportsDto;

public interface ReportDao {

	int checkFinalReport(@Param("roomId") int roomId);
	void insertReport(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	void insertReportFalse(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	void updateReport(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	ReportDetailsDto getReportDetails(@Param("roomId") int roomId);
	ReportDetailsDto getReportDetailsFirst(@Param("roomId") int roomId);
	List<ReportsDto> getMyReportList(@Param("userId") int userId);
	List<IdeaSummaryDto> getIdeaSummaries(@Param("roomId") int roomId);
	
	// 관리자 - adminReportList.jsp
	// 보고서 목록
	List<DepartmentReportDto>getDepartmentReportList(@Param("managerId") int userId);
	// 필터링 - 팀
	List<String> getAllTeams();
	// 보고서 결재
	void approveReport(@Param("reportId") int reportId, @Param("isChoice") int isChoice);
	
	
	// 관리자 - reportDetail.jsp
	// 특정보고서 상세보기
    ReportDetailsDto getReportDetail(int reportId);
    // 특정보고서 참여자
    List<ReportMemberDto> getReportMember(int roomId);
    // 특정보고서 기안팀명 + 기안자 이름
    ReportMemberDto getReportAuthor(int reportId);
}
