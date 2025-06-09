package com.spring.springProject3.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, @PathVariable String msgFlag,
			HttpSession session, HttpServletRequest request,
			@RequestParam(name="hotelIdx", defaultValue = "0", required = false) int hotelIdx,
			@RequestParam(name="roomIdx", defaultValue = "0", required = false) int roomIdx,
			@RequestParam(name="nickName", defaultValue="", required=false) String nickName,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="mSw", defaultValue = "1", required = false) String mSw,
			@RequestParam(name="tempFlag", defaultValue = "", required = false) String tempFlag,
			@RequestParam(name="reservationNo", defaultValue = "", required = false) String reservationNo
		) {
		
		if(msgFlag.equals("hotelInputNo")) {
			model.addAttribute("message", "호텔 등록에 실패했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelInput");
		}
		else if(msgFlag.equals("hotelInputOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "호텔이 등록되었습니다.");
			model.addAttribute("url", "hotel/hotelList");
		}
		else if(msgFlag.equals("hotelInputError")) {
			model.addAttribute("message", "호텔 등록 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelInput");
		}
		else if(msgFlag.equals("hotelDeleteCheckOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "호텔 서비스 중지 요청이 접수되었습니다.");
			model.addAttribute("url", "hotel/hotelList");
		}
		else if(msgFlag.equals("hotelDeleteCheckNo")) {
			model.addAttribute("message", "호텔 서비스 중지 요청 처리 중 문제가 발생했습니다. 다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelDetail?idx="+hotelIdx);
		}
		else if(msgFlag.equals("hotelUpdateOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "호텔 정보가 수정되었습니다.");
			model.addAttribute("url", "hotel/hotelDetail?idx="+hotelIdx);
		}
		else if(msgFlag.equals("hotelUpdateNo")) {
			model.addAttribute("message", "호텔 정보 수정 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelUpdate?idx="+hotelIdx);
		}
		else if(msgFlag.equals("roomInputOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "객실이 등록되었습니다.");
			model.addAttribute("url", "hotel/hotelDetail?idx="+hotelIdx);
		}
		else if(msgFlag.equals("roomInputNo")) {
			model.addAttribute("message", "객실 등록에 실패했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/roomInput?hotelIdx="+hotelIdx);
		}
		else if(msgFlag.equals("roomUpdateOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "객실 정보가 수정되었습니다.");
			model.addAttribute("url", "room/roomDetail?roomIdx="+roomIdx);
		}
		else if(msgFlag.equals("roomUpdateNo")) {
			model.addAttribute("message", "객실 정보가 수정 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "room/roomUpdate?roomIdx="+roomIdx);
		}
		else if(msgFlag.equals("roomImageUpdateOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "객실 이미지가 수정되었습니다.");
			model.addAttribute("url", "room/roomImageUpdate?roomIdx="+roomIdx);
		}
		else if(msgFlag.equals("roomImageUpdateNo")) {
			model.addAttribute("message", "객실 이미지 수정 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "room/roomImageUpdate?roomIdx="+roomIdx);
		}
		else if(msgFlag.equals("roomDeleteCheckOk")) {
			model.addAttribute("msgType", "success");
			model.addAttribute("message", "객실 서비스 중지 요청이 접수되었습니다.");
			model.addAttribute("url", "room/roomDetail?roomIdx="+roomIdx);
		}
		else if(msgFlag.equals("roomDeleteCheckNo")) {
			model.addAttribute("message", "객실 서비스 중지 요청 처리 중 문제가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "room/roomDetail?roomIdx="+roomIdx);
		}
		else if(msgFlag.equals("invalidValue")) {
			model.addAttribute("message", "선택하신 숙소의 정보를 불러오는 데 실패했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelList");
		}
		else if(msgFlag.equals("reservationCancelOk")) {
			model.addAttribute("message", "예약이 취소되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "reservation/reservationDetail/"+reservationNo);
		}
		else if(msgFlag.equals("reservationCancelNo")) {
			model.addAttribute("message", "예약 취소 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "reservation/reservationDetail/"+reservationNo);
		}
		else if(msgFlag.equals("couponInputOk")) {
			model.addAttribute("message", "쿠폰이 등록되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "admin/adCouponList");
		}
		else if(msgFlag.equals("couponInputNo")) {
			model.addAttribute("message", "쿠폰 등록 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "admin/adCouponInput");
		}
		else if(msgFlag.equals("couponUpdateOk")) {
			model.addAttribute("message", "쿠폰 정보가 수정되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "admin/adCouponList");
		}
		else if(msgFlag.equals("couponUpdateNo")) {
			model.addAttribute("message", "쿠폰 정보 수정 중 오류가 발생했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "admin/adCouponUpdate/"+idx);
		}
		
		
		
		
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "회원 가입이 완료되었습니다.\\n로그인 후 사용하세요.");
			model.addAttribute("url", "member/memberLogin");
			model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("message", "아이디가 중복되었습니다.\\n확인하시고 다시 입력하세요.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원 가입에 실패하였습니다.\\n다시 회원가입 해주세요.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
		    if (nickName == null || nickName.equals("")) {
		        nickName = (String) session.getAttribute("sNickName");
		    }

		    String msg;

		    // 카카오 자동가입인 경우
		    if ("OK".equals(session.getAttribute("sLoginNew"))) {
		        msg = "카카오 회원가입이 완료되었습니다.\\n임시 비밀번호가 이메일로 발송되었습니다.";
		        session.removeAttribute("sLoginNew");
		        model.addAttribute("msgType", "success");
		    } else {
		        // 일반 로그인
		        msg = nickName + " 회원님 로그인 되셨습니다.";	
		        model.addAttribute("msgType", "success");
		    }
		    
		    model.addAttribute("message", msg);
		    model.addAttribute("url", "member/memberMyPage");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "아이디 또는 비밀번호가 잘못 되었습니다.\\n아이디와 비밀번호를 정확히 입력해 주세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("message", "로그아웃 되었습니다.");
			model.addAttribute("url", "member/memberLogin");
			model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("message", "비밀번호가 틀립니다. 다시 확인해 주세요.");
			model.addAttribute("url", "member/pwdCheck/d");
		}
		else if(msgFlag.equals("pwdCheckNoP")) {
			model.addAttribute("message", "비밀번호가 틀립니다. 다시 확인해 주세요.");
			model.addAttribute("url", "member/pwdCheck/p");
		}
		else if(msgFlag.equals("pwdCheckNoU")) {
			model.addAttribute("message", "비밀번호가 틀립니다. 다시 확인해 주세요.");
			model.addAttribute("url", "member/pwdCheck/u");
		}
		else if(msgFlag.equals("memberDeleteCheck")) {
			model.addAttribute("message", "탈퇴처리가 완료되었습니다.");
			session.invalidate();
			model.addAttribute("url", "member/memberLogin");
			model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("pwdChangeOk")) {
			model.addAttribute("message", "비밀번호 변경이 완료되었습니다.\\n다시 로그인해 주세요.");
			session.invalidate();
			model.addAttribute("url", "member/memberLogin");
			model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("pwdChangeNo")) {
			model.addAttribute("message", "비밀번호 변경에 실패하였습니다.");
			model.addAttribute("url", "member/pwdCheck/p");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "회원 정보 수정이 완료되었습니다.");
			model.addAttribute("url", "member/memberMyPage");
			model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "회원 정보 수정에 실패하였습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("loginLockTimer")) {
		    Long remaining = (Long) session.getAttribute("remainingTime");
		    if (remaining == null) remaining = 60L; // 기본값 1분
		    model.addAttribute("message", "로그인 실패 5회로 인해 로그인 제한 중입니다.\\n" + remaining + "초 후 다시 시도해주세요.");
		    model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberFindPwdOk")) {
		    model.addAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
		    model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberFindPwdNo")) {
		    model.addAttribute("message", "일치하는 회원 정보가 없습니다.");
		    model.addAttribute("url", "member/memberFindPwd");
		}
		else if(msgFlag.equals("loginRequired")) {
		    model.addAttribute("message", "로그인이 필요합니다.");
		    model.addAttribute("url", "member/memberLogin");
		}
		
		if(msgFlag.equals("boardInputOk")) {
	    model.addAttribute("message", "게시글이 등록되었습니다.");
	    model.addAttribute("url", "board/list");
	    model.addAttribute("msgType", "success");
	  }
		else if(msgFlag.equals("boardDeleteOk")) {
	    model.addAttribute("message", "게시글이 삭제되었습니다.");
	    model.addAttribute("url", "board/list");
	    model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("boardUpdateOk")) {
		    model.addAttribute("message", "게시글이 수정되었습니다.");
		    model.addAttribute("url", "board/content?idx=" + idx);
		    model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("touristInputOk")) {
	    model.addAttribute("message", "관광지 등록이 완료되었습니다.");
	    model.addAttribute("url", "hotel/hotelDetail?idx=" + hotelIdx);
	    model.addAttribute("msgType", "success");
		}
		
		
		
		
		if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("message", "작성하신 글이 등록되었습니다.");
			model.addAttribute("url", "inquiry/inquiryList");
			model.addAttribute("msgType", "success");
		}
		else if(msgFlag.equals("inquiryInputNo")) {
			model.addAttribute("message", "작성하신 글 등록이 실패되었습니다.");
			model.addAttribute("url", "inquiry/inquiryInput");
		}
		else if(msgFlag.equals("inquiryDeleteCheckOk")) {
			model.addAttribute("message", "작성하신 문의글을 삭제하였습니다.");
			model.addAttribute("url", "inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryDeleteCheckNo")) {
			model.addAttribute("message", "작성하신 문의글 삭제가 실패되었습니다.");
			model.addAttribute("url", "inquiry/inquiryDetail?idx="+idx);
		}
		else if(msgFlag.equals("inquiryUpdateOk")) {
			model.addAttribute("message", "작성하신 문의글이 수정되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "inquiry/inquiryDetail?idx="+request.getParameter("idx"));
		}
		else if(msgFlag.equals("inquiryUpdateNo")) {
			model.addAttribute("message", "작성하신 문의글 수정이 실패되었습니다.");
			model.addAttribute("url", "inquiry/inquiryDetail?idx="+idx);
		}
		else if(msgFlag.equals("inquiryReplyOk")) {
			model.addAttribute("message", "작성하신 답변이 등록되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "admin/adInquiryDetail?idx="+request.getParameter("idx"));
		}
		else if(msgFlag.equals("inquiryReplyNo")) {
			model.addAttribute("message", "작성하신 답변등록이 실패되었습니다.");
			model.addAttribute("url", "admin/adInquiryDetail?idx="+idx);
		}
		else if(msgFlag.equals("qnaInputOk")) {
			model.addAttribute("message", "작성하신 QnA가 등록되었습니다");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "qna/qnaList");
		}
		else if(msgFlag.equals("qnaInputNo")) {
			model.addAttribute("message", "작성하신 QnA 등록이 실패되었습니다.");
			model.addAttribute("url", "qna/qnaInput");
		}
		else if(msgFlag.equals("qnaDeleteOk")) {
			model.addAttribute("message", "작성하신 QnA가 삭제되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "qna/qnaList");
		}
		else if(msgFlag.equals("qnaDeleteNo")) {
			model.addAttribute("message", "작성하신 QnA 삭제가 실패되었습니다.");
			model.addAttribute("url", "qna/qnaDetail?idx="+idx);
		}
		else if(msgFlag.equals("qnaUpdateOk")) {
			model.addAttribute("message", "작성하신 QnA가 수정되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "qna/qnaList");
		}
		else if(msgFlag.equals("qnaUpdateNo")) {
			model.addAttribute("message", "작성하신 QnA 수정이 실패되었습니다.");
			model.addAttribute("url", "qna/qnaDetail?idx="+idx);
		}
		else if(msgFlag.equals("qnaInputAdminOk")) {
			model.addAttribute("message", "관리자님의 QnA답변이 등록되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "qna/qnaList");
		}
		else if(msgFlag.equals("qnaInputUserOk")) {
			model.addAttribute("message", "QnA답변이 등록되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "qna/qnaList");
		}
		else if(msgFlag.equals("adFaqInputOk")) {
			model.addAttribute("message", "FAQ가 등록되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "faq/adFaqList");
		}
		else if(msgFlag.equals("adFaqInputNo")) {
			model.addAttribute("message", "FAQ 등록에 실패하였습니다.");
			model.addAttribute("url", "faq/adFaqInput");
		}
		else if(msgFlag.equals("adFaqDeleteOk")) {
			model.addAttribute("message", "FAQ가 삭제되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "faq/adFaqList");
		}
		else if(msgFlag.equals("adFaqDeleteNo")) {
			model.addAttribute("message", "FAQ가 삭제가 실패되었습니다.");
			model.addAttribute("url", "faq/adFaqDetail?idx="+idx);
		}
		else if(msgFlag.equals("adFaqUpdateOk")) {
			model.addAttribute("message", "FAQ가 수정되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "faq/adFaqList");
		}
		else if(msgFlag.equals("adFaqUpdateNo")) {
			model.addAttribute("message", "FAQ 수정이 실패되었습니다.");
			model.addAttribute("url", "faq/adFaqDetail?idx="+idx);
		}
		else if(msgFlag.equals("photogalleryInputOK")) {
			model.addAttribute("message", "게시글이 등록되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "photogallery/photogalleryList");
		}
		else if(msgFlag.equals("photogalleryInputNo")) {
			model.addAttribute("message", "게시글 등록에 실패하였습니다.");
			model.addAttribute("url", "photogallery/photogalleryInput");
		}
		else if(msgFlag.equals("photogalleryNoImage")) {
			model.addAttribute("message", "등록된 사진이 없습니다.\\n게시글 등록에 실패하였습니다.");
			model.addAttribute("url", "photogallery/photogalleryInput");
		}
		else if(msgFlag.equals("photogalleryDeleteOk")) {
			model.addAttribute("message", "선택하신 포토갤러리가 삭제되었습니다.");
			model.addAttribute("url", "photogallery/photogalleryList");
		}
		else if(msgFlag.equals("photogalleryDeleteNo")) {
			model.addAttribute("message", "선택하신 포토갤러리 삭제가 실패되었습니다.");
			model.addAttribute("url", "photogallery/photogalleryInput");
		}
		else if(msgFlag.equals("memberReviewNo")) {
			model.addAttribute("message", "현재 숙박경험하신 이력이 없습니다.");
			model.addAttribute("url", "member/memberMyPage");
		}
		else if(msgFlag.equals("reviewInputOk")) {
			model.addAttribute("message", "리뷰가 작성되었습니다.");
			model.addAttribute("msgType", "success");
			model.addAttribute("url", "review/memberReview");
		}
		else if(msgFlag.equals("reviewInputNo")) {
			model.addAttribute("message", "리뷰 작성에 실패했습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "review/memberReviewInput");
		}
		else if(msgFlag.equals("levelError0")) {
			model.addAttribute("message", "관리자만 접근가능합니다.");
			model.addAttribute("msgType", "error");
			model.addAttribute("url", "");
		}
		
		
		return "include/message";
	}
}
