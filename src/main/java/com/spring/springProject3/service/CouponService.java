package com.spring.springProject3.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.vo.CouponVo;

public interface CouponService {

	List<CouponVo> getCouponList(int startIndexNo, int pageSize, String couponType, int couponActive);

	int setCouponInput(MultipartFile fName, CouponVo vo);

	CouponVo getCouponContent(int idx);

	int setCouponUpdate(MultipartFile fName, CouponVo vo);

	int setCouponDeleteCheck(int idx);

	List<CouponVo> getUseCouponList();

	int setCouponUserInformation(CouponVo vo);

	List<CouponVo> getCouponCodeList(String couponCode);

	List<CouponVo> getCouponMidList(String mid);

	int setUserCouponCodeUsed(String userCouponCode);

	int getCouponIssuedCheck(String mid, String couponCode);

	List<CouponVo> getAvailableMyCoupons(String mid);

	void setMyCouponUse(String mid, String couponCode);

}
