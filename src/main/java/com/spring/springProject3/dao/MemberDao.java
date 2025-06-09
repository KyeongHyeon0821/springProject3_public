package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.MemberVo;

public interface MemberDao {

  MemberVo getMemberIdCheck(@Param("mid") String mid);

  int setMemberJoinOk(@Param("vo") MemberVo vo);

  MemberVo getMemberNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

  void setKakaoMemberInput(@Param("mid") String mid, @Param("nickName") String nickName, @Param("email") String email, @Param("pwd") String pwd);

  MemberVo getMemberNickCheck(@Param("nickName") String nickName);

  void setMemberDeleteCheck(@Param("mid") String mid);

  int setMemberPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

  int setMemberUpdateOk(@Param("vo") MemberVo vo);

  MemberVo getMemberIdByNameEmail(@Param("name") String name, @Param("email") String email);

  MemberVo getMemberByNameMidEmail(@Param("name") String name, @Param("mid") String mid, @Param("email") String email);
  
  void updatePassword(@Param("mid") String mid, @Param("pwd") String pwd);

	MemberVo getMemberBizNoCheck(String businessNo);
	
	List<MemberVo> getMemberList(@Param("section") int section);

	MemberVo getMemberIdxSearch(@Param("idx") int idx);


}
