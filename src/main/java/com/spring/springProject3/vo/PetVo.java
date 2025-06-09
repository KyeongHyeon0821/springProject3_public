package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PetVo {
	private int petIdx;
	private String memberMid;
	private String petName;
	private String breed;
	private String petGender;
	private String petAge;
	private String weight;
	private String photo;
	private String memo;
}
