package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.spring.springProject3.vo.TouristSpotVo;

public interface TouristSpotDao {

	List<TouristSpotVo> getSpotsByHotelIdx(int hotelIdx);

	void insertTouristSpot(TouristSpotVo vo);
	
	int checkSpot(@Param("hotelIdx") int hotelIdx, @Param("name") String name);

}
