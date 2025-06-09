package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;

public interface ReviewDao {

	int setReviewInputOk(@Param("vo") ReviewVo vo);

	ReservationListVo getRoomIdxCheck(@Param("roomIdx") int roomIdx,@Param("mid") String mid);

	List<ReviewVo> getRoomReviewList(@Param("roomIdx") int roomIdx);

	List<Integer> getReviewTotCount(@Param("hotelIdx") List<Integer> hotelIdx);

	List<ReviewVo> getRoomReviewAllList();

	List<ReservationListVo> getRoomUsedAllList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("choice") String choice, @Param("mid") String mid);

	List<ReviewVo> getHotelReviewList(@Param("idx") int idx);
	
	List<ReviewVo> getLatestReviews();

	List<HotelVo> getTopRatedHotels();

	List<Integer> getExistReviewedCheck(@Param("mid") String mid);

	void setReviewStatusBack(@Param("vo") ReviewVo vo);

	int setReviewDelete(@Param("vo") ReviewVo vo);

	int setReviewUpdateCheckOk(@Param("vo") ReviewVo vo);

}
