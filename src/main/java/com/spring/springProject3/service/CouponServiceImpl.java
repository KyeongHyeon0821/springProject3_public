package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.dao.CouponDao;
import com.spring.springProject3.vo.CouponVo;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	CouponDao couponDao;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<CouponVo> getCouponList(int startIndexNo, int pageSize, String couponType, int couponActive) {
		return couponDao.getCouponList(startIndexNo, pageSize, couponType, couponActive);
	}

	@Override
	public int setCouponInput(MultipartFile fName, CouponVo vo) {
		String oFileName = fName.getOriginalFilename();
		String sFileName = projectProvide.newDateToString() + projectProvide.newNumberCreate(2) + "_" + oFileName;
		
		// 서버에 파일 올리기
		try {
			projectProvide.writeFile(fName, sFileName, "coupon");
			vo.setPhoto(sFileName);
		} catch (Exception e) { e.printStackTrace(); }
		
		return couponDao.setCouponInput(vo);
	}

	@Override
	public CouponVo getCouponContent(int idx) {
		return couponDao.getCouponContent(idx);
	}

	@Override
	public int setCouponUpdate(MultipartFile fName, CouponVo vo) {
		CouponVo tempVo = couponDao.getCouponContent(vo.getIdx());
		String oFileName = fName.getOriginalFilename();
		
		// 새로올린파일이 없으면 기존 파일명으로, 새로올린파일이 있으면 새화일명을 편집해서 업로드시킨다.(단, 기존파일은 삭제한다.)
		if(oFileName.equals("")) vo.setPhoto(tempVo.getPhoto());
		else {
			String sFileName = projectProvide.newDateToString() + projectProvide.newNumberCreate(2) + "_" + oFileName;
			try {
				projectProvide.deleteFile(tempVo.getPhoto(), "coupon");		// 원본파일삭제
				projectProvide.writeFile(fName, sFileName, "coupon");	// 새로올린파일 업로드
				vo.setPhoto(sFileName);
			} catch (Exception e) { e.printStackTrace(); }
		}
		return couponDao.setCouponUpdate(vo);
	}

	@Override
	public int setCouponDeleteCheck(int idx) {
		CouponVo vo = couponDao.getCouponContent(idx);
		projectProvide.deleteFile(vo.getPhoto(), "coupon");
		return couponDao.setCouponDeleteCheck(idx);
	}

	@Override
	public List<CouponVo> getUseCouponList() {
		return couponDao.getUseCouponList();
	}

	@Override
	public int setCouponUserInformation(CouponVo vo) {
		return couponDao.setCouponUserInformation(vo);
	}

	@Override
	public List<CouponVo> getCouponCodeList(String couponCode) {
		return couponDao.getCouponCodeList(couponCode);
	}

	@Override
	public List<CouponVo> getCouponMidList(String mid) {
		return couponDao.getCouponMidList(mid);
	}

	@Override
	public int setUserCouponCodeUsed(String userCouponCode) {
		return couponDao.setUserCouponCodeUsed(userCouponCode);
	}

	@Override
	public int getCouponIssuedCheck(String mid, String couponCode) {
		return couponDao.getCouponIssuedCheck(mid, couponCode);
	}

	@Override
	public List<CouponVo> getAvailableMyCoupons(String mid) {
		return couponDao.getAvailableMyCoupons(mid);
	}

	@Override
	public void setMyCouponUse(String mid, String couponCode) {
		couponDao.setMyCouponUse(mid, couponCode);
	}
	
}
