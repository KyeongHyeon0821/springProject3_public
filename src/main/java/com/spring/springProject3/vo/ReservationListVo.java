
package com.spring.springProject3.vo;

import lombok.Data;

@Data
public class ReservationListVo  {
	private String roomIdx;
	private String hotelIdx;
	private String roomName;
	private int reservationIdx;
	private int roomNumber;
	private String price;
	private String maxPeople;
	private String petSizeLimit;
	private String petCountLimit;
	private String hotelThumbnail;
	private String roomThumbnail;
	private String hotelName;
	
	private String reservationNo; 	// 예약 번호
	private String checkinDate;
	private String checkoutDate;
	private int guestCount;
	private int petCount;
	private int totalPrice;
	
	
	
}
