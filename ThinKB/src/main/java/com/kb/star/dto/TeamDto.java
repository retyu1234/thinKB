package com.kb.star.dto;

public class TeamDto {

    private int teamId;
    private String teamName;
    private String departmentName;
    private int teamAdoptedReports;
    private int teamTotalReports;
    private int deptAdoptedReports;
    private int deptTotalReports;
    private double teamAdoptionPercentage;
    private int teamRank;
    
	public int getTeamRank() {
		return teamRank;
	}
	public void setTeamRank(int teamRank) {
		this.teamRank = teamRank;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public int getTeamAdoptedReports() {
		return teamAdoptedReports;
	}
	public void setTeamAdoptedReports(int teamAdoptedReports) {
		this.teamAdoptedReports = teamAdoptedReports;
	}
	public int getTeamTotalReports() {
		return teamTotalReports;
	}
	public void setTeamTotalReports(int teamTotalReports) {
		this.teamTotalReports = teamTotalReports;
	}
	public int getDeptAdoptedReports() {
		return deptAdoptedReports;
	}
	public void setDeptAdoptedReports(int deptAdoptedReports) {
		this.deptAdoptedReports = deptAdoptedReports;
	}
	public int getDeptTotalReports() {
		return deptTotalReports;
	}
	public void setDeptTotalReports(int deptTotalReports) {
		this.deptTotalReports = deptTotalReports;
	}
	public double getTeamAdoptionPercentage() {
		return teamAdoptionPercentage;
	}
	public void setTeamAdoptionPercentage(double teamAdoptionPercentage) {
		this.teamAdoptionPercentage = teamAdoptionPercentage;
	}
    
    
}
