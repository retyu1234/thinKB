package com.kb.star.dto;

public class MeetingRoomStats {
    private int ongoingMeetings;
    private int completedMeetings;
    private int totalMeetings;
    private int totalContribution;
	public int getOngoingMeetings() {
		return ongoingMeetings;
	}
	public void setOngoingMeetings(int ongoingMeetings) {
		this.ongoingMeetings = ongoingMeetings;
	}
	public int getCompletedMeetings() {
		return completedMeetings;
	}
	public void setCompletedMeetings(int completedMeetings) {
		this.completedMeetings = completedMeetings;
	}
	public int getTotalMeetings() {
		return totalMeetings;
	}
	public void setTotalMeetings(int totalMeetings) {
		this.totalMeetings = totalMeetings;
	}
	public int getTotalContribution() {
		return totalContribution;
	}
	public void setTotalContribution(int totalContribution) {
		this.totalContribution = totalContribution;
	}
    
}
