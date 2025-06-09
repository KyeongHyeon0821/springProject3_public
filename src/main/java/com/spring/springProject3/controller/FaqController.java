package com.spring.springProject3.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.FaqService;
import com.spring.springProject3.vo.FaqVo;
import com.spring.springProject3.vo.PageVo;

@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Autowired
	FaqService faqService;
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	ProjectProvide projectProvide;
	
	
	// FAQ 관리자 폼 보기
	@RequestMapping(value = "/adFaqList", method = RequestMethod.GET)
	public String adFaqListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="category", defaultValue = "전체", required = false) String category,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString	
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"adFaqList",category,searchString);
		
		List<FaqVo> vos = faqService.getFaqList(pageVo.getStartIndexNo(),pageVo.getPageSize(), category, searchString);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "admin/faq/adFaqList";
	}
	
	// FAQ 입력 폼 보기
	@RequestMapping(value = "/adFaqInput", method = RequestMethod.GET)
	public String adFaqInputGet() {
		return "admin/faq/adFaqInput";
	}
	
	// FAQ 입력 처리
	@RequestMapping(value = "/adFaqInput", method = RequestMethod.POST)
	public String adFaqInputPost(FaqVo vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) {
			faqService.imgCheck(vo.getContent(), "ckeditor", "faq");
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/faq/"));
		}
		int res = faqService.setAdFaqInputOk(vo);
		
		if(res != 0) return "redirect:/message/adFaqInputOk";
		else return "redirect:/message/adFaqInputNo";
	}
	
	// FAQ 내용보기
	@RequestMapping(value = "/adFaqDetail", method = RequestMethod.GET)
	public String adFaqDetailGet(Model model, HttpSession session, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="category", defaultValue = "전체", required = false) String category		
		) {
		FaqVo vo = faqService.getFaqDetail(idx);
		
		model.addAttribute("vo", vo);
		
		return "admin/faq/adFaqDetail";
	}
	
	// FAQ 내용보기
	@RequestMapping(value = "/adFaqDetail", method = RequestMethod.POST)
	public String adFaqDetailPost(Model model, HttpSession session, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="category", defaultValue = "전체", required = false) String category		
			) {
		// 이전글/다음글 가져오기
		FaqVo preVo = faqService.getPreNextSearch(idx, "pre");
		FaqVo nextVo = faqService.getPreNextSearch(idx, "next");
		
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		
		return "admin/faq/adFaqDetail";
	}
	
	// FAQ 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/adFaqDelete", method = RequestMethod.POST)
	public String adFaqDeletePost(String idxSelect) {
		int[] idxArray = new int[20];
		if(idxSelect.indexOf("/") == -1) {
			idxArray[0] = Integer.parseInt(idxSelect);
		}
		else {
			String[] idxStrArray = idxSelect.split("/");
			for(int i=0; i<idxStrArray.length; i++) {
				idxArray[i] = Integer.parseInt(idxStrArray[i]);
			}
		}
		
		int res = 0;
		for(int i=0; i<idxArray.length; i++) {
			if(idxArray[i] == 0) break;
			// 게시글에 사진이 있다면 실제 파일을 faq폴더에서 삭제시킨다.
			FaqVo vo = faqService.getFaqDetail(idxArray[i]);
			if(vo.getContent().indexOf("src=\"/") != -1) {
				projectProvide.imgDelete(vo.getContent(), "faq");
			}
			// 사진작업완료 후 DB에 저장된 실제 정보 레코드를 삭제처리한다.
			res = faqService.setFaqDelete(idxArray[i]);
		}

		return res + "";
	}
	
	// FAQ 개별내용 삭제 처리
	@RequestMapping(value = "/adFaqDetailDelete", method = RequestMethod.GET)
	public String adFaqDetailDeleteGet(String idx) {
		int[] idxArray = new int[20];
		if(idx.indexOf("/") == -1) {
			idxArray[0] = Integer.parseInt(idx);
		}
		else {
			String[] idxStrArray = idx.split("/");
			for(int i=0; i<idxStrArray.length; i++) {
				idxArray[i] = Integer.parseInt(idxStrArray[i]);
			}
		}
		
		int res = 0;
		for(int i=0; i<idxArray.length; i++) {
			if(idxArray[i] == 0) break;
			// 게시글에 사진이 있다면 실제 파일을 faq폴더에서 삭제시킨다.
			FaqVo vo = faqService.getFaqDetail(idxArray[i]);
			if(vo.getContent().indexOf("src=\"/") != -1) {
				projectProvide.imgDelete(vo.getContent(), "faq");
			}
			// 사진작업완료 후 DB에 저장된 실제 정보 레코드를 삭제처리한다.
			res = faqService.setFaqDelete(idxArray[i]);
		}
		
		if(res != 0) return "redirect:/message/adFaqDeleteOk";
		else return "redirect:/message/adFaqDeleteNo";
	}
	

	
	// FAQ 수정 폼 보기
	@RequestMapping(value = "/adFaqUpdate", method = RequestMethod.GET)
	public String faqUpdateGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="category", defaultValue = "전체", required = false) String category
		) {
		// 수정처리시, 수정폼을 호출할때 현재 게시글에 그림이 존재한다면 그림파일 모두를 ckeditor폴더로 복사시켜둔다.
		FaqVo vo = faqService.getFaqDetail(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) {
			faqService.imgBackup(vo.getContent());
		}
		model.addAttribute("vo", vo);
		
		return "admin/faq/adFaqUpdate";
	}
	
	// FAQ 게시글 수정하기
	@RequestMapping(value = "/adFaqUpdate", method = RequestMethod.POST)
	public String faqUpdatePost(Model model, FaqVo vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) {
		// 수정된 자료가 원본이랑 같다면 수정할필요없음
		FaqVo dbVo = faqService.getFaqDetail(vo.getIdx());
		
		if(!dbVo.getContent().equals(vo.getContent())) {
			if(dbVo.getContent().indexOf("src=\"/") != -1) faqService.imgDelete(dbVo.getContent());
			vo.setContent(vo.getContent().replace("/data/faq/", "/data/ckeditor/"));
			if(vo.getContent().indexOf("src=\"/") != -1) faqService.imgCheck(vo.getContent());
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/faq/"));
		}
		int res = faqService.setFaqUpdate(vo);
		
		if(res != 0) return "redirect:/message/adFaqUpdateOk";
		else return "redirect:/message/adFaqUpdateNo?idx="+vo.getIdx();
	}
	
	
	
	//관리자
