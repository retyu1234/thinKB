package com.kb.star.command.addFunction;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.AddVoteDao;
import com.kb.star.util.UserDao;

public class MakeVoteCommand implements AddCommand {

    SqlSession sqlSession;

    @Autowired
    public MakeVoteCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        String id = request.getParameter("id");
        String departmentId = request.getParameter("departmentId");
        
        String title = request.getParameter("title");
        String endDate = request.getParameter("endDate");
        String users = request.getParameter("users");
        String[] list = users.split(",");

        // 투표 항목 가져오기
        String[] optionTexts = request.getParameterValues("optionText");

//        for (String user : list) {
//            System.out.println(user);
//        }

        // MeetingRooms 회의방 신규 생성
        AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);
        dao.insertNewVote(title, departmentId, endDate, id);

        int addVoteId = dao.voteIdConfirm(departmentId);
//        System.out.println("addVoteId " + addVoteId);

        // 투표 항목 추가
        if (optionTexts != null) {
            for (String optionText : optionTexts) {
                if (optionText != null && !optionText.trim().isEmpty()) {
                    dao.insertVoteOption(addVoteId, optionText);
                }
            }
        }

        // 투표 참여자 선택
        dao.insertUserIntoVote(addVoteId, id);
        for (String user : list) {
            dao.insertUserIntoVote(addVoteId, user);
        }

        model.addAttribute("id", id);
        
        
    }
}
