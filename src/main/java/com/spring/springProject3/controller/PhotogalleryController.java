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
import org.springframework.web.servlet.ModelAndView;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.PhotogalleryService;
import com.spring.springProject3.vo.PageVo;
import com.spring.springProject3.vo.PhotogalleryVo;
import com.spring.springProject3.vo.TouristSpotVo;

@Controller
@RequestMapping("/photogallery")
public class PhotogalleryController {
	
	@Autowired
	PhotogalleryService photogalleryService;
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	ProjectProvide projectProvide;

	// 포토갤러리 리스트보기
	@RequestMapping(value = "/photogalleryList", method = RequestMethod.GET)
	public String photogalleryListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "8", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "최신순", required = false) String part
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "photogallery", part, "");
		List<PhotogalleryVo> vos = photogalleryService.getPhotogalleryList(pageVo.getStartIndexNo(),pageSize,part);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "photogallery/photogalleryList";
	}
	
	// 포토갤러리 게시글 입력 폼보기
	@RequestMapping(value = "/photogalleryInput", method = RequestMethod.GET)
	public String photogalleryInputGet(Model model) {
		List<TouristSpotVo> pVos = photogalleryService.getTouristSpotList();
//		List<String> pVos = photogalleryService.getTouristSpotList();
//		List<String> pVos = new ArrayList<>();
//		pVos.add("허브아일랜드");
//		pVos.add("양양복골온천");
//		pVos.add("평창 육백마지기");
//		pVos.add("바다");
//		pVos.add("여행");
		model.addAttribute("pVos", pVos);
		
		return "photogallery/photogalleryInput";
	}
	
	// 포토갤러리 업로드 처리
	@RequestMapping(value = "/photogalleryInput", method = RequestMethod.POST)
	public String photogalleryInputPost(PhotogalleryVo vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) photogalleryService.imgCheck(vo.getContent());
		else return "redirect:/message/photogalleryNoImage";
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/photogallery/"));
		
		String str1 = vo.getContent().substring(vo.getContent().indexOf("src=\"")+39);
		String str2 = str1.substring(0,str1.indexOf("\""));
		//vo.setThumbnail(vo.getContent().substring(vo.getContent().indexOf("src=\"")+48,vo.getContent().indexOf("\","+vo.getContent().indexOf("src=\"")+39+"")));
		vo.setThumbnail(str2);
		int res = photogalleryService.setPhotogalleryInputOk(vo);
		
		if(res != 0) return "redirect:/message/photogalleryInputOK";
		else return "redirect:/message/photogalleryInputNo";
	}
	
	// 포토갤러리 내용보기
	@RequestMapping(value = "/photogalleryDetail", method = RequestMethod.GET)
	public String photogalleryDetailGet(int idx, Model model) {
		photogalleryService.setPhotogalleryReadNumPlus(idx);
		PhotogalleryVo vo = photogalleryService.getPhotogalleryDetail(idx);
		model.addAttribute("vo", vo);
		
		return "photogallery/photogalleryDetail";
	}
	
	// 포토갤러리 개별내용각각을 전체보기(무한스크롤)
	@RequestMapping(value = "/photogallerySingleAll", method = RequestMethod.GET)
	public String photogallerySingleAllGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "2", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "최신순", required = false) String part
		) {
		int startIndexNo = (pag - 1) * pageSize;
		List<PhotogalleryVo> vos = photogalleryService.getPhotogalleryList(startIndexNo, pageSize, part);
		model.addAttribute("vos", vos);
		
		return "photogallery/photogallerySingleAll";
	}
	
	// 무한스크롤 : 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@RequestMapping(value = "/photogallerySingleAllPaging", method = RequestMethod.POST)
	public ModelAndView photogallerySingleAllPagingPost(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "2", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "최신순", required = false) String part
		) {
		int startIndexNo = (pag - 1) * pageSize;
		List<PhotogalleryVo> vos = photogalleryService.getPhotogalleryList(startIndexNo, pageSize, part);
		model.addAttribute("vos", vos);
		System.out.println("vos: " + vos);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("photogallery/photogallerySingleAllPaging");
		return mv;
	}
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/photogalleryGoodCheck", method = RequestMethod.POST)
	public String photogalleryGoodCheckPost(HttpSession session, int idx) {
		String res = "0";
		
		// 중복방지
		List<String> goodNum = (List<String>) session.getAttribute("sDuplicate");
		if(goodNum == null) goodNum = new ArrayList<String>();
		String imsiNum = "photogalleryGood" + idx;
		if(!goodNum.contains(imsiNum)) {
			photogalleryService.setPhotogalleryGoodCheck(idx);
			goodNum.add(imsiNum);
			res = "1";
		}
		session.setAttribute("sDuplicate", goodNum);
		return res;
	}
	
	// 포토갤러리 삭제 처리
	@RequestMapping(value = "/photogalleryDelete", method = RequestMethod.GET)
	public String photogalleryDeleteGet(int idx) {
		PhotogalleryVo vo = photogalleryService.getPhotogalleryDetail(idx);
		projectProvide.imgDelete(vo.getContent(),"photogallery");
		
		int res = photogalleryService.setPhotogalleryDelete(idx);
		
		if(res != 0) return "redirect:/message/photogalleryDeleteOk";
		else return "redirect:/message/photogalleryDeleteNo";
	}

}
