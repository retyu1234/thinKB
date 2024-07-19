package com.kb.star.util;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.ReportDetailsDto;
import com.kb.star.dto.ReportsDto;

public interface ReportDao {

	int checkFinalReport(@Param("roomId") int roomId);
	void insertReport(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	void updateReport(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	ReportDetailsDto getReportDetails(@Param("roomId") int roomId);
	ReportDetailsDto getReportDetailsFirst(@Param("roomId") int roomId);
	List<ReportsDto> getMyReportList(@Param("userId") int userId);
}
