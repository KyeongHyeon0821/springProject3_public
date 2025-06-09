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

import com.spring.springProject3.dao.PhotogalleryDao;
import com.spring.springProject3.vo.PhotogalleryVo;
import com.spring.springProject3.vo.TouristSpotVo;

@Service
public class PhotogalleryServiceImpl implements PhotogalleryService {
	
	@Autowired
	PhotogalleryDao photogalleryDao;

	@Override
	public List<PhotogalleryVo> getPhotogalleryList(int startIndexNo, int pageSize, String part) {
		return photogalleryDao.getPhotogalleryList(startIndexNo, pageSize, part);
	}

	@Override
	public int setPhotogalleryInputOk(PhotogalleryVo vo) {
		return photogalleryDao.setPhotogalleryInputOk(vo);
	}

	@Override
	public void imgCheck(String content) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/ckeditor/photogallery/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "photogallery/" + imgFile;
			
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

		@Override
		public PhotogalleryVo getPhotogalleryDetail(int idx) {
			return photogalleryDao.getPhotogalleryDetail(idx);
		}


		@Override
		public void setPhotogalleryGoodCheck(int idx) {
			photogalleryDao.setPhotogalleryGoodCheck(idx);
		}

		@Override
		public int setPhotogalleryDelete(int idx) {
			return photogalleryDao.setPhotogalleryDelete(idx);
		}

		@Override
		public int setPhotogalleryReadNumPlus(int idx) {
			return photogalleryDao.setPhotogalleryReadNumPlus(idx);
		}

		@Override
		public List<TouristSpotVo> getTouristSpotList() {
			return photogalleryDao.getTouristSpotList();
		}

}
