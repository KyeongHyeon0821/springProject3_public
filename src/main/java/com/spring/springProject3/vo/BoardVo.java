package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVo {
	private int idx;
	private String mid;
	private String title;
	private String content;
	private int readCount;
	private String createdAt;
	
	private String nickName;
}
