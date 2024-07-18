package com.kb.star.util;

import java.util.Map;
import java.util.List;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

public interface IdeaDao {

    // 아이디어 목록을 RoomID로 조회
    List<Ideas> selectIdeas(Map<String, Object> params);

    // 사용자가 투표한 아이디어 ID 조회
    Integer getVotedIdeaId(Map<String, Object> params);

    // 아이디어 투표 수 감소
    void decrementPickNum(int ideaId);

    // 아이디어 투표 수 증가
    void incrementPickNum(int ideaId);

    // RoomTitle로 MeetingRooms 조회
    MeetingRooms selectByTitle(String roomTitle);

    // 참여 상태 조회
    Integer checkParticipationStatus(Map<String, Object> params);

    // 참여 상태 업데이트
    void updateParticipationStatus(Map<String, Object> params);
}