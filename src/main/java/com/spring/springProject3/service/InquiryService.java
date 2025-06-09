package com.spring.springProject3.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.vo.InquiryReplyVo;
import com.spring.springProject3.vo.InquiryVo;

public interface InquiryService {

	List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String mid);

	int setInquiryInputOk(MultipartFile mFile, InquiryVo vo);

	InquiryVo getInquiryDetail(int idx);

	int setInquiryDelete(int idx);

	int setInquiryUpdate(MultipartFile mFile, InquiryVo vo);

	int setInquiryImageDelete(int idx, String fSName);

	InquiryReplyVo getInquiryReply(int idx);



}
