package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.OptionVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

public interface RoomDao {

	int setRoomInput(@Param("vo") RoomVo vo);

	List<OptionVo> getOptionList();

	int getMaxIdx();

	int setRoomOptions(@Param("roomIdx") int roomIdx, @Param("optionIdx") int optionIdx);

	List<RoomVo> getRoomList(@Param("idx") int idx);

	RoomVo getRoom(@Param("roomIdx") int roomIdx);

	List<OptionVo> getRoomOptionList(@Param("roomIdx") int roomIdx);

	int setRoomUpdate(@Param("vo") RoomVo vo);

	int setDeleteRoomOptions(@Param("idx") int idx);

	int setUpdateImages(@Param("idx") int idx, @Param("images") String images);

	int setDeleteImages(@Param("idx") int idx);

	int setRoomThumbnailAndImageUpdate(@Param("vo") RoomVo vo);

	int setroomStatusUpdate(@Param("idx") int idx, @Param("status") String status);

	List<RoomVo> getAvailableRoomList(@Param("idx") int idx, @Param("checkinDate") String checkinDate, @Param("checkoutDate") String checkoutDate, 
			@Param("guestCount") int guestCount, @Param("petCount") int petCount);

	List<ReservationListVo> getRoomUsedList(@Param("mid") String mid);
	
	List<ReservationVo> getReviewSave(@Param("mid") String mid);

	ReviewVo getReviewSaveCheck(@Param("reservationNo") String reservationNo);

}
