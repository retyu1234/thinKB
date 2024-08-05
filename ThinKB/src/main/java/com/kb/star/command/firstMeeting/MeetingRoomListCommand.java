package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.Teams;
import com.kb.star.util.UserDao;

public class MeetingRoomListCommand implements FirstMeetingCommand {
    SqlSession sqlSession;

    public MeetingRoomListCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        int id = (Integer) map.get("id");
        int page = (Integer) map.get("page");

        int pageSize = 8; // 10개에서 8개로 수정
        int start = (page - 1) * pageSize;

        // 진행중인 회의방 영역
        UserDao dao = sqlSession.getMapper(UserDao.class);

        List<MeetingRooms> roomList = dao.myAllMeetingRoomPaginated(id, start, pageSize);
        int totalRooms = dao.countMyAllMeetingRooms(id);
        int totalPages = (int) Math.ceil((double) totalRooms / pageSize);

        // 아이디어 목록을 저장할 맵
        Map<Integer, List<Ideas>> roomIdeasMap = new HashMap<>();

        // 각 회의방에 대한 아이디어 리스트를 맵에 추가
        for (MeetingRooms room : roomList) {
            List<Ideas> ideasList = sqlSession.selectList("com.kb.star.util.RoomDao.yesPickIdeaList", room.getRoomId());
            roomIdeasMap.put(room.getRoomId(), ideasList);
        }

        model.addAttribute("roomList", roomList);
        model.addAttribute("roomIdeasMap", roomIdeasMap);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        String department = dao.userDepartment(id);
        List<Teams> teamDto = dao.myDepartmentTeams(department);
        model.addAttribute("teamInfo", teamDto);
    }
}
