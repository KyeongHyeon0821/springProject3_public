package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

public interface ReviewService {

	int setReviewInputOk(ReviewVo vo);

	ReservationListVo getRoomIdxCheck(int roomIdx, String mid);

	List<ReviewVo> getRoomReviewList(int roomIdx);

	List<Integer> getReviewTotCount(List<Integer> hotelIdx);

	List<ReviewVo> getRoomReviewAllList();

	List<ReviewVo> getHotelReviewList(int idx);

	List<ReviewVo> getLatestReviews();

	List<HotelVo> getTopRatedHotels();
	
	List<Integer> getExistReviewedCheck(String mid);

	void setReviewStatusBack(ReviewVo vo);

	int setReviewDelete(ReviewVo vo);

	int setReviewUpdateCheckOk(ReviewVo vo);
	
	List<ReservationListVo> getRoomUsedAllList(int startIndexNo, int pageSize, String choice, String mid);
	


}
