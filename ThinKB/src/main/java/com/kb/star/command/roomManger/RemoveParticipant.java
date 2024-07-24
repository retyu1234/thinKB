package com.kb.star.command.roomManger;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.util.RoomDao;

public class RemoveParticipant implements RoomCommand {

	SqlSession sqlSession;
	@Autowired
	public RemoveParticipant(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		
		Map<String,Object> map=model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		int roomId=Integer.parseInt(request.getParameter("roomId"));
		int userId=Integer.parseInt(request.getParameter("id"));
		RoomDao dao=sqlSession.getMapper(RoomDao.class);
		dao.deleteMembers(roomId, userId);
		model.addAttribute("roomId",roomId);
	}

}
