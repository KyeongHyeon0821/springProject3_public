package com.spring.springProject3.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.BoardReplyService;
import com.spring.springProject3.service.BoardService;
import com.spring.springProject3.vo.BoardReplyVo;
import com.spring.springProject3.vo.BoardVo;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;
    
    @Autowired
    BoardReplyService boardReplyService;

    // 게시글 목록 보기
    @GetMapping("/list")
    public String boardListGet(Model model,
        @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
        @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
        @RequestParam(name="search", defaultValue = "", required = false) String search,
        @RequestParam(name="searchType", defaultValue = "tc", required = false) String searchType
    ) {
        int totRecCnt = boardService.getBoardTotCnt(search, searchType); // 전체 게시글 수
        int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;
        
        int blockSize = 10;
        int curBlock = (pag - 1) / blockSize;
        int startPage = curBlock * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totPage);

        List<BoardVo> vos = boardService.getBoardListPaging(startIndexNo, pageSize, search, searchType);

        Map<Integer, Integer> replyCountMap = new HashMap<>();
        for (BoardVo vo : vos) {
            int count = boardReplyService.getReplyCount(vo.getIdx());
            replyCountMap.put(vo.getIdx(), count);
        }
        
        model.addAttribute("replyCountMap", replyCountMap);
        model.addAttribute("vos", vos);
        model.addAttribute("pag", pag);
        model.addAttribute("totPage", totPage);
        model.addAttribute("curScrStartNo", curScrStartNo);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("search", search);
        model.addAttribute("searchType", searchType);

        return "board/boardList";
    }

    // 게시글 작성 폼
    @GetMapping("/input")
    public String boardInputGet(HttpSession session) {
        if (session.getAttribute("sMid") == null) return "redirect:/message/loginRequired";
        return "board/boardInput";
    }

    // 게시글 작성 처리
    @PostMapping("/input")
    public String boardInputPost(BoardVo vo, HttpSession session) {
        String mid = (String) session.getAttribute("sMid");
        if (mid == null) return "redirect:/message/loginRequired";
        vo.setMid(mid);
        boardService.insertBoard(vo);
        return "redirect:/message/boardInputOk";
    }

    // 게시글 상세 보기
    @GetMapping("/content")
    public String boardDetail(@RequestParam("idx") int idx, Model model, HttpSession session) {
        BoardVo vo = boardService.getBoardContent(idx);
        boardService.updateReadCount(idx);

        model.addAttribute("vo", vo);
        model.addAttribute("sMid", session.getAttribute("sMid"));
        model.addAttribute("sLevel", session.getAttribute("sLevel"));
        
        List<BoardReplyVo> replyList = boardReplyService.getReplies(idx);
        model.addAttribute("replyList", replyList);
        
        return "board/boardContent";
    }

    // 게시글 삭제 처리
    @GetMapping("/delete")
    public String boardDelete(@RequestParam("idx") int idx, HttpSession session) {
      String sMid = (String) session.getAttribute("sMid");
      Integer sLevel = (Integer) session.getAttribute("sLevel");

      if (sMid == null) return "redirect:/message/loginRequired";

      BoardVo vo = boardService.getBoardContent(idx);
      if (sMid.equals(vo.getMid()) || (sLevel != null && sLevel == 0)) {
          boardService.deleteBoard(idx);
          return "redirect:/message/boardDeleteOk";
      }
      return "redirect:/message/boardDeleteOk";
    }

    // 게시글 수정 폼
    @GetMapping("/update")
    public String boardUpdateGet(@RequestParam("idx") int idx, HttpSession session, Model model) {
        String sMid = (String) session.getAttribute("sMid");
        if (sMid == null) return "redirect:/message/loginRequired";

        BoardVo vo = boardService.getBoardContent(idx);
        if (!sMid.equals(vo.getMid())) return "redirect:/message/unauthorized";

        model.addAttribute("vo", vo);
        return "board/boardUpdate";
    }

    // 게시글 수정 처리
    @RequestMapping(value="/update", method=RequestMethod.POST)
    public String boardUpdatePost(BoardVo vo, HttpSession session) {
        boardService.updateBoard(vo); // 리턴값 받을 필요 없음
        return "redirect:/message/boardUpdateOk?idx=" + vo.getIdx();
    }

}
