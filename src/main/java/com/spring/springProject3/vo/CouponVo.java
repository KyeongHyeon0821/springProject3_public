package com.spring.springProject3.vo;

import lombok.Data;

@Data
public class CouponVo {
	// 발급 쿠폰정보
	private int idx;
	private String couponType;
	private String couponCode;
	private String couponName;
	private String discountType;
	private double discountValue;
	private String issueDate;
	private String expiryDate;
	private String isActive;
	private String photo;
	
	// 사용자에게 발급한 쿠폰 정보
	private String part;
	private int userCouponIdx;
	private String userCouponCode;
	private String mid;
	private String email;
	private String userIssueDate;
	private String isUse;
	private String usedDate;
	private String couponQrcode;
}
