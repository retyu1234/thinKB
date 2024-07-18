package com.kb.star.command.addFunction;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.AorBDao;

public class ABTestVote implements AddCommand {

	SqlSession sqlSession;
	@Autowired
	public ABTestVote(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");	
		int userId=(Integer)map.get("userId");
		int abTestId=Integer.parseInt(request.getParameter("abTestId"));
		int pick=Integer.parseInt(request.getParameter("pick"));
		AorBDao dao=sqlSession.getMapper(AorBDao.class);
		if(pick==1) {
			dao.insertABResult(abTestId,userId,pick);
			dao.voteForVariantA(abTestId);
		}else if(pick==0) {
			dao.insertABResult(abTestId, userId, pick);
			dao.voteForVariantB(abTestId);
		}
		
	}

}
