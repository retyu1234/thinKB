package com.kb.star.command.firstMeeting;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import java.util.List;
import com.kb.star.dto.Ideas;  // Idea DTO 클래스 import

public class FirstMeeting implements FirstMeetingCommand {

    private SqlSession sqlSession;
    
    @Autowired
    public FirstMeeting(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
       
    }
}
