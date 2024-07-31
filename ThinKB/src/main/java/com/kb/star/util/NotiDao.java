package com.kb.star.util;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;

public interface NotiDao {

	// 알림 목록(모든정보) 가져오기
	public List<NotiDto> getAllNoti(int userId);

	// 알림 테이블의 IdeaID컬럼으로 Ideas 테이블 정보 가져오기
	Ideas getIdeaById(int ideaId); // IdeasDto = Ideas

	// Ideas 테이블의 RoomID컬럼으로 MeetingRooms 테이블 정보 가져오기(roomTitle)
	MeetingRooms getRoomTitleById(int RoomID); // MeetingRoomsDto = MeetingRooms

	// 알림 읽음 상태 업데이트
	void updateReadStatus(int notificationID);

	// 알림 삭제
	void deleteNotification(int notificationID);

	// 실시간 알림
	List<NotiDto> findNewNotifications(int userId, Timestamp lastCheckTime);

	List<NotiDto> getUnreadNotificationsSinceLogin(@Param("userId") int userId,
			@Param("loginTime") Timestamp loginTime);

	// 알림 모두 읽기
	public int allReadNotification(int userId);

	void readNotification(int notificationId);

	//조건에 맞는 메세지 가져오기
	public List<NotiDto> getMessagesByIdeaId(@Param("userId")int userId, @Param("roomId") int roomId, @Param("ideaId") int ideaId);
}
