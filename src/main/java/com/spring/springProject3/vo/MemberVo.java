package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVo {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String gender;
	private String birthday;
	private String tel;
	private String address;
	private String email;
	private String userDel;
	private int level;
	private String businessNo;
	private String userInfor;
	
	private int visitCnt;
	private int todayCnt;
	private String startDate;
	private String lastDate;
	
	
	private int section;
	private String deleteDiff;
}
