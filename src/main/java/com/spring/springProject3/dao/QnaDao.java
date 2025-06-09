package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.QnaVo;

public interface QnaDao {
	List<QnaVo> getQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	int setQnaInputOk(@Param("vo") QnaVo vo);

	int getMaxIdxSearch();

	QnaVo getQnaDetail(@Param("idx") int idx);

	int setQnaDelete(@Param("idx") int idx);

	QnaVo getQnaContent(@Param("idx") int idx);

	int setQnaUpdate(@Param("vo") QnaVo vo);

	int getMaxIdx();

	int qnaAdminInputOk(@Param("qnaIdx") int qnaIdx);

	void qnaAdminAnswerUpdateOk(@Param("qnaIdx") int qnaIdx);

	void qnaInputOk(@Param("vo") QnaVo vo);

	void setQnaDeleteOne(@Param("idx") int idx);

	void setQnaAdminUpdate(@Param("qnaIdx") int qnaIdx);

	void setQnaDelCheckUpdate(@Param("idx") int idx);

	int getQnaIdxCheck(@Param("qnaIdx") int qnaIdx);

	int getQnaTotRecCnt();

	int getQnaTotRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	List<QnaVo> getQnaSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	int getQnaTotRecCntQnaAnswer(@Param("qnaAnswer") String qnaAnswer);

	List<QnaVo> getQnaListQnaAnswer(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("qnaAnswer") String qnaAnswer);

}
