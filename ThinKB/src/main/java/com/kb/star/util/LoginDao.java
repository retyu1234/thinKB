package com.kb.star.util;

import com.kb.star.dto.UsersDto;

public interface LoginDao {

	public UsersDto login(String userId, String password);
}
