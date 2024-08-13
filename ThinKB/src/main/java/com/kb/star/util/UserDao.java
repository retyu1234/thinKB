package com.kb.star.util;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.ContributionDetail;
import com.kb.star.dto.MeetingRoomStats;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.Teams;
import com.kb.star.dto.TodoDto;
import com.kb.star.dto.UserListDto;
import com.kb.star.dto.UsersDto;

// 마이바티스 인터페이스
public interface UserDao {

	String userDepartment(int id);

	public int departmentAdmin(int userId);

	List<UserListDto> userListAdmin(int departmentId);

	UserListDto userListUser(int userId);

	String getdepartmentName(int departmentId);

	List<Teams> getTeamName(int departmentId);

	// 회원등록
	void insertUser(int userId, String userName, String email, String birth, String password, int departmentId,
			int teamId);

	String userDepartment(String name);

	void insertNewRoom(String title, String content, String departmentId, String teamId, String id, String endDate);

	List<UsersDto> userList(String department, int id);

	int roomNumConfirm(String id);


	void insertNewTimer(int roomNum, String formattedTime);

	void insertUserIntoRoom(int roomNum, String id);

	void insertThisStage0(String id, int roomNum);

	void insertForwardStage1(String id, int roomNum);

	// 프로필사진 업데이트
	void updateProfileImg(int userId, String profileImg);

	// 회원삭제
	void deleteUser(int userId, boolean isDelete);

	List<MeetingRooms> myMeetingRoom(int id);

	List<Teams> myDepartmentTeams(String department);

	List<MeetingRooms> myAllMeetingRoom(int id);
	

	// 검색된 직원 목록 조회
	List<UserListDto> searchEmployees(Map<String, Object> params);

	// 검색된 직원 수 조회
	int countEmployees(Map<String, Object> params);
	
	//11:23 추가
	int userDepartmentId (int id);

	//페이지네이션
	List<MeetingRooms> myAllMeetingRoomPaginated(@Param("userId") int userId, @Param("start") int start, @Param("pageSize") int pageSize);
	int countMyAllMeetingRooms(@Param("userId") int userId);
	
	List<TodoDto> getUserTodoListForToday(int userId);
	
	List<TodoDto> getUserTodoListByDate(@Param("userId") int userId, @Param("date") String date);
   
	MeetingRoomStats getMeetingRoomStats(int userId);
    
	List<ContributionDetail> getUserContributions(int userId);
	
	MeetingRoomStats getMeetingRoomStatsAdmin(int userId);

}
