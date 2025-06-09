package com.spring.springProject3.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.vo.HotelVo;

public interface HotelService {

	List<HotelVo> getHotelList(int startIndexNo, int pageSize);

	int setHotelInput(HotelVo vo, MultipartFile thumbnailFile);

	HotelVo getHotel(int idx);

	int setHotelStatusUpdate(int idx, String status);

	int setHotelUpdate(HotelVo vo, MultipartFile thumbnailFile);

	int getHotelLike(String mid, int idx);

	int setHotelLikeOk(String mid, int hotelIdx);

	int setHotelLikeNo(String mid, int hotelIdx);

	List<Integer> getLikedHotelListIdx(String mid);

	List<HotelVo> getMoreHotels(int lastIdx, int count);

	List<HotelVo> getSearchHotelList(String searchString, String checkinDate, String checkoutDate, int guestCount, int petCount, int startIndexNo, int pageSize);

	List<HotelVo> getHotelListByMid(String mid);

	List<HotelVo> getHotelSearch(int idx);
	
	List<HotelVo> getRecentHotels(int limit);

	void ImageCopy(String images);

}
