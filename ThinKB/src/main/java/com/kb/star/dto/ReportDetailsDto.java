package com.kb.star.dto;

public class ReportDetailsDto {

    private int reportId;
    private int roomId;
    private int userId;
    private String reportTitle;
    private String reportContent;
    private boolean isFinal;
    private String createdAt;
    private String updatedAt;
    private String departmentName;
    private String teamName;
    private String roomTitle;
    private String roomManagerName;
    private String yesPickUserName;
	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public boolean isFinal() {
		return isFinal;
	}
	public void setFinal(boolean isFinal) {
		this.isFinal = isFinal;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getRoomTitle() {
		return roomTitle;
	}
	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}
	public String getRoomManagerName() {
		return roomManagerName;
	}
	public void setRoomManagerName(String roomManagerName) {
		this.roomManagerName = roomManagerName;
	}
	public String getYesPickUserName() {
		return yesPickUserName;
	}
	public void setYesPickUserName(String yesPickUserName) {
		this.yesPickUserName = yesPickUserName;
	}

}
