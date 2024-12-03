package com.kb.star.dto;

public class ReportMemberDto {

	private int userId;
    private String userName;
    private String teamName;
    private int contributionCnt;

    // 기본 생성자
    public ReportMemberDto() {}

    // 모든 필드를 포함하는 생성자
    public ReportMemberDto(int userId, String userName, String teamName, int contributionCnt) {
        this.userId = userId;
        this.userName = userName;
        this.teamName = teamName;
        this.contributionCnt = contributionCnt;
    }

    // Getter와 Setter 메서드
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public int getContributionCnt() {
        return contributionCnt;
    }

    public void setContributionCnt(int contributionCnt) {
        this.contributionCnt = contributionCnt;
    }


}
