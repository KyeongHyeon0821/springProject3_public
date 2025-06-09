package com.spring.springProject3.vo;

import lombok.Data;

@Data
public class ReviewVo {

	private int idx;
	private int hotelIdx;
	private int roomIdx;
	private int reservationIdx;
	private String reservationNo;
	private int reviewTotCnt;
	private int reviewCnt;
	private String mid;
	private String nickName;
	private String roomName;
	private String purpose;
	private String star;
	private String content;
	private String hostIp;
	private String reviewDate;
	private String hotelName;
}
