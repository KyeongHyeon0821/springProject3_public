package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReservationVo {
	private int idx;
	private String reservationNo;
	private String mid;
	private String name;
	private String tel;
	private String email;
	private int roomIdx;
	private String checkinDate;
	private String checkoutDate;
	private int guestCount;
	private int petCount;
	private int totalPrice;
	private String status;
	private String memo;
	private String regDate;
}
