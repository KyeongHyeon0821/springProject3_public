package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.BoardDao;
import com.spring.springProject3.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    BoardDao boardDao;

    @Override
    public List<BoardVo> getBoardList() {
        return boardDao.getBoardList();
    }

    @Override
    public void insertBoard(BoardVo vo) {
        boardDao.insertBoard(vo);
    }

    @Override
    public BoardVo getBoardContent(int idx) {
        return boardDao.getBoardContent(idx);
    }

    @Override
    public void updateReadCount(int idx) {
        boardDao.updateReadCount(idx);
    }

    @Override
    public void deleteBoard(int idx) {
        boardDao.deleteBoard(idx);
    }

    @Override
    public void updateBoard(BoardVo vo) {
        int res = boardDao.updateBoard(vo);
        System.out.println("=== 수정 결과 res: " + res);
    }

    @Override
    public int getBoardTotCnt(String search, String searchType) {
        return boardDao.getBoardTotCnt(search, searchType);
    }

    @Override
    public List<BoardVo> getBoardListPaging(int startIndexNo, int pageSize, String search, String searchType) {
        return boardDao.getBoardListPaging(startIndexNo, pageSize, search, searchType);
    }

}
