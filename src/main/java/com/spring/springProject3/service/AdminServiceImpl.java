package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.AdminDao;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.RoomVo;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDao adminDao;

	@Override
	public List<InquiryVo> getInquiryList(int startIndexNo, int pageSize) {
		return adminDao.getInquiryList(startIndexNo, pageSize);
	}

	@Override
	public List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String choice) {
		return adminDao.getInquiryList(startIndexNo, pageSize, choice);
	}

	@Override
	public InquiryVo getInquiryDetail(int idx) {
		return adminDao.getInquiryDetail(idx);
	}

	@Override
	public int setInquiryReplyOk(int idx, String reContent) {
		return adminDao.setInquiryReplyOk(idx, reContent);
	}

	@Override
	public void setInquiryReplyStatusOk(int idx) {
		adminDao.setInquiryReplyStatusOk(idx);
	}

	@Override
	public int setAdInquiryDetailUpdate(int reIdx, String reContent) {
		return adminDao.setAdInquiryDetailUpdate(reIdx, reContent);
	}

	@Override
	public int setAdInquiryDetailHold(int idx) {
		return adminDao.setAdInquiryDetailHold(idx);
	}

	@Override
	public String setReviewDelete(String reviewStr) {
		String[] reviewNum = reviewStr.split("/");
		System.out.println("reviewStr : " + reviewStr );
		
		String str = "0";
		for(String idx : reviewNum) {
			adminDao.setReviewDelete(Integer.parseInt(idx));
			str = "1";
		}
		return str;
	}

	@Override
	public List<HotelVo> getAdHotelList(int startIndexNo, int pageSize) {
		return adminDao.getAdHotelList(startIndexNo, pageSize);
	}
	
	@Override
	public String setHotelStatusSelectCheck(String idxSelectArray, String statusSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		String str = "0";
		for(String idx : idxSelectArrays) {
			adminDao.setHotelStatusSelectCheck(Integer.parseInt(idx), statusSelect);
			str = "1";
		}
		return str;
	}
	
	@Override
	public String setRoomStatusSelectCheck(String idxSelectArray, String statusSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		String str = "0";
		for(String idx : idxSelectArrays) {
			adminDao.setRoomStatusSelectCheck(Integer.parseInt(idx),  statusSelect);
			str = "1";
		}
		return str;
	}
	
	
	@Override
	public RoomVo getRoomDetailSearch(int idx) {
		return adminDao.getRoomDetailSearch(idx);
	}

	@Override
	public List<RoomVo> getAdminRoomList(int hotelIdx) {
		return  adminDao.getAdminRoomList(hotelIdx);
	}


	
	
	
	
	
	
	
	
	
}
