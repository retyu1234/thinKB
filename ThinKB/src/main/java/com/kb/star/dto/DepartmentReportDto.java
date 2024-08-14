package com.kb.star.dto;

public class DepartmentReportDto {
    private int reportId;          // r.ReportID
    private int roomId;            // r.RoomID
    private String reportTitle;    // r.ReportTitle
    private String createdAt;      // r.CreatedAt
    private String updatedAt;      // r.UpdatedAt
    private Integer isChoice;      // r.IsChoice
    private String authorName;     // u.UserName as AuthorName
    private String teamName;       // t.TeamName
    private String roomTitle;      // mr.RoomTitle
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
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
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
	public Integer getIsChoice() {
		return isChoice;
	}
	public void setIsChoice(Integer isChoice) {
		this.isChoice = isChoice;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
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
    

}
