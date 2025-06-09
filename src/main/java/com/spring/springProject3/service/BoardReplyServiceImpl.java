package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.BoardReplyDao;
import com.spring.springProject3.vo.BoardReplyVo;

@Service
public class BoardReplyServiceImpl implements BoardReplyService {

    @Autowired
    BoardReplyDao boardReplyDao;

    @Override
    public List<BoardReplyVo> getReplies(int boardIdx) {
        return boardReplyDao.getReplies(boardIdx);
    }

    @Override
    public void insertReply(BoardReplyVo vo) {
        boardReplyDao.insertReply(vo);
    }

    @Override
    public void deleteReply(int idx, String mid) {
        boardReplyDao.deleteReply(idx, mid);
    }
    
    @Override
    public int getReplyCount(int boardIdx) {
      return boardReplyDao.getReplyCount(boardIdx);
    }
    
    @Override
    public void updateReply(BoardReplyVo vo) {
        boardReplyDao.updateReply(vo);
    }

}
