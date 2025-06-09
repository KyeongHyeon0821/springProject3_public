package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.service.QnaService;
import com.spring.springProject3.vo.MemberVo;
import com.spring.springProject3.vo.PageVo;
import com.spring.springProject3.vo.QnaVo;

@Controller
@RequestMapping("/qna")
public class QnaController {

	@Autowired
	QnaService qnaService;

	@Autowired
	Pagination pagination;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
	MemberService memberService;
	
	// qna 리스트 보기
	@RequestMapping(value = "/qnaList", method = RequestMethod.GET)
	public String qnaListGet(Model model, HttpSession session,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "qnaAnswer", defaultValue = "전체", required = false) String qnaAnswer
		) {
		String mid = (String) session.getAttribute("sMid");
		if(mid == null) return "redirect:/message/loginRequired";
		PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "qna", mid, qnaAnswer); // (페이지번호,한 페이지분량,section,part,검색어)
		List<QnaVo> vos = null;
		if(qnaAnswer.equals("전체")) vos = qnaService.getQnaList(pageVo.getStartIndexNo(), pageSize, mid);
		else vos = qnaService.getQnaListQnaAnswer(pageVo.getStartIndexNo(), pageSize, mid, qnaAnswer);

		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("qnaAnswer", qnaAnswer);

		return "qna/qnaList";
	}

	// qna 입력 폼 보기
	@RequestMapping(value = "/qnaInput", method = RequestMethod.GET)
	public String qnaInputGet(Model model, HttpSession session,
			@RequestParam(name = "qnaSw", defaultValue = "q", required = false) String qnaSw) {
		String mid = (String) session.getAttribute("sMid");
		MemberVo vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("qnaSw", qnaSw);
		model.addAttribute("vo", vo);
		return "qna/qnaInput";
	}

  // qna '글올리기'와 '답변글 올리기'에서 이곳을 모두 사용하고 있다. 
  @Transactional
  @RequestMapping(value = "/qnaInput", method = RequestMethod.POST)
  public String qnaListPost(QnaVo vo, HttpSession session) {
      // content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/qna/폴더에 저장시켜준다.
     if(vo.getContent().indexOf("src=\"/") != -1) {
        projectProvide.imgCheck(vo.getContent(), "ckeditor", "qna");   // 이미지를 ckeditor폴더에서 qna폴더로 복사하기
        
        // 이미지 복사작업이 끝나면, qna폴더에 실제로 저장된 파일명을 DB에 저장시켜준다.(/resources/data/ckeditor/  ==>> /resources/data/qna/)
        vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/qna/"));
     }
     
     //System.out.println("vo : " + vo);
     // 앞에서 ckeditor의 그림작업이 끝나고 일반작업들을 수행시킨다.
      
//     int level = Integer.parseInt((String) session.getAttribute("sLevel"));
     int level = (int) session.getAttribute("sLevel");
     
     // 먼저 idx 설정하기(기존글의 idx를 검색해서 '가장 큰값+1'로 저장한다. 단, 없을경우(null)는 mapper에서 'ifnull()함수 사용하여 0으로 가져와서 처리한다.)
     int newIdx = qnaService.getMaxIdx() + 1;
     vo.setIdx(newIdx);
     
     // 회원의 고유등급 저장하기
     vo.setAnsLevel(level);
     
     // qnaIdx 설정하기(나중에 이값(qnaIdx) 내림차순으로 리스트를 출력하게 된다.
     // 설정방법 : 질문글(q)일경우는 자신글(질문글)의 고유번호인 idx를 갖고, 답변글(a)일경우는 원본글의 idx값(앞의 입력폼에서 hidden으로 넘겨받은는다)을 갖는다.
     if(vo.getQnaSw().equals("q")) vo.setQnaIdx(newIdx);
     else {     
        if(level == 0) vo.setTitle(vo.getTitle().replace("(Re)", "<font color=red>(Re)</font>"));
     }
     
     if(vo.getOpenSw() != null && !vo.getOpenSw().equals("") & !vo.getOpenSw().equals("OK")) vo.setOpenSw("NO");   // 비공개
     else vo.setOpenSw("OK");   // 공개
     //System.out.println("vo2222 : " + vo);
     
     // 질문글이나 답변글을 DB에 저장한다.
     qnaService.qnaInputOk(vo);
     // 답변여부 테이블에 대한 저장을 한다.(qnaAdmin테이블에 대한 작업이다.)
     // qnaAdmin테이블에는 질문글이라면 '답변대기'라고 1건의 레코드를 저장(insert)해야하고, 답변글이라면 기존에 올라온 원본글(질문글)글번호를 찾아서, 그글에 업데이트한다. 그중에서도 관리자가 답변달았을때만 '답변완료'라고 업데이트한다.(일반 사용자가 답변을 달았을때는 답변테이블에는 아무작업도 하지 않는다. 즉, 관리자만이 답변을 달았을때만 qnaAdmin테이블에 Update한다.)
     if(vo.getQnaSw().equals("q"))   {
        qnaService.qnaAdminInputOk(vo.getQnaIdx());
        return "redirect:/message/qnaInputOk";
     }
     else if(vo.getQnaSw().equals("a") && level == 0) {
        qnaService.qnaAdminAnswerUpdateOk(vo.getQnaIdx());
        return "redirect:/message/qnaInputAdminOk";
     }
     else return "redirect:/message/qnaInputUserOk";
  }

	// qna 게시글 상세보기 폼 보기
	@RequestMapping(value = "/qnaDetail", method = RequestMethod.GET)
	public String qnaDetailGet(int idx, Model model, HttpSession session,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name = "level", defaultValue = "0", required = false) String level,
			@RequestParam(name = "qnaSw", defaultValue = "q", required = false) String qnaSw) {
		QnaVo vo = qnaService.getQnaDetail(idx);
		model.addAttribute("vo", vo);
		
		String imsiMid = (String) session.getAttribute("sMid");
		MemberVo memberVo = memberService.getMemberIdCheck(imsiMid);
		model.addAttribute("memberVo", memberVo);

		return "qna/qnaDetail";
	}
	// qna 게시글 상세보기 폼 보기
	@RequestMapping(value = "/qnaDetail", method = RequestMethod.POST)
	public String qnaDetailPost(QnaVo vo, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name = "level", defaultValue = "0", required = false) String level) {
		
		model.addAttribute("vo", vo);
		
		return "qna/qnaDetail";
	}
	

	// qna 게시글 삭제하기
	@Transactional
	@RequestMapping(value = "/qnaDelete", method = RequestMethod.GET)
	public String qnaDeleteGet(HttpSession session, int idx) {
		//int level = Integer.parseInt((String) session.getAttribute("sLevel"));

		QnaVo vo = qnaService.getQnaContent(idx);

		// DB에서 자료를 삭제또는 Update시켜준다.
		// qna글(질문글과 답변글 모두 합친글)이 1개밖에 없다면 바로 삭제처리한다.(아래 (a)조건으로 처리한다)
		// ※ qna글이 2개 이상이라면 답변글이 존재하는 경우이다. 아래는 답변글에서의 삭제처리 조건이다.
		// 일반 '사용자의 답변글'의 삭제는 바로 삭제처리한다.
		// '관리자의 답변글'을 삭제한다면 qna테이블에서는 삭제처리하고, qnaAdmin테이블에서는 'qnaAnswer'필드를 '답변대기'로
		// update처리해야한다.
		// (a)'문의글'의 삭제는 답변 댓글이 없다면 qna테이블에서 삭제하고, 또 qnaAdmin테이블에서도 qna테이블의 idx와 같은
		// qnaAdmin테이블에서의 qnaIdx를 찾아서 삭제해야한다.
		// 만약 '문의글' 삭제시, 답변글이 있다면 문의글은 qna테이블의 delCheck필드의 값을 'OK'로 update처리한다. 그리고
		// 'qnaList.jsp'에서 'delCheck'필드가 'OK'인 자료는 '삭제되었습니다.'라는 문구로 출력시켜준다.
		// 관리자가 질문글을 삭제처리할시는 qna테이블과 qnaAdmin테이블의 관련자료들을 모두 삭제한다.
		int qnaIdxCount = qnaService.getQnaIdxCheck(vo.getQnaIdx()); // 해당 게시글의 qnaIdx값과 같은 자료가 몇건이 있는지 구해온다.
		if (qnaIdxCount == 1)
			qnaService.setQnaDelete(idx); // qna테이블과 qnaAdmin테이블을 각각 삭제처리한다.(qnaAdmin테이블을 먼저 삭제처리해야 한다.)
		else if (vo.getQnaSw().equals("a") && vo.getAnsLevel() != 0)
			qnaService.setQnaDeleteOne(idx); // qna테이블만 삭제처리한다.
		else if (vo.getQnaSw().equals("a") && vo.getAnsLevel() == 0) { // qna테이블은 삭제처리하고, qnaAdmin테이블은 update처리한다.
			qnaService.setQnaDelete(idx);
			qnaService.setQnaAdminUpdate(vo.getQnaIdx());
		} 
		else if (vo.getQnaSw().equals("q") && qnaIdxCount > 1) {
			System.out.println("답변글이 1개 이상있을때 통과..");
			qnaService.setQnaDelCheckUpdate(idx); // 하위 답변글이 존재한다면 '질문글' 은 'delCheck필드를 OK'처리한다.
		//else if ((vo.getQnaSw().equals("q") && level == 0 && qnaIdxCount == 0) || (vo.getQnaSw().equals("q") && qnaIdxCount == 0))
		}
		else if (vo.getQnaSw().equals("q") && qnaIdxCount == 0)
			qnaService.setQnaDelete(idx); // 질문글을 삭제시는 '질문글/답변글'을 합쳐서 1개밖에 없으면 '질문글/답변글' 모두 삭제처리한다.

		// DB삭제작업이 끝나고, content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/qna/폴더에서
		// 삭제시켜준다.
		if (vo.getContent().indexOf("src=\"/") != -1) {
			ProjectProvide.imagesDelete(vo.getContent(), "qna"); // qna폴더의 이미지들을 모두 삭제하기
		}
		return "redirect:/message/qnaDeleteOk";
	}

	// qna 게시글 수정 폼 보기
	@RequestMapping(value = "/qnaUpdate", method = RequestMethod.GET)
	public String qnaUpdateGet(Model model, int idx,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name = "level", defaultValue = "0", required = false) String level) {
		QnaVo vo = qnaService.getQnaContent(idx);
		if (vo.getContent().indexOf("src=\"/") != -1)
			qnaService.imgBackup(vo.getContent());

		model.addAttribute("vo", vo);

		return "qna/qnaUpdate";
	}

	// qna 게시글 수정하기
	@SuppressWarnings("unlikely-arg-type")
	@RequestMapping(value = "/qnaUpdate", method = RequestMethod.POST)
	public String qnaUpdatePost(Model model, QnaVo vo,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "search", defaultValue = "", required = false) String search,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString) {
		QnaVo dbVo = qnaService.getQnaContent(vo.getIdx());

		if (!dbVo.getContent().equals(vo.getIdx())) {
			if (dbVo.getContent().indexOf("src=\"/") != -1)
				qnaService.imgDelete(dbVo.getContent());

			vo.setContent(vo.getContent().replace("/data/qna/", "/data/ckeditor/"));

			if (vo.getContent().indexOf("src=\"/") != -1)
				qnaService.imgCheck(vo.getContent());

			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/qna/"));
		}
		if (vo.getOpenSw() == null)
			vo.setOpenSw("OK");
		else
			vo.setOpenSw("NO");

		int res = qnaService.setQnaUpdate(vo);

		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);

		if (res != 0)
			return "redirect:/message/qnaUpdateOk";
		else
			return "redirect:/message/qnaUpdateNo?idx=" + vo.getIdx();
	}
	
	// qna 검색결과 보기
	@RequestMapping(value = "/qnaSearch", method = RequestMethod.POST)
	public String qnaSearchPost(Model model, HttpSession session,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name = "search", defaultValue = "", required = false) String search
		) {
		//String mid = (String) session.getAttribute("sMid");
		PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "qnaSearch", search, searchString); // (페이지번호,한 페이지분량,section,part,검색어)
		List<QnaVo> vos = qnaService.getQnaSearchList(pageVo.getStartIndexNo(), pageSize, search, searchString);

		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);

		return "qna/qnaSearch";
	}
	
}
