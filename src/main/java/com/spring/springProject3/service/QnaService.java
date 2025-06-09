package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.QnaVo;

public interface QnaService {

	List<QnaVo> getQnaList(int startIndexNo, int pageSize, String mid);

	void imgCheck(String content);

	int setQnaInputOk(QnaVo vo);

	int getMaxIdxSearch();

	QnaVo getQnaDetail(int idx);

	void imgDelete(String content);

	QnaVo getQnaContent(int idx);

	void imgBackup(String content);

	int setQnaUpdate(QnaVo vo);

	int getMaxIdx();

	int getQnaIdxCheck(int qnaIdx);

	void qnaInputOk(QnaVo vo);

	void qnaAdminAnswerUpdateOk(int qnaIdx);

	void qnaAdminInputOk(int qnaIdx);

	void setQnaDelete(int idx);

	void setQnaDeleteOne(int idx);

	void setQnaAdminUpdate(int qnaIdx);

	void setQnaDelCheckUpdate(int idx);

	List<QnaVo> getQnaSearchList(int startIndexNo, int pageSize, String search, String searchString);

	List<QnaVo> getQnaListQnaAnswer(int startIndexNo, int pageSize, String mid, String qnaAnswer);

}
