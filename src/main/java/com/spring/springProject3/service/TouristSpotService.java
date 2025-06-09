package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.TouristSpotVo;

public interface TouristSpotService {
	
	List<TouristSpotVo> getSpotsByHotelIdx(int hotelIdx);

	void insertTouristSpot(TouristSpotVo vo);
	
	boolean checkSpot(int hotelIdx, String name);
	
}
