package com.kb.star.util;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.UsersDto;

public interface LoginDao {

	public UsersDto login(String userId);
	void updatePassword(int userId,String password);
	UsersDto checkUser(@Param("userId") int userId,@Param("birth")String birth);
}

