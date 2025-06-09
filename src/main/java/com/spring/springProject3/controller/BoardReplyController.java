package com.spring.springProject3.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.BoardReplyService;
import com.spring.springProject3.vo.BoardReplyVo;

@Controller
@RequestMapping("/reply")
public class BoardReplyController {

  @Autowired
  BoardReplyService replyService;
  
  // 댓글 입력 처리
  @PostMapping("/insert")
  public String insertReply(BoardReplyVo vo, HttpSession session) {
      String mid = (String) session.getAttribute("sMid");
      if (mid == null) return "redirect:/message/loginRequired";

      vo.setMid(mid);
      vo.setNickName((String) session.getAttribute("sNickName"));
      replyService.insertReply(vo);
      return "redirect:/board/content?idx=" + vo.getBoardIdx();
  }
  
  // 댓글 삭제 처리
  @GetMapping("/delete")
  public String deleteReply(@RequestParam int idx, @RequestParam int boardIdx, HttpSession session) {
    String mid = (String) session.getAttribute("sMid");
    replyService.deleteReply(idx, mid);
    return "redirect:/board/content?idx=" + boardIdx;
  }
  
  // 댓글 수정 처리
  @PostMapping("/update")
  public String replyUpdatePost(BoardReplyVo vo) {
      replyService.updateReply(vo); // 댓글 내용 업데이트
      return "redirect:/board/content?idx=" + vo.getBoardIdx();
  }

}

