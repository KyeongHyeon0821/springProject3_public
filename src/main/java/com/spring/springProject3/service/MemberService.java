package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.MemberVo;

public interface MemberService {

	MemberVo getMemberIdCheck(String mid);

	MemberVo getMemberNickNameEmailCheck(String nickName, String email);

	void setKakaoMemberInput(String mid, String nickName, String email, String pwd);

	int setMemberJoinOk(MemberVo vo);

	MemberVo getMemberNickCheck(String nickName);

	void setMemberDeleteCheck(String mid);

	int setMemberPwdChange(String mid, String pwd);

	int setMemberUpdateOk(MemberVo vo);

	MemberVo getMemberIdByNameEmail(String name, String email);
	
	MemberVo getMemberByNameMidEmail(String name, String mid, String email);
	
	void updatePassword(String mid, String pwd);

	MemberVo getMemberBizNoCheck(String businessNo);
	
	List<MemberVo> getMemberList(int section);

	MemberVo getMemberIdxSearch(int idx);



}
