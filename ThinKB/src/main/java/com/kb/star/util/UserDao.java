package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.Teams;
import com.kb.star.dto.UserListDto;
import com.kb.star.dto.UsersDto;

// 마이바티스 인터페이스
public interface UserDao {

	public int departmentAdmin(int userId);
	List<UserListDto> userListAdmin(int departmentId);
	String getdepartmentName(int departmentId);
	List<Teams>getTeamName(int departmentId);
	void insertUser(UsersDto userDto);
}
