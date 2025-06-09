package com.spring.springProject3.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.dao.InquiryDao;
import com.spring.springProject3.vo.InquiryReplyVo;
import com.spring.springProject3.vo.InquiryVo;

@Service
public class InquiryServiceImpl implements InquiryService {
	
	@Autowired
	InquiryDao inquiryDao;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<InquiryVo> getInquiryList(int startIndexNo, int pageSize, String mid) {
		return inquiryDao.getInquiryList(startIndexNo, pageSize, mid);
	}

	// 1:1문의작성글에 사진까지 올릴수있음!
	@Override
	public int setInquiryInputOk(MultipartFile mFile, InquiryVo vo) {
		String fName = mFile.getOriginalFilename();
		if(fName != null && !fName.equals("")) {
			try {
				String sFileName = projectProvide.saveFileName(fName);
				writeFile(mFile, sFileName);
				vo.setFSName(sFileName);
			} catch (IOException e) { e.printStackTrace(); }
		}
		
		return inquiryDao.setInquiryInputOk(vo);
	}

	// 전송된 파일을 서버로 저장처리
	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public InquiryVo getInquiryDetail(int idx) {
		return inquiryDao.getInquiryDetail(idx);
	}



	// 1:1문의 작성했던 글 삭제하기
	@Override
	public int setInquiryDelete(int idx) {
		InquiryVo vo = inquiryDao.getInquiryDetail(idx);
		
		if(vo.getFSName() != null && !vo.getFSName().equals("")) {
	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
	    File file = new File(realPath + vo.getFSName());
	    if(file.exists()) file.delete();	    
		}
	  return inquiryDao.setInquiryDelete(idx);
	}

	// 1:1문의 작성했던 글 수정하기
	@Override
	public int setInquiryUpdate(MultipartFile mFile, InquiryVo vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
		
		String fName = mFile.getOriginalFilename();
		if(fName != null && !fName.equals("")) {
			try {
				if(vo.getFSName() != null && !vo.getFSName().equals("")) {
					File file = new File(realPath + vo.getFSName());
			    if(file.exists()) file.delete();
				}
				
				String sFileName = projectProvide.saveFileName(fName);
				writeFile(mFile, sFileName);
				vo.setFSName(sFileName);
			} catch (IOException e) { e.printStackTrace(); }
		}
		
		return inquiryDao.setInquiryUpdate(vo);
	}

	@Override
	public int setInquiryImageDelete(int idx, String fSName) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
    
		File file = new File(realPath + fSName);
    if(file.exists()) file.delete();
    
		return inquiryDao.setInquiryImageDelete(idx);
	}

	@Override
	public InquiryReplyVo getInquiryReply(int idx) {
		return inquiryDao.getInquiryReply(idx);
	}




}
