package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.RoomVo;

public interface AdminDao {

	List<InquiryVo> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int getInquiryTotRecCnt(@Param("choice") String choice);

	List<InquiryVo> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("choice") String choice);

	InquiryVo getInquiryDetail(@Param("idx") int idx);

	int setInquiryReplyOk(@Param("idx") int idx, @Param("reContent") String reContent);

	void setInquiryReplyStatusOk(@Param("idx") int idx);

	int setAdInquiryDetailUpdate(@Param("reIdx") int reIdx, @Param("reContent") String reContent);

	int setAdInquiryDetailHold(@Param("idx") int idx);
	
  int getReviewTotRecCnt(@Param("choice") String choice);

  void setReviewDelete(@Param("idx") int idx);

	List<HotelVo> getAdHotelList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);
	
	void setHotelStatusSelectCheck(@Param("idx") int idx,@Param("statusSelect") String statusSelect);
	
	void setRoomStatusSelectCheck(@Param("idx") int idx,@Param("statusSelect") String statusSelect);
	
	RoomVo getRoomDetailSearch(@Param("idx") int idx);

	List<RoomVo> getAdminRoomList(@Param("hotelIdx") int hotelIdx);


}
