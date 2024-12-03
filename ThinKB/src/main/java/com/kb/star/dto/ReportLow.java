package com.kb.star.dto;

import java.time.LocalDateTime;

public class ReportLow {

    private int reportId;
    private String reportTitle;
    private Integer isChoice;
    private LocalDateTime updatedAt;
    private String authorName;
    private String departmentName;
    private int authorId;
    
    
	public int getAuthorId() {
		return authorId;
	}
	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}
	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}

	public Integer getIsChoice() {
		return isChoice;
	}
	public void setIsChoice(Integer isChoice) {
		this.isChoice = isChoice;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
    
    
}
