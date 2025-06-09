package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.service.InquiryService;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.PageVo;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	Pagination pagination;

	// 1:1문의 리스트 보기
	@RequestMapping(value = "/inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) {
		String mid = (String) session.getAttribute("sMid");
		if(mid == null) return "redirect:/message/loginRequired";
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"inquiry",mid,"");	// (페이지번호,한 페이지분량,section,part,검색어)
		List<InquiryVo> vos = inquiryService.getInquiryList(pageVo.getStartIndexNo(), pageSize, mid);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "inquiry/inquiryList";
	}
	
	// 1:1문의 입력 폼 보기
	@RequestMapping(value = "/inquiryInput", method = RequestMethod.GET)
	public String iquriyInputGet() {
		return "inquiry/inquiryInput";
	}
	
	// 1:1문의 업로드 처리
	@RequestMapping(value = "/inquiryInput", method = RequestMethod.POST)
	public String inquiryInputPost(MultipartFile mFile, InquiryVo vo) {
		int res = inquiryService.setInquiryInputOk(mFile, vo);
		
		if(res !=0) return "redirect:/message/inquiryInputOk";
		else return "redirect:/message/inquiryInputNo";
	}
	
	// 1:1문의 상세보기 폼 보기
	@RequestMapping(value = "/inquiryDetail", method = RequestMethod.GET)
	public String inquiryDetailGet(int idx, Model model) {
    InquiryVo vo = inquiryService.getInquiryDetail(idx);
    //InquiryReplyVo replyVo = inquiryService.getInquiryReply(idx);
    //System.out.println("vo : " + vo);
    model.addAttribute("vo", vo);
    //model.addAttribute("replyVo", replyVo);
    
    return "inquiry/inquiryDetail";
	}
	
	// 1:1문의 상세보기에서 삭제처리
	@RequestMapping(value = "/inquiryDeleteCheck", method = RequestMethod.GET)
	public String inquiryDeleteCheckGet(int idx) {
		InquiryVo vo = inquiryService.getInquiryDetail(idx);

		//System.out.println("vo : " + vo);
		
		int res = inquiryService.setInquiryDelete(idx);
	
		if(res != 0) return "redirect:/message/inquiryDeleteCheckOk";
		else return "redirect:/message/inquiryDeleteCheckNo";
	}
	
	// 1:1문의 상세보기에서 수정 폼 보기
	@RequestMapping(value = "/inquiryUpdateCheck", method = RequestMethod.GET)
	public String inquiryUpdateCheckGet(Model model, int idx) {
		InquiryVo vo = inquiryService.getInquiryDetail(idx);
		//System.out.println("vo : " + vo);
		model.addAttribute("vo", vo);
		return "inquiry/inquiryUpdate";
	}
	
	// 1:1문의 상세보기에서 수정 처리
	@RequestMapping(value = "/inquiryUpdateCheck", method = RequestMethod.POST)
	public String inquiryUpdateCheckPost(MultipartFile mFile, InquiryVo vo) {
		//System.out.println("vo : " + vo);
		
    int res = inquiryService.setInquiryUpdate(mFile, vo);

    if (res != 0) return "redirect:/message/inquiryUpdateOk?idx="+vo.getIdx();
    else return "redirect:/message/inquiryUpdateNo?idx="+vo.getIdx();
	}
	
	// 그림파일만 삭제처리
	@ResponseBody
	@PostMapping("/imageDelete")
	public String imageDeletePost(int idx, String fSName) {
		return inquiryService.setInquiryImageDelete(idx, fSName) + "";
	}

	
}
