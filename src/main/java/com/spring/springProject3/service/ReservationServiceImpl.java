package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.ReservationDao;
import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.ReviewVo;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	ReservationDao reservationDao;

	@Override
	public int setReservationInput(ReservationVo vo) {
		return reservationDao.setReservationInput(vo);
	}

	@Override
	public void setReservationUpdateToDone() {
		reservationDao.setReservationUpdateToDone();
	}

	@Override
	public void setReservationAutoCancel() {
		reservationDao.setReservationAutoCancel();
	}

	@Override
	public int setReservationPaymentOk(String reservationNo) {
		return reservationDao.setReservationPaymentOk(reservationNo);
	}

	@Override
	public ReservationVo getReservation(String reservationNo) {
		return reservationDao.getReservation(reservationNo);
	}

	@Override
	public List<ReservationVo> getMyReservations(String mid) {
		return reservationDao.getMyReservations(mid);
	}
	
	@Override
	public void setReviewCheckOk(ReviewVo vo) {
		reservationDao.setReviewCheckOk(vo);
	}

	@Override
	public int setReservationCancel(String mid, String reservationNo) {
		return reservationDao.setReservationCancel(mid, reservationNo);
	}

	@Override
	public void setReviewSave(ReviewVo vo) {
		reservationDao.setReviewSave(vo);
	}
}
