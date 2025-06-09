package com.spring.springProject3.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.springProject3.vo.BoardReplyVo;

public interface BoardReplyDao {
	
    List<BoardReplyVo> getReplies(int boardIdx);
  
    void insertReply(BoardReplyVo vo);
    
    void deleteReply(@Param("idx") int idx, @Param("mid") String mid);
    
    int getReplyCount(int boardIdx);

		void updateReply(BoardReplyVo vo);

}