// ---------------------------------------------------------------------------------------------------------------------------- //
	//사용자
	
	
	
	
	// FAQ 사용자 폼 보기
	@RequestMapping(value = "/faqList", method = RequestMethod.GET)
	public String faqListGet(Model model,HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="category", defaultValue = "전체", required = false) String category,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString	
		) {
		String mid = (String) session.getAttribute("sMid");
		if(mid == null) return "redirect:/message/loginRequired";
		PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "faqList", category, searchString);
		
		List<FaqVo> vos = faqService.getFaqList(pageVo.getStartIndexNo(), pageVo.getPageSize(), category, searchString);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "faq/faqList";
	}
	

	
	// FAQ 사용자 내용보기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/faqDetail", method = RequestMethod.GET)
	public String faqDetailGet(Model model, HttpSession session, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="category", defaultValue = "전체", required = false) String category	
		) {
		
		// 조회수 증가 중복불가처리
		List<String> faqNum = (List<String>) session.getAttribute("sDuplicate");
		if(faqNum == null) faqNum = new ArrayList<String>();
		String imsiNum = "faq" + idx;
		if(!faqNum.contains(imsiNum)) {
			faqService.setFaqReadNumPlus(idx);
			faqNum.add(imsiNum);
		}
		session.setAttribute("sDuplicate", faqNum);
		
		FaqVo vo = faqService.getFaqDetail(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("category", category);
		
		// 이전글/다음글 가져오기
		FaqVo preVo = faqService.getPreNextSearch(idx, "pre");
		FaqVo nextVo = faqService.getPreNextSearch(idx, "next");
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		
		return "faq/faqDetail";
	}



}
