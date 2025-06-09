package com.spring.springProject3.vo;

import lombok.Data;

@Data
public class InquiryVo {
	private int idx;
	private String mid;
	private String title;
	private String part;
	private String wDate;
	private String reservation;
	private String content;
	private String fSName;
	private String reply;
	
	private int reIdx;
	private int inquiryIdx;
	private String reWDate;
	private String reContent;
}
