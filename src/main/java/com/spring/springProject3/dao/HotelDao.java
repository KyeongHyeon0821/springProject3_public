package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;

public interface HotelDao {

	List<HotelVo> getHotelList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int setHotelInput(@Param("vo") HotelVo vo);

	HotelVo getHotel(@Param("idx") int idx);

	int setHotelStatusUpdate(@Param("idx") int idx, @Param("status") String status);

	int setHotelUpdate(@Param("vo") HotelVo vo);

	int getHotelLike(@Param("mid") String mid, @Param("idx") int idx);

	int setHotelLikeOk(@Param("mid") String mid, @Param("hotelIdx") int hotelIdx);

	int setHotelLikeNo(@Param("mid") String mid, @Param("hotelIdx") int hotelIdx);

	List<Integer> getLikedHotelListIdx(@Param("mid") String mid);

	List<HotelVo> getMoreHotels(@Param("lastIdx") int lastIdx, @Param("count") int count);

	List<HotelVo> getSearchHotelList(@Param("searchString") String searchString, @Param("checkinDate") String checkinDate, @Param("checkoutDate") String checkoutDate, @Param("guestCount") int guestCount, @Param("petCount") int petCount, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	List<HotelVo> getHotelListByMid(@Param("mid") String mid);

	List<HotelVo> getHotelSearch(@Param("idx") int idx);

	List<HotelVo> getRecentHotels(@Param("limit") int limit);

}
