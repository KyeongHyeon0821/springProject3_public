package com.spring.springProject3.vo;


import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("deprecation")
public class HotelVo {
	private int idx;
	
	@NotEmpty(message = "호텔 이름이 공백입니다.")
	@Size(max = 100, message = "호텔 이름은 100자 이내여야 합니다.")
	private String name;
	
	@NotEmpty(message = "등록자 아이디가 공백 입니다.")
	private String mid;
	
	@NotEmpty(message = "호텔 주소가 공백입니다.")
	@Size(max = 200, message = "호텔 주소는 200자 이내여야 합니다.")
	private String address;
	
	@Size(max = 20, message = "호텔 연락처는 20자 이내여야 합니다.")
	private String tel;
	
	private String description;
	private String thumbnail;
	private String images;
	private String regDate;
	private String status;
	private String oThumbnail;
	private Double x;
	private Double y;
	private int minPrice;
	private int spotIdx;
  private int spotHotelIdx;
  private String spotName;
  private String spotLat;         
  private String spotLng;         
  private String spotAddress;     
  private String spotDescription; 
  private double averageStar;
  private int reviewCnt;
}
