package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomVo {
	private int idx;
	private String mid;
	private int hotelIdx;
	private String name;
	private String roomNumber;
	private int price;
	private int maxPeople;
	private String petSizeLimit;
	private int petCountLimit;
	private String thumbnail;
	private String images;
	private String status;
	private String regDate;
	
	private String oThumbnail;
	private int availableCount;
}
