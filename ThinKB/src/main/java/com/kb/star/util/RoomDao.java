package com.kb.star.util;

import com.kb.star.dto.MeetingRooms;

public interface RoomDao {

	MeetingRooms roomDetailInfo(int roomId);

	String roomTimerInfo(int roomId);

	void submitIdea(int id, int roomId, String title, String contents);

	void updateParticipantStage1(int roomId, int id);

	boolean isParticipantsStage1(int roomId, int id);


}
