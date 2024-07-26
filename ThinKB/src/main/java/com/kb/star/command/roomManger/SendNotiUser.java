package com.kb.star.command.roomManger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.util.RoomDao;

public class SendNotiUser implements RoomCommand {

	SqlSession sqlSession;
	@Autowired
	public SendNotiUser(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		String notiMessage = request.getParameter("notificationMessage");
		int roomId = Integer.parseInt(request.getParameter("roomId"));
	    String[] notiUserList=request.getParameterValues("selectedUsers");
	    model.addAttribute("roomId",roomId);
	    List<Integer> selectedEmployees = new ArrayList<Integer>();
	    if (notiUserList != null && notiUserList.length > 0) {
	        for (String notiUserId : notiUserList) {
	            selectedEmployees.add(Integer.parseInt(notiUserId));
	        }
	    }
	    
	    RoomDao dao = sqlSession.getMapper(RoomDao.class);
	    if (!selectedEmployees.isEmpty()) {
	        dao.insertNotifications(selectedEmployees, notiMessage);
	    } 
	}

}
