package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardReplyVo {
	private int idx;
  private int boardIdx;
  private String mid;
  private String nickName;
  private String content;
  private String createdAt;
}
