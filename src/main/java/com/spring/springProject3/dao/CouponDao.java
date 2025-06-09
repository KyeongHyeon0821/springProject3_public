package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.CouponVo;

public interface CouponDao {

	int getTotRecCnt(@Param("couponType") String couponType, @Param("couponActive") int couponActive);
	
	List<CouponVo> getCouponList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("couponType") String couponType, @Param("couponActive") int couponActive);

	int setCouponInput(@Param("vo") CouponVo vo);

	CouponVo getCouponContent(@Param("idx") int idx);

	int setCouponUpdate(@Param("vo") CouponVo vo);

	int setCouponDeleteCheck(@Param("idx") int idx);

	List<CouponVo> getUseCouponList();

	int setCouponUserInformation(@Param("vo") CouponVo vo);

	List<CouponVo> getCouponCodeList(@Param("couponCode") String couponCode);

	List<CouponVo> getCouponMidList(@Param("mid") String mid);

	int setUserCouponCodeUsed(@Param("userCouponCode") String userCouponCode);

	int getCouponIssuedCheck(@Param("mid") String mid, @Param("couponCode") String couponCode);

	List<CouponVo> getAvailableMyCoupons(@Param("mid") String mid);

	void setMyCouponUse(@Param("mid") String mid, @Param("couponCode") String couponCode);

}
