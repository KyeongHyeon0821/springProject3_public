package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.ReviewDao;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao reviewDao;

	@Override
	public int setReviewInputOk(ReviewVo vo) {
		return reviewDao.setReviewInputOk(vo);
	}

	@Override
	public ReservationListVo getRoomIdxCheck(int roomIdx, String mid) {
		return reviewDao.getRoomIdxCheck(roomIdx, mid);
	}

	@Override
	public List<ReviewVo> getRoomReviewList(int roomIdx) {
		return reviewDao.getRoomReviewList(roomIdx);
	}

	@Override
	public List<Integer> getReviewTotCount(List<Integer> hotelIdx) {
		return reviewDao.getReviewTotCount(hotelIdx);
	}

	@Override
	public List<ReviewVo> getRoomReviewAllList() {
		return reviewDao.getRoomReviewAllList();
	}

	@Override
	public List<ReservationListVo> getRoomUsedAllList(int startIndexNo, int pageSize, String choice, String mid) {
		return reviewDao.getRoomUsedAllList(startIndexNo, pageSize, choice, mid);
	}

	@Override
	public List<ReviewVo> getHotelReviewList(int idx) {
		return reviewDao.getHotelReviewList(idx);
	}
	
	@Override
	public List<ReviewVo> getLatestReviews() {
	    return reviewDao.getLatestReviews();
	}
	
	@Override
	public List<HotelVo> getTopRatedHotels() {
	    return reviewDao.getTopRatedHotels();
	}
	
	@Override
	public List<Integer> getExistReviewedCheck(String mid) {
		return reviewDao.getExistReviewedCheck(mid);
	}

	@Override
	public void setReviewStatusBack(ReviewVo vo) {
		reviewDao.setReviewStatusBack(vo);
	}

	@Override
	public int setReviewDelete(ReviewVo vo) {
		return reviewDao.setReviewDelete(vo);
	}

	@Override
	public int setReviewUpdateCheckOk(ReviewVo vo) {
		return reviewDao.setReviewUpdateCheckOk(vo);
	}
	
}
