package com.spring.springProject3.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.CouponService;
import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.service.ReservationService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.CouponVo;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.MemberVo;
import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.RoomVo;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	ReservationService reservationService;
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	HotelService hotelService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CouponService couponService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	//sms 를 위한 라이브러리를 스프링컨테이너에 등록하기
	final DefaultMessageService messageService;

	public ReservationController() {
	 	String INSERT_API_KEY = "앱키";
	 	String INSERT_API_SECRET_KEY = "시크릿키";
    this.messageService = NurigoApp.INSTANCE.initialize(INSERT_API_KEY, INSERT_API_SECRET_KEY, "https://api.coolsms.co.kr");
	}
	
	// 예약 폼 보기
	@RequestMapping(value = "/reservationForm", method = RequestMethod.GET)
	public String reservationFormGet(Model model,
			HttpSession session,
      @RequestParam(value = "roomIdx", required = true) Integer roomIdx,
      @RequestParam(value = "checkinDate", required = true) String checkinDate,
      @RequestParam(value = "checkoutDate", required = true) String checkoutDate,
      @RequestParam(value = "guestCount", required = true) Integer guestCount,
      @RequestParam(value = "petCount", required = true) Integer petCount,
      @RequestParam(value = "nights", required = true) Integer nights,
      @RequestParam(value = "searchString", defaultValue = "", required = false) String searchString
		) {
		if(session.getAttribute("sMid")==null) return "redirect:/message/loginRequired";
		
		// 유효성 체크
    if (roomIdx == null || roomIdx <= 0) {
        return "redirect:/message/invalidValue"; 
    }
    if (checkinDate == null || checkinDate.trim().isEmpty()) {
        return "redirect:/message/invalidValue";  
    }
    if (checkoutDate == null || checkoutDate.trim().isEmpty()) {
        return "redirect:/message/invalidValue"; 
    }
    if (guestCount == null || guestCount <= 0) {
        return "redirect:/message/invalidValue";  
    }
    if (petCount == null || petCount < 0) {
        return "redirect:/message/invalidValue"; 
    }
    if (nights == null || nights <= 0) {
        return "redirect:/message/invalidValue";
    }
    String mid = session.getAttribute("sMid") + "";
		List<CouponVo> couponList = couponService.getAvailableMyCoupons(mid);
		RoomVo roomVo = roomService.getRoom(roomIdx);
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
		MemberVo memberVo = memberService.getMemberIdCheck(session.getAttribute("sMid")+"");
		model.addAttribute("couponList", couponList);
		model.addAttribute("roomVo", roomVo);
		model.addAttribute("hotelVo", hotelVo);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("roomIdx", roomIdx);
		model.addAttribute("checkinDate", checkinDate);
		model.addAttribute("checkoutDate", checkoutDate);
		model.addAttribute("guestCount", guestCount);
		model.addAttribute("petCount", petCount);
		model.addAttribute("nights", nights);
		model.addAttribute("searchString", searchString);
		return "reservation/reservationForm";
	}
	
	// 예약 처리
	@Transactional
	@RequestMapping(value = "/reservationForm", method = RequestMethod.POST)
	public String reservationFormPost(HttpSession session, Model model, ReservationVo vo, String couponCode) {
		String mid = session.getAttribute("sMid") + "";
		if(mid == null || mid.equals("")) return "redirect:/message/loginRequired"; // 로그인 체크
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
		
		
		vo.setMid(mid);
		vo.setStatus("결제대기");
		vo.setReservationNo(sdf.format(today) + UUID.randomUUID().toString().substring(0,2) + vo.getRoomIdx()); // 예약번호만들기 (년월일시분 10자리 + uuid 2자리 + 객실idx)
		
		int res = reservationService.setReservationInput(vo); // 예약 테이블 입력 처리
		
		if(res != 0) { // 결제대기 처리 되었으면 실행
			if(!couponCode.equals("") && couponCode != null) couponService.setMyCouponUse(mid, couponCode); // 쿠폰 사용 시 쿠폰사용처리;
			RoomVo roomVo = roomService.getRoom(vo.getRoomIdx());
			HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
			
			model.addAttribute("hotelVo", hotelVo);
			model.addAttribute("vo", vo);
			session.setAttribute("reservationVo", vo);
			return "reservation/payment";
		}
		else return "redirect:/message/reservationNo";
	}
	
	
	// 결제 완료 후 결제 정보/예약정보 보기
	@RequestMapping(value = ("/paymentOk"), method = RequestMethod.GET)
	public String paymentOkGet(HttpSession session, Model model) {
		ReservationVo reservationVo = (ReservationVo) session.getAttribute("reservationVo");
		
		// 예약완료 처리
		reservationService.setReservationPaymentOk(reservationVo.getReservationNo());
		// 예약 정보, 사용자 정보 넘기기
		RoomVo roomVo = roomService.getRoom(reservationVo.getRoomIdx()); 
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx()); 
		reservationVo = reservationService.getReservation(reservationVo.getReservationNo());
		model.addAttribute("reservationVo", reservationVo);
		model.addAttribute("roomVo", roomVo);
		model.addAttribute("hotelVo", hotelVo);
		session.removeAttribute("reservationVo");
		return "reservation/paymentOk";
	}
	
	
	// 마이페이지 예약상태 상세보기
	@RequestMapping(value = "/reservationDetail/{reservationNo}", method = RequestMethod.GET)
	public String reservationStatusGet(HttpSession session, Model model, @PathVariable("reservationNo") String reservationNo) {
		ReservationVo reservationVo = reservationService.getReservation(reservationNo);
		RoomVo roomVo = roomService.getRoom(reservationVo.getRoomIdx());
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
		
		session.setAttribute("reservationVo", reservationVo);
		model.addAttribute("reservationVo", reservationVo);
		model.addAttribute("roomVo", roomVo);
		model.addAttribute("hotelVo", hotelVo);
		return "reservation/reservationDetail";
	}
	
	
	// 마이페이지 결제 처리
	@RequestMapping(value = "/payment/{reservationNo}", method = RequestMethod.GET)
	public String paymentGet(HttpSession session, Model model, @PathVariable("reservationNo") String reservationNo) {
		String mid = session.getAttribute("sMid") + "";
		if(mid == null || mid.equals("")) return "redirect:/message/loginRequired"; // 로그인 체크
		
		ReservationVo vo = reservationService.getReservation(reservationNo);
		RoomVo roomVo = roomService.getRoom(vo.getRoomIdx());
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
		
		model.addAttribute("hotelVo", hotelVo);
		model.addAttribute("vo", vo);
		return "reservation/payment";
	}
	
	
	// 마이페이지 결제 취소 처리
	@RequestMapping(value = "/reservationCancel/{reservationNo}", method = RequestMethod.GET)
	public String reservationCancelGet(HttpSession session, @PathVariable("reservationNo") String reservationNo) {
		String mid = session.getAttribute("sMid") + "";
		if(mid == null || mid.equals("")) return "redirect:/message/loginRequired"; // 로그인 체크
		
		int res = reservationService.setReservationCancel(mid, reservationNo);
		if(res != 0) return "redirect:/message/reservationCancelOk?reservationNo="+reservationNo;
		else return "redirect:/message/reservationCancelNo?reservationNo="+reservationNo;
	}
	
	// 폰으로 인증번호 발송하기
	@ResponseBody
	@RequestMapping(value = "/smsAuthentication", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String smsAuthenticationPost(HttpSession session, String fromNumber, String tel, int num) {
		Message message = new Message();
		String authenticationNumber = projectProvide.newNumberCreate(num);	// 랜덤한 숫자 인증코드 발급받기

		message.setFrom(fromNumber);
		message.setTo(tel);
		message.setText("[본인확인 인증번호] " + authenticationNumber);
		
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		System.out.println(response);
		
		session.setAttribute("sAuthenticationNumber", authenticationNumber);
		
		return "인증번호가 발송되었습니다.\n인증번호를 아래 입력란에 입력후 인증하기 버튼을 눌러주세요.";
	}
	
	
	//폰으로 보낸 인증번호 확인처리하기
	@ResponseBody
	@RequestMapping(value = "/smsAuthenticationCheck", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String smsAuthenticationCheckPost(HttpSession session, String authenticationNumber) {
		String sAuthenticationNumber = (String) session.getAttribute("sAuthenticationNumber");
		
		if(sAuthenticationNumber.equals(authenticationNumber)) return "1";
		else return "0";
	}
	
}
