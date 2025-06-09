package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.BoardVo;

public interface BoardDao {

    List<BoardVo> getBoardList();

    void insertBoard(@Param("vo") BoardVo vo);

    BoardVo getBoardContent(@Param("idx") int idx);

    void updateReadCount(@Param("idx") int idx);

    void deleteBoard(@Param("idx") int idx);

    int updateBoard(@Param("vo") BoardVo vo);

		int getBoardTotCnt(@Param("search") String search, @Param("searchType") String searchType);

		List<BoardVo> getBoardListPaging(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchType") String searchType);
}
