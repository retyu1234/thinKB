package com.kb.star.util;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.AdminDto;
import com.kb.star.dto.ReportLow;
import com.kb.star.dto.TeamDto;

public interface AdminDao {
	
	// 메인 - 프로젝트 결재 현황 갯수
	int getReportCount(@Param("isChoice") Integer isChoice);
		
	// 모든 사용자 정보 가져오기
	List<AdminDto> getUserList();
	
	// 베스트 사용횟수 팀 정보(팀ID, 팀이름, 사용횟수) 가져오기
	// List<AdminDto> getBestUsage();
	// 베스트 사용횟수 팀 정보(팀ID, 팀이름, 사용횟수) + 채택률 가져오기
	List<AdminDto> getBestApproved();
	// 팀별 베스트 직원 목록(ID,이름,이미지)+토탈마일리지 가져오기
	List<AdminDto> getBestEmployees(@Param("teamName") String teamName);
	
	// 오늘 결재대기 보고서 리스트
	List<ReportLow> getTodayReports(@Param("today") LocalDate today);
	// 연간 채택된 보고서 리스트
	List<ReportLow> getYearlyAdoptedReports(@Param("year") int year);
	// 베스트 팀
	List<TeamDto> getBestTeams();

} 