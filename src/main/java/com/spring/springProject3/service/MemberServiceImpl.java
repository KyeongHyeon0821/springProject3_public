package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.MemberDao;
import com.spring.springProject3.vo.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberDao memberDao;

    @Override
    public MemberVo getMemberIdCheck(String mid) {
        return memberDao.getMemberIdCheck(mid);
    }

    @Override
    public int setMemberJoinOk(MemberVo vo) {
        return memberDao.setMemberJoinOk(vo);
    }

    @Override
    public MemberVo getMemberNickNameEmailCheck(String nickName, String email) {
        return memberDao.getMemberNickNameEmailCheck(nickName, email);
    }

    @Override
    public MemberVo getMemberNickCheck(String nickName) {
        return memberDao.getMemberNickCheck(nickName);
    }

    @Override
    public void setMemberDeleteCheck(String mid) {
        memberDao.setMemberDeleteCheck(mid);
    }

    @Override
    public int setMemberPwdChange(String mid, String pwd) {
        return memberDao.setMemberPwdChange(mid, pwd);
    }

    @Override
    public int setMemberUpdateOk(MemberVo vo) {
        return memberDao.setMemberUpdateOk(vo);
    }

    @Override
    public void setKakaoMemberInput(String mid, String nickName, String email, String pwd) {
        memberDao.setKakaoMemberInput(mid, nickName, email, pwd);
    }

	@Override
	public MemberVo getMemberIdByNameEmail(String name, String email) {
		return memberDao.getMemberIdByNameEmail(name, email);
	}
	
	@Override
	public MemberVo getMemberByNameMidEmail(String name, String mid, String email) {
	    return memberDao.getMemberByNameMidEmail(name, mid, email);
	}

	@Override
	public void updatePassword(String mid, String pwd) {
	    memberDao.updatePassword(mid, pwd);
	}

	@Override
	public MemberVo getMemberBizNoCheck(String businessNo) {
	    return memberDao.getMemberBizNoCheck(businessNo);
	}
	
	@Override
	public List<MemberVo> getMemberList(int section) {
		return memberDao.getMemberList(section);
	}

	@Override
	public MemberVo getMemberIdxSearch(int idx) {
		return memberDao.getMemberIdxSearch(idx);
	}
}
