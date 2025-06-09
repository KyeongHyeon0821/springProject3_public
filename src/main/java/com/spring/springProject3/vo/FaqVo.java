package com.spring.springProject3.vo;

import lombok.Data;

@Data
public class FaqVo {
	private int idx;
	private String category;
	private String title;
	private String content;
	private int readNum;

}
