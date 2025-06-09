package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.RoomVo;

public interface AdminService {

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize);

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String choice);

	InquiryVo getInquiryDetail(int idx);

	int setInquiryReplyOk(int idx, String reContent);

	void setInquiryReplyStatusOk(int idx);

	int setAdInquiryDetailUpdate(int reIdx, String reContent);

	int setAdInquiryDetailHold(int idx);

	String setReviewDelete(String reviewStr);

	List<HotelVo> getAdHotelList(int startIndexNo, int pageSize);
	
	String setHotelStatusSelectCheck(String idxSelectArray, String statusSelect);

	List<RoomVo> getAdminRoomList(int hotelIdx);

	String setRoomStatusSelectCheck(String idxSelectArray, String statusSelect);

	RoomVo getRoomDetailSearch(int idx);
	
	
}
