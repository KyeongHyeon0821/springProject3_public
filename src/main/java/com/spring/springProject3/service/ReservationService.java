package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;

public interface ReservationService {

	int setReservationInput(ReservationVo vo);

	void setReservationUpdateToDone();

	void setReservationAutoCancel();

	int setReservationPaymentOk(String reservationNo);

	ReservationVo getReservation(String reservationNo);

	List<ReservationVo> getMyReservations(String mid);
	
	void setReviewCheckOk(ReviewVo vo);

	int setReservationCancel(String mid, String reservationNo);

	void setReviewSave(ReviewVo vo);

}
