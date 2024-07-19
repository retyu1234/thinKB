package com.kb.star.util;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.ReportDetailsDto;

public interface ReportDao {

	int checkFinalReport(@Param("roomId") int roomId);
	void insertReport(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	void updateReport(@Param("roomId") int roomId,@Param("userId") int userId,@Param("reportTitle") String reportTitle,@Param("reportContent") String reportContent);
	ReportDetailsDto getReportDetails(@Param("roomId") int roomId);
	ReportDetailsDto getReportDetailsFirst(@Param("roomId") int roomId);
}
