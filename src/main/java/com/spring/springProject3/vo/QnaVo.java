package com.spring.springProject3.vo;

import lombok.Data;

@Data
public class QnaVo {
	private int idx;
	private int qnaIdx;
	private String mid;
	private String nickName;
	private String title;
	private String email;
	private String content;
	private int ansLevel;
	private String openSw;
	private String qnaSw;
	private String wDate;
	private String delCheck;
	
	private String qnaAnswer;
}
