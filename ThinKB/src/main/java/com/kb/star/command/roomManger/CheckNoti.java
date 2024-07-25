package com.kb.star.command.roomManger;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.NotiDao;

public class CheckNoti implements NotiCommand {

    private SqlSession sqlSession;
    @Autowired
    public CheckNoti(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Map<String, Object> model) {
        int userId = ((Number) model.get("userId")).intValue();
        long lastCheckTimeLong = ((Number) model.get("lastCheckTime")).longValue();
        Timestamp lastCheckTime = new Timestamp(lastCheckTimeLong);

        NotiDao dao = sqlSession.getMapper(NotiDao.class);
        List<NotiDto> dto = dao.findNewNotifications(userId, lastCheckTime);
        model.put("notifications", dto);
    }
}
