package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

public interface RoomDao {

	MeetingRooms roomDetailInfo(int roomId);

	String roomTimerInfo(int roomId);

	void submitIdea(int id, int roomId, String title, String contents);

	void updateParticipantStage1(int roomId, int id);

	boolean isParticipantsStage1(int roomId, int id);

	List<Ideas> ideaInfo(int roomId, int id);

	void isDeleteUpdate(int id, int roomId);

	List<Ideas> ideaList(int roomId, int stage);

	void updateParticipantStage2(int roomId);

	List<Integer> RoomForUserList(int roomId);

	void insertForwardStage2(Integer list, int roomId);

	void stageTwoTimerUpdate(int roomId, String formattedTime);

	void updateRejectLog(int roomId, int rejectId, String rejectContents);

	void isRejectUpdate(int rejectId);

	String rejectLogSelect(int ideaID);

	void makeNotification(Integer user, int ideaNum, String notification);



}
