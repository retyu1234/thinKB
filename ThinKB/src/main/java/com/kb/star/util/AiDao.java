package com.kb.star.util;

import java.util.List;

import com.kb.star.dto.AiLogDto;

public interface AiDao {
	void insertAiLog(int userId, int roomId, String aiQuestion, String aiContent);
	List<AiLogDto> getUserAilog(int userId,int roomId);
}
