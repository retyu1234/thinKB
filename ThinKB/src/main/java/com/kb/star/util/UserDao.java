package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.UsersDto;

// 마이바티스 인터페이스
public interface UserDao {

	String userDepartment(int id);

	void insertNewRoom(String title, String content, String departmentId, String teamId, String id, String endDate);

	List<UsersDto> userList(String department, int id);

	int roomNumConfirm(String id);

	void insertNewTimer(int roomNum, String formattedTime);

	void insertUserIntoRoom(int roomNum, String id);

	void insertThisStage0(String id, int roomNum);

	void insertForwardStage1(String id, int roomNum);

	List<MeetingRooms> myMeetingRoom(int id);

}
