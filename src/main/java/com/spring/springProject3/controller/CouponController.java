package com.spring.springProject3.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.CouponService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.vo.CouponVo;

@RequestMapping("/coupon")
@Controller
public class CouponController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CouponService couponService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
  JavaMailSender mailSender;
	
	

	// 쿠폰관리 폼보기(사용자)
	@RequestMapping(value = "/couponForm", method = RequestMethod.GET)
	public String couponFormGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		String email = memberService.getMemberIdCheck(mid).getEmail();
		List<CouponVo> couponVos = couponService.getUseCouponList();
		model.addAttribute("couponVos", couponVos);
		model.addAttribute("email", email);
		
		List<CouponVo> uVos = couponService.getCouponMidList(mid);
		model.addAttribute("uVos", uVos);
		return "coupon/couponForm";
	}
	
	@RequestMapping(value = "/couponContent/{idx}", method = RequestMethod.GET)
	public String couponContentGet(Model model, @PathVariable int idx) {
		CouponVo vo = couponService.getCouponContent(idx);
		model.addAttribute("vo", vo);
		return "coupon/couponContent";
	}
	
	// 쿠폰 중복 발급 체크
	@ResponseBody
	@RequestMapping(value = "/isCouponAlreadyIssued", method = RequestMethod.POST)
	public String couponCheckPost(String couponCode, HttpSession session) {
		String mid = session.getAttribute("sMid") + "";
		return couponService.getCouponIssuedCheck(mid, couponCode) + "";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/couponIssue", method = RequestMethod.POST)
	public String couponFormPost(int idx, String mid, String email, String couponCode) throws MessagingException {
	    
	    // 쿠폰 기본 정보 조회 
	    CouponVo vo = couponService.getCouponContent(idx);
	    
	    // 사용자 정보 설정
	    vo.setMid(mid);
	    vo.setEmail(email);
	    vo.setUserCouponCode(couponCode);
	    
	    //	QR 코드 생성용 파일 이름 생성 
	    String qrCodeName = projectProvide.newNameCreate(2) + vo.getMid();
	    
	    // QR 코드 안에 들어갈 텍스트 정보 구성
	    String qrCodeImage = "";
	    qrCodeImage += "쿠폰명 : " + vo.getCouponName() + "\n";
	    qrCodeImage += "사용자 아이디 : " + vo.getMid() + "\n";
	    qrCodeImage += "사용자 이메일 : " + vo.getEmail() + "\n";
	    qrCodeImage += "쿠폰코드 : " + vo.getCouponCode() + "\n";
	    qrCodeImage += "할인율(원) : ";
	    if(vo.getDiscountType().equals("P")) qrCodeImage += vo.getDiscountValue() + "%\n";
	    else qrCodeImage += vo.getDiscountValue() + "원\n";
	    qrCodeImage += "쿠폰 발급날짜 : " + qrCodeName.substring(0,2) + "-" + qrCodeName.substring(2,4) + "-" + qrCodeName.substring(4,6) + "\n";
	    qrCodeImage += "쿠폰 사용만료일 : " + vo.getExpiryDate().substring(0,11);

	    // 코드 이미지 생성 및 저장
	    projectProvide.qrCodeCreate(qrCodeName, qrCodeImage, "couponQrcode");

	    //  메일 전송 처리 
	    String couponQrcode = qrCodeName + ".png";  
	    qrMailSend(vo.getEmail(), vo.getCouponName(), vo.getPhoto(), couponQrcode);

	    //  발급된 쿠폰 정보를 DB에 저장
	    vo.setCouponQrcode(couponQrcode);  
	    return couponService.setCouponUserInformation(vo) + ""; 
	}
	
	
	
	public void qrMailSend(String toMail, String couponName, String couponImageFile, String qrCodeImageFile) throws MessagingException {
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

    MimeMessage message = mailSender.createMimeMessage();
    MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

    messageHelper.setTo(toMail);
    messageHelper.setSubject("[withPET] 쿠폰이 발급되었습니다!");

    // HTML 구성
    String content = "";
    content += "<div style='font-family:Arial,sans-serif; font-size:16px; color:#333; max-width:600px; margin:0 auto; padding:20px; border:1px solid #eee; border-radius:8px;'>";

    content += "<div style='text-align:center; margin-bottom:10px;'>";
    content += "<img src='cid:logo' alt='withPET 로고' style='max-width:180px;' />";
    content += "</div>";

    content += "<h2 style='color:#2e7d32; text-align:center;'>🎁 " + couponName + " 쿠폰이 도착했어요!</h2>";
    content += "<p style='text-align:center;'>withPET를 이용해주셔서 감사합니다.<br/>아래 쿠폰 정보를 확인해 주세요.</p>";

    // 쿠폰 이미지
    content += "<div style='text-align:center; margin:20px 0;'>";
    content += "<img src='cid:couponImage' alt='쿠폰 이미지' style='max-width:60%; border:1px solid #ccc; border-radius:6px;' />";
    content += "</div>";

    // QR코드 이미지
    content += "<div style='text-align:center; margin:20px 0;'>";
    content += "<p style='margin-bottom:8px;'>QR 코드를 사용해 빠르게 쿠폰을 확인하세요!</p>";
    content += "<img src='cid:qrCode' alt='쿠폰 QR 코드' style='width:160px; height:160px; border:1px solid #ccc; padding:5px; border-radius:4px;' />";
    content += "</div>";

    // CTA 버튼
    content += "<p style='text-align:center;'><a href='http://localhost:9090/springProject3/' style='background-color:#2e7d32; color:#fff; padding:10px 20px; text-decoration:none; border-radius:4px;'>withPET 바로가기</a></p>";

    content += "<hr style='margin:40px 0;'>";
    content += "<p style='font-size:12px; color:#999;'>본 메일은 발신전용입니다. 문의사항은 홈페이지를 통해 남겨주세요.</p>";
    content += "</div>";

    messageHelper.setText(content, true);

    // 로고 연결
    FileSystemResource logo = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/logo.png"));
    messageHelper.addInline("logo", logo);

    // 쿠폰 이미지 연결
    FileSystemResource couponImg = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/coupon/" + couponImageFile));
    messageHelper.addInline("couponImage", couponImg);

    // QR 코드 이미지 연결
    FileSystemResource qrCodeImg = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/couponQrcode/" + qrCodeImageFile));
    messageHelper.addInline("qrCode", qrCodeImg);

    mailSender.send(message);
}
	
}
