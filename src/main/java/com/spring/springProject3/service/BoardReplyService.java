package com.spring.springProject3.service;

import java.util.List;
import com.spring.springProject3.vo.BoardReplyVo;

public interface BoardReplyService {
    
	List<BoardReplyVo> getReplies(int boardIdx);
  
	void insertReply(BoardReplyVo vo);
  
	void deleteReply(int idx, String mid);
	
	int getReplyCount(int boardIdx);

	void updateReply(BoardReplyVo vo);

}
