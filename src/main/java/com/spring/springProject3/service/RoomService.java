package com.spring.springProject3.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.OptionVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

public interface RoomService {

	int setRoomInput(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles);

	List<OptionVo> getOptionList();

	int getMaxIdx();

	int setRoomOptions(int roomIdx, int optionIdx);

	List<RoomVo> getRoomList(int idx);

	RoomVo getRoom(int roomIdx);

	List<OptionVo> getRoomOptionList(int roomIdx);

	int setRoomUpdate(RoomVo vo);

	int setDeleteRoomOptions(int idx);

	int setUpdateImages(int idx, String images);

	int setDeleteImages(int idx);

	int setRoomThumbnailAndImageUpdate(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles);

	int setroomStatusUpdate(int idx, String status);

	List<RoomVo> getAvailableRoomList(int idx, String checkinDate, String checkoutDate, int guestCount, int petCount);

	List<ReservationListVo> getRoomUsedList(String mid);

	List<ReservationVo> getReviewSave(String mid);

	ReviewVo getReviewSaveCheck(String reservationNo);

	
}
