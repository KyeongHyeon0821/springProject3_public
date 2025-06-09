package com.spring.springProject3.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.ReservationService;
import com.spring.springProject3.service.ReviewService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.service.TouristSpotService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;
import com.spring.springProject3.vo.TouristSpotVo;

@RequestMapping("/hotel")
@Controller
public class HotelController {

	@Autowired
	HotelService hotelService;
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	ReservationService reservationService;
	
	@Autowired
	TouristSpotService touristSpotService;
	
	@Autowired
	ReviewService reviewService;
	
	// 호텔 리스트
	@RequestMapping("/hotelList")
	public String hotelListGet(Model model, HttpSession session,
			@RequestParam(name="checkinDate", defaultValue = "", required = false) String checkinDate,
      @RequestParam(name="checkoutDate", defaultValue = "", required = false) String checkoutDate,
      @RequestParam(name="guestCount", defaultValue = "1", required = false) int guestCount,
      @RequestParam(name="petCount", defaultValue = "1", required = false) int petCount,
      @RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
      @RequestParam(name="startIndexNo", defaultValue = "0", required = false) int startIndexNo,
			@RequestParam(name="pageSize", defaultValue = "6", required = false) int pageSize
		) {
		if(checkinDate.equals("") || checkoutDate.equals("")) {
			LocalDate today = LocalDate.now();
	    LocalDate tomorrow = today.plusDays(1);

	    checkinDate = today.toString();      // ex) "2025-04-24"
	    checkoutDate = tomorrow.toString();  // ex) "2025-04-25"
		}
		
		String mid = session.getAttribute("sMid") + "";
		
		List<HotelVo> vos = null;
		if(!searchString.equals("")) vos = hotelService.getSearchHotelList(searchString, checkinDate, checkoutDate, guestCount, petCount, startIndexNo, pageSize);
		else vos = hotelService.getHotelList(startIndexNo, pageSize);
			
		
		if(!mid.equals("")) {
			List<Integer> likedHotelListIdx = hotelService.getLikedHotelListIdx(mid);
			model.addAttribute("likedHotelListIdx", likedHotelListIdx);
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vos.size());
	  model.addAttribute("checkinDate", checkinDate);
    model.addAttribute("checkoutDate", checkoutDate);
    model.addAttribute("guestCount", guestCount);
    model.addAttribute("petCount", petCount);
    model.addAttribute("searchString", searchString);
		return "hotel/hotelList";
	}
	
