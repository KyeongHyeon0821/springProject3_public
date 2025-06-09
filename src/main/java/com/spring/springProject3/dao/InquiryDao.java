package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.InquiryReplyVo;
import com.spring.springProject3.vo.InquiryVo;

public interface InquiryDao {

	int getInquiryTotRecCnt(@Param("mid") String mid);

	List<InquiryVo> getInquiryList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize, @Param("mid") String mid);

	int setInquiryInputOk(@Param("vo") InquiryVo vo);

	InquiryVo getInquiryDetail(@Param("idx") int idx);

	int setInquiryDelete(@Param("idx") int idx);

	int setInquiryUpdate(@Param("vo") InquiryVo vo);

	int setInquiryImageDelete(@Param("idx") int idx);

	InquiryReplyVo getInquiryReply(@Param("idx") int idx);

}
