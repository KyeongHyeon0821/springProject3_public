package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.BoardVo;

public interface BoardService {
	
    List<BoardVo> getBoardList();  
    
    void insertBoard(BoardVo vo);   
    
    BoardVo getBoardContent(int idx);  
    
    void updateReadCount(int idx);   
    
    void deleteBoard(int idx);    
    
    void updateBoard(BoardVo vo);

		int getBoardTotCnt(String search, String searchType);

		List<BoardVo> getBoardListPaging(int startIndexNo, int pageSize, String search, String searchType);    
    
}
