package com.kb.star.util;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.kb.star.dto.UserCommentsDto;

public interface UserCommentsDao {

    // 좌표 삽입
    void insertCoordinate(@Param("x") int x, @Param("y") int y, @Param("abTestId") int abTestId, @Param("userId") int userId);

    // 댓글 삽입
    void insertComment(@Param("x") int x, @Param("y") int y, @Param("abTestId") int abTestId, @Param("userId") int userId, @Param("commentText") String commentText);

    // 특정 AbTestId에 대한 모든 댓글 가져오기
    List<UserCommentsDto> getCommentsByAbTestId(@Param("abTestId") int abTestId);
}