	// 호텔 리스트 더보기
	@ResponseBody
	@RequestMapping(value =  "/hotelMore", method = RequestMethod.POST)
	public ModelAndView hotelMorePost(Model model, HttpSession session,
		@RequestParam(name="checkinDate", defaultValue = "", required = false) String checkinDate,
		@RequestParam(name="checkoutDate", defaultValue = "", required = false) String checkoutDate,
		@RequestParam(name="guestCount", defaultValue = "1", required = false) int guestCount,
		@RequestParam(name="petCount", defaultValue = "1", required = false) int petCount,
		@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
		@RequestParam(name="startIndexNo", defaultValue = "0", required = false) int startIndexNo,
		@RequestParam(name="pageSize", defaultValue = "6", required = false) int pageSize
	) {
		
		if(checkinDate.equals("") || checkoutDate.equals("")) {
			LocalDate today = LocalDate.now();
			LocalDate tomorrow = today.plusDays(1);
			
			checkinDate = today.toString();      // ex) "2025-04-24"
			checkoutDate = tomorrow.toString();  // ex) "2025-04-25"
		}
		
		String mid = session.getAttribute("sMid") + "";
		
		List<HotelVo> vos = null;
		if(!searchString.equals("")) vos = hotelService.getSearchHotelList(searchString, checkinDate, checkoutDate, guestCount, petCount, startIndexNo, pageSize);
		else vos = hotelService.getHotelList(startIndexNo, pageSize);
		
		
		if(!mid.equals("")) {
			List<Integer> likedHotelListIdx = hotelService.getLikedHotelListIdx(mid);
			model.addAttribute("likedHotelListIdx", likedHotelListIdx);
		}
		System.out.println("vos : " + vos);
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vos.size());
		model.addAttribute("checkinDate", checkinDate);
		model.addAttribute("checkoutDate", checkoutDate);
		model.addAttribute("guestCount", guestCount);
		model.addAttribute("petCount", petCount);
		model.addAttribute("searchString", searchString);
		
		 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hotel/hotelMore");
		return mv;
	}

	
	// 호텔 등록폼 보기
	@RequestMapping(value =  "/hotelInput", method = RequestMethod.GET)
	public String hotelInputGet() {
		return "hotel/hotelInput";
	}
	
	// 호텔 등록 처리하기
	@RequestMapping(value =  "/hotelInput", method = RequestMethod.POST)
	public String hotelInputPost(@Validated HotelVo vo, BindingResult bindingResult, MultipartFile thumbnailFile) {
		// 백엔드 체크 에러 발생 시 처리
		if(bindingResult.hasErrors()) {
			System.out.println("에러 내용 : " + bindingResult);
			return "redirect:/message/hotelInputError";
		}
		// 썸네일 파일 null 또는 비었을 때 처리
		if(thumbnailFile == null || thumbnailFile.isEmpty()) {
			System.out.println("썸네일 파일이 비어있습니다.");
			return "redirect:/message/hotelInputError";
		}
		
		int res = hotelService.setHotelInput(vo, thumbnailFile);
		if(res !=0 ) return "redirect:/message/hotelInputOk";
		else return "redirect:/message/hotelInputNo";
	}
	

	
	// 호텔 등록 - ckeditor에서의 그림 파일 업로드시 수행처리되는 메소드 
	@RequestMapping(value =  "/hotelImageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response, String mid) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/imagesTemp/");
		String oFileName = upload.getOriginalFilename(); // 원본 파일 이름 가져오기
		
		// 파일 확장자 제한 처리
		String ext = oFileName.substring(oFileName.lastIndexOf(".") + 1).toLowerCase();
		if (!(ext.equals("jpg") || ext.equals("gif") || ext.equals("png") || ext.equals("jpeg") || ext.equals("webp"))) {
		    PrintWriter out = response.getWriter();
		    out.println("{\"uploaded\":0,\"error\":{\"message\":\"업로드 가능한 파일은 jpg, jpeg, png, gif, webp 형식만 가능합니다.\"}}");
		    out.flush();
		    return; 
		}
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		
		String sFileName = mid + "_" + sdf.format(date) + "_" + oFileName; // 호텔 등록자 아이디 + "_" + 날짜 + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + sFileName)); // 실제 경로에 파일 저장
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/imagesTemp/" + sFileName;  // 매핑 경로
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		out.flush();
		
		fos.close();
	}
	
	
	// 호텔 상세페이지 보기
	@RequestMapping(value =  "/hotelDetail", method = RequestMethod.GET)
	public String hotelDetailGet(Model model, int idx, HttpSession session,
			 @RequestParam(name="checkinDate", defaultValue = "", required = false) String checkinDate,
       @RequestParam(name="checkoutDate", defaultValue = "", required = false) String checkoutDate,
       @RequestParam(name="guestCount", defaultValue = "0", required = false) int guestCount,
       @RequestParam(name="petCount", defaultValue = "0", required = false) int petCount,
       @RequestParam(name="searchString", defaultValue = "", required = false) String searchString
		) {
		
		// 기본 체크인&체크아웃 날짜, 인원수, 반려견수 설정
		if (checkinDate.equals("") || checkoutDate.equals("") || guestCount == 0 || petCount == 0) {
      LocalDate today = LocalDate.now();
      LocalDate tomorrow = today.plusDays(1);

      checkinDate = today.toString();      // ex) "2025-04-24"
      checkoutDate = tomorrow.toString();  // ex) "2025-04-25"
      guestCount = 1;
      petCount = 1;
		}
		
		String mid = (String) session.getAttribute("sMid");
		
		// 호텔 정보
    HotelVo hotelVo = hotelService.getHotel(idx); // 단일 호텔 정보
    List<HotelVo> vos = hotelService.getHotelSearch(idx); // 연관 호텔 리스트 (예: 같은 지역 등)
    
    // 호텔 리뷰 보여주기
		List<ReviewVo> rVos = reviewService.getHotelReviewList(idx);
		
    // 찜 상태 확인
    int res = hotelService.getHotelLike(mid, idx);
    String hotelLike = (res != 0) ? "Ok" : "No";
		
		// 결제 안 한 예약 자동 취소 ('결제대기' -> '예약취소' 예약 당일 안 했을 경우)
		reservationService.setReservationAutoCancel();
		// 예약 상태 업데이트 ('예약완료'->'이용완료' 체크아웃 날짜가 오늘 날짜랑 같거나 이전이면 이용완료 처리(오늘 날짜 부터 새 예약을 받을 수 있도록))
		reservationService.setReservationUpdateToDone();
		
		// 객실 정보 조회
    List<RoomVo> roomVos = roomService.getAvailableRoomList(idx, checkinDate, checkoutDate, guestCount, petCount);

    // 관광지 정보 조회
    List<TouristSpotVo> touristList = touristSpotService.getSpotsByHotelIdx(idx);
    
    // 모델에 담기
    model.addAttribute("hotelVo", hotelVo);
    model.addAttribute("rVos", rVos);
    model.addAttribute("vos", vos); // 연관 호텔 리스트
    model.addAttribute("hotelLike", hotelLike);
    model.addAttribute("roomVos", roomVos);
    model.addAttribute("checkinDate", checkinDate);
    model.addAttribute("checkoutDate", checkoutDate);
    model.addAttribute("guestCount", guestCount);
    model.addAttribute("petCount", petCount);
    model.addAttribute("searchString", searchString);
    model.addAttribute("touristList", touristList);
    
		return "hotel/hotelDetail";
	}
	
	// 호텔 정보 수정 페이지 보기
	@RequestMapping(value =  "/hotelUpdate", method = RequestMethod.GET)
	public String hotelUpdateGet(HttpServletRequest request, Model model, int idx) {
		
		// 추가 이미지가 있을 경우 hotelImages -> imagesTemp에 이미지 파일 복사 처리
		HotelVo vo = hotelService.getHotel(idx);
		if(vo.getImages() != null || !vo.getImages().equals("")) hotelService.ImageCopy(vo.getImages());
		
		model.addAttribute("vo", vo);
		return "hotel/hotelUpdate";
	}
	
	// 호텔 정보 수정 처리
	@RequestMapping(value =  "/hotelUpdate", method = RequestMethod.POST)
	public String hotelUpdatePost(HotelVo vo, MultipartFile thumbnailFile) {
	
	  int res = hotelService.setHotelUpdate(vo, thumbnailFile);
		if(res !=0 ) return "redirect:/message/hotelUpdateOk?hotelIdx="+vo.getIdx();
		else return "redirect:/message/hotelUpdateNo?hotelIdx="+vo.getIdx();
	}
	
	// 호텔 서비스중지요청 처리
	@RequestMapping(value =  "/hotelDeleteCheck", method = RequestMethod.GET)
	public String hotelDeleteCheckGet(int idx) {
		int res = hotelService.setHotelStatusUpdate(idx, "서비스중지요청");
		
		if(res !=0 ) return "redirect:/message/hotelDeleteCheckOk";
		else return "redirect:/message/hotelDeleteCheckNo?hotelIdx="+idx;
	}
	
	// 호텔 찜 추가
	@ResponseBody
	@RequestMapping(value = ("/hotelLikeOk"), method = RequestMethod.POST)
	public String hotelLikeOkPost(String mid, int hotelIdx) {
		return hotelService.setHotelLikeOk(mid, hotelIdx) + "";
	}
	
	// 호텔 찜 취소
	@ResponseBody
	@RequestMapping(value = ("/hotelLikeNo"), method = RequestMethod.POST)
	public String hotelLikeNoPost(String mid, int hotelIdx) {
		return hotelService.setHotelLikeNo(mid, hotelIdx) + "";
	}
	
	//본인이 등록한 호텔 목록 보기
	@RequestMapping("/myHotelList")
	public String myHotelList(HttpSession session, Model model) {
	    String mid = (String) session.getAttribute("sMid");
	    if (mid == null) return "redirect:/message/loginRequired";

	    List<HotelVo> hotelList = hotelService.getHotelListByMid(mid);
	    model.addAttribute("hotelList", hotelList);
	    return "hotel/hotelMyList";
	}
	
	// 본인이 등록한 호텔 상세정보
	@RequestMapping("/hotelMyDetail")
	public String hotelMyDetail(@RequestParam("idx") int idx, Model model) {
		
	    HotelVo hotelVo = hotelService.getHotel(idx); // 호텔 정보
	    List<RoomVo> roomVos = roomService.getRoomList(idx); // 객실 목록 (없으면 생략 가능)
	    List<TouristSpotVo> touristList = touristSpotService.getSpotsByHotelIdx(idx); // 관광지 정보
	    
	    model.addAttribute("touristList", touristList);
	    model.addAttribute("hotelVo", hotelVo);
	    model.addAttribute("roomVos", roomVos);
	    return "hotel/hotelMyDetail";
	}
	
}
