package com.spring.springProject3.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.ReviewService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.OptionVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

@Controller
@RequestMapping("/room")
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	HotelService hotelService;
	
	@Autowired
	ReviewService reviewService;
	
	// 객실 등록 폼 보기
	@RequestMapping(value = ("/roomInput"), method = RequestMethod.GET)
	public String roomInputGet(Model model, @RequestParam("hotelIdx") int hotelIdx) {
		HotelVo vo = hotelService.getHotel(hotelIdx);
		List<OptionVo> optionList = roomService.getOptionList();
				
		model.addAttribute("hotelIdx", hotelIdx);
		model.addAttribute("vo", vo);
		model.addAttribute("optionList", optionList);
		return "room/roomInput";
	}
	
	// 객실 등록 처리
	@Transactional
	@RequestMapping(value = ("/roomInput"), method = RequestMethod.POST)
	public String roomInputPost(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles,
			@RequestParam(name="options", required = false) String[] options
		) {
		// 썸네일, 그 외 이미지, 객실 데이터 저장(DB)
		int res = roomService.setRoomInput(vo, thumbnailFile, imageFiles);
		// 객실-옵션 데이터 저장(DB)
		int roomIdx = roomService.getMaxIdx();
		if(options != null) {
			for(String optionIdxStr : options) {
				res = roomService.setRoomOptions(roomIdx, Integer.parseInt(optionIdxStr));
			}
		}
		
		if(res !=0 ) return "redirect:/message/roomInputOk?hotelIdx="+vo.getHotelIdx();
		else return "redirect:/message/roomInputNo?hotelIdx="+vo.getHotelIdx();
	}
	
	
	// 객실 상세 보기
	@RequestMapping(value = ("/roomDetail"), method = RequestMethod.GET)
	public String roomDetailGet(Model model, @RequestParam("roomIdx") int roomIdx,
			@RequestParam(name="checkinDate", defaultValue="") String checkinDate,
	    @RequestParam(name="checkoutDate", defaultValue="") String checkoutDate,
	    @RequestParam(name="guestCount", defaultValue="1") int guestCount,
	    @RequestParam(name="petCount", defaultValue="1") int petCount,
	    @RequestParam(name="searchString", defaultValue="") String searchString
		) {
		
		if (checkinDate.equals("") || checkoutDate.equals("")) {
      LocalDate today = LocalDate.now();
      LocalDate tomorrow = today.plusDays(1);
      checkinDate = today.toString();
      checkoutDate = tomorrow.toString();
		}
		// 날짜 차이 계산
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate checkin = LocalDate.parse(checkinDate, formatter);
    LocalDate checkout = LocalDate.parse(checkoutDate, formatter);
    long nights = ChronoUnit.DAYS.between(checkin, checkout);
    if (nights <= 0) {
        nights = 1; // 최소 1박 보장
    }
    
    // 객실상세페이지에서 리뷰 보여주기
 		List<ReviewVo> rVos = reviewService.getRoomReviewList(roomIdx);
 		
		RoomVo vo = roomService.getRoom(roomIdx);
		List<OptionVo> roomOptionList = roomService.getRoomOptionList(roomIdx);
				
		model.addAttribute("rVos", rVos);
		model.addAttribute("vo", vo);
		model.addAttribute("roomOptionList", roomOptionList);
		model.addAttribute("checkinDate", checkinDate);
    model.addAttribute("checkoutDate", checkoutDate);
    model.addAttribute("guestCount", guestCount);
    model.addAttribute("petCount", petCount);
    model.addAttribute("nights", nights);
    model.addAttribute("searchString", searchString);
		return "room/roomDetail";
	}
	
	// 객실 정보 수정 폼 보기
	@RequestMapping(value = ("/roomUpdate"), method = RequestMethod.GET)
	public String roomUpdateGet(Model model, @RequestParam("roomIdx") int roomIdx) {
		
		RoomVo vo = roomService.getRoom(roomIdx);
		List<OptionVo> optionList = roomService.getOptionList(); // 전체 옵션 리스트
		List<OptionVo> roomOptionList = roomService.getRoomOptionList(roomIdx);  // 체크된 옵션 리스트
		HotelVo hotelVo = hotelService.getHotel(vo.getHotelIdx());
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("hotelVo", hotelVo);
		model.addAttribute("optionList", optionList);
		model.addAttribute("roomOptionList", roomOptionList);
		
		return "room/roomUpdate";
	}
	
	// 객실 정보 수정 처리
	@Transactional
	@RequestMapping(value = ("/roomUpdate"), method = RequestMethod.POST)
	public String roomUpdatePost(RoomVo vo, @RequestParam(name="options", required = false) String[] options) {
		int res = roomService.setRoomUpdate(vo);
		
		// 기존 객실-옵션 데이터 삭제
		// 객실-옵션 데이터 저장(DB)
		if(options != null) {
			res = roomService.setDeleteRoomOptions(vo.getIdx());
			for(String optionIdxStr : options) {
				System.out.println(vo.getIdx());
				res = roomService.setRoomOptions(vo.getIdx(), Integer.parseInt(optionIdxStr));
			}
		}
		
		if(res !=0 ) return "redirect:/message/roomUpdateOk?roomIdx="+vo.getIdx();
		else return "redirect:/message/roomUpdateNo?roomIdx="+vo.getIdx();
	}
	
	
	// 객실 이미지 수정 폼 보기
	@RequestMapping(value = ("/roomImageUpdate"), method = RequestMethod.GET)
	public String roomImageUpdateGet(Model model, @RequestParam("roomIdx") int roomIdx) {
		RoomVo vo = roomService.getRoom(roomIdx);
		model.addAttribute("vo", vo);
		return "room/roomImageUpdate";
	}
	
	// 객실 이미지 수정 처리  
	@Transactional
	@RequestMapping(value = ("/roomImageUpdate"), method = RequestMethod.POST)
	public String roomImageUpdatePost(MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles,
			RoomVo vo
		) {
		int res = roomService.setRoomThumbnailAndImageUpdate(vo, thumbnailFile, imageFiles);
		
		if(res !=0 ) return "redirect:/message/roomImageUpdateOk?roomIdx="+vo.getIdx();
		else return "redirect:/message/roomImageUpdateNo?roomIdx="+vo.getIdx();
	}
	
	// 객실 이미지 삭제 처리(1개)
	@ResponseBody
	@RequestMapping(value = ("/roomImageFileDelete"), method = RequestMethod.POST)
	public String roomImageFileDeleteGet(HttpServletRequest request,
			String imageFileName, String images, int idx
		) {
		String realPath = request.getSession().getServletContext().getRealPath("resources/data/roomImages/");
		String res = "0";
		File fName = new File(realPath + imageFileName);
		
		// 서버에서 이미지 삭제
		if(fName.exists()) {
			fName.delete();
			res = "1";
		}
		
		// DB 에서 해당 이미지 이름만 삭제
		if(images.indexOf("/") == -1) {
			images = null;
		}
		else if(images.indexOf(imageFileName+"/") == -1) {
			images = images.replace("/" + imageFileName, "");
		}
		else{
			images = images.replace(imageFileName+"/", "");
		}
		res = roomService.setUpdateImages(idx, images) + "";
		
		return res;
	}
	
	// 객실 이미지 전체 삭제 처리
	@ResponseBody
	@RequestMapping(value = ("roomImageFilesDeleteAll"), method = RequestMethod.POST)
	public String roomImageFilesDeleteAllPost(HttpServletRequest request, String images, int idx) {
		String realPath = request.getSession().getServletContext().getRealPath("resources/data/roomImages/");
		String res = "0";
		
		String[] imageFileNameArr = images.split("/");
		
		// 서버에서 이미지 삭제
		for(String imageFileName : imageFileNameArr) {
			File fName = new File(realPath + imageFileName);
			if(fName.exists()) {
				fName.delete();
				res = "1";
			}
		}
		// DB 에서 이미지 null값 처리
		res = roomService.setDeleteImages(idx) + "";
		
		return res;
	}
	
	// 객실 서비스중지요청 처리
	@RequestMapping(value =  "/roomDeleteCheck", method = RequestMethod.GET)
	public String roomDeleteCheckGet(int idx) {
		int res = roomService.setroomStatusUpdate(idx, "서비스중지요청");
		
		if(res !=0 ) return "redirect:/message/roomDeleteCheckOk?roomIdx="+idx;
		else return "redirect:/message/roomDeleteCheckNo?roomIdx="+idx;
	}
	
	//리뷰 보기 (리뷰서비스사용)
	@ResponseBody
	@RequestMapping(value = ("/roomReviewList"), method = RequestMethod.POST)
	public List<ReviewVo> roomReviewListPost(int roomIdx) {
		List<ReviewVo> reviewVos = reviewService.getRoomReviewList(roomIdx);
		return reviewVos;
	}
	
	// 마이페이지에서 리뷰 등록하러 가기
	@GetMapping("/roomUseList")
	public String roomUseListGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid")+"";
		List<ReservationListVo> rsVos = roomService.getRoomUsedList(mid);
		List<ReservationVo> vos = roomService.getReviewSave(mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("rsVos",rsVos);
		
		return "room/roomUseList";
	}
	
	// 마이페이지에서 내 이용내역에 리뷰를 달았는지 체크
	@ResponseBody
	@GetMapping("/reviewSaveCheck")
	public String ReviewSaveCheckGet(String reservationNo) {
		ReviewVo vo = roomService.getReviewSaveCheck(reservationNo);
		if(vo != null) return "1";
		else return "0";
	}
	
	
}
