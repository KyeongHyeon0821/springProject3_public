package com.spring.springProject3.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springProject3.dao.FaqDao;
import com.spring.springProject3.vo.FaqVo;

@Service
public class FaqServiceImpl implements FaqService {

	@Autowired
	FaqDao faqDao;

	@Override
	public List<FaqVo> getFaqList(int startIndexNo, int pageSize, String category, String searchString) {
		return faqDao.getFaqList(startIndexNo, pageSize, category, searchString);
	}

	@Override
	public int setAdFaqInputOk(FaqVo vo) {
		return faqDao.setAdFaqInputOk(vo);
	}

	@Override
	public void setFaqReadNumPlus(int idx) {
		faqDao.setFaqReadNumPlus(idx);
	}

	@Override
	public FaqVo getFaqDetail(int idx) {
		return faqDao.getFaqDetail(idx);
	}

	@Override
	public FaqVo getPreNextSearch(int idx, String preNext) {
		return faqDao.getPreNextSearch(idx, preNext);
	}

	@Override
	public int setFaqDelete(int idx) {
		return faqDao.setFaqDelete(idx);
	}
	
	@Override
	public void imgCheck(String content) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "faq/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 게시글에 사진포함되어 있을때 사진 삭제하기
	@Override
	public void imgDelete(String content) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "faq/" + imgFile;
			
			fileDelete(origFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void imgBackup(String content) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/board/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "faq/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
  public void imgCheck(String content, String aFlag, String bFlag) {
    //      0         1         2         3    3    4         5         6
    //      01234567890123456789012345678901234567890123456789012345678901234567890
    // <img src="/springProject3/data/ckeditor/240111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
    // <img src="/springProject3/data/qna/240111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
  // content안에 그림파일이 존재할때만 작업을 수행 할수 있도록 한다.(src="/_____~~)
    if(content.indexOf("src=\"/") == -1) return;
    
    HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    //String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
    
    int position = 0;
    if(aFlag.equals("ckeditor")) position = 35;
    else if(aFlag.equals("qna")) position = 30;
    String nextImg = content.substring(content.indexOf("src=\"/") + position);
    boolean sw = true;
    
    while(sw) {
       String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
       
       String origFilePath = realPath + aFlag + "/" + imgFile;
       String copyFilePath = realPath + bFlag + "/" + imgFile;
       
       fileCopyCheck(origFilePath, copyFilePath);  // __폴더에 파일을 복사하고자 한다.
       
       if(nextImg.indexOf("src=\"/") == -1) {
          sw = false;
       }
       else {
          nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
       }
    }
 }



	@Override
	public int setFaqUpdate(FaqVo vo) {
		return faqDao.setFaqUpdate(vo);
	}

}
