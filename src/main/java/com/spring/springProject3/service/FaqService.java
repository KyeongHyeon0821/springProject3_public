package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.FaqVo;

public interface FaqService {

	List<FaqVo> getFaqList(int startIndexNo, int pageSize, String category, String searchString);

	int setAdFaqInputOk(FaqVo vo);

	void setFaqReadNumPlus(int idx);

	FaqVo getFaqDetail(int idx);

	FaqVo getPreNextSearch(int idx, String preNext);

	int setFaqDelete(int idx);

	void imgCheck(String content, String string, String string2);

	void imgBackup(String content);

	int setFaqUpdate(FaqVo vo);

	void imgCheck(String content);

	void imgDelete(String content);

}
