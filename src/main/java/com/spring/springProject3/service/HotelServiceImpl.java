package com.spring.springProject3.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.dao.HotelDao;
import com.spring.springProject3.vo.HotelVo;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class HotelServiceImpl implements HotelService {

	@Autowired
	HotelDao hotelDao;

	@Override
	public List<HotelVo> getHotelList(int startIndexNo, int pageSize) {
		return hotelDao.getHotelList(startIndexNo, pageSize);
	}
	
	// 호텔 등록 처리 (1.썸네일 파일 저장처리, 2.썸네일용 이미지 파일 생성 3.이미지 파일들 이름 가공처리(ckeditor에서 올린것들), 4.실제 업로드 된 이미지 파일만 복사처리, 5.DB 저장처리)
	@Override
	public int setHotelInput(HotelVo vo, MultipartFile thumbnailFile) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		// 1.썸네일 파일 이름 중복처리 후 서버에 저장처리
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String oFileName = thumbnailFile.getOriginalFilename(); // 업로드한 파일명 가져오기
		String sFileName = vo.getMid() + "_" + sdf.format(date) + "_" + oFileName; // 호텔 등록자 아이디 + "_" + 날짜 + "_" + oFileName;
		try {
			writeFile(thumbnailFile, sFileName); // 파일을 서버로 저장처리하는 메소드 호출
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		vo.setThumbnail(sFileName);
		
		// 2. 썸네일용 이미지 파일 만들기 (s_mid_날짜_oFileName)
		String thumbnailPath = realPath + "hotelThumbnail/";
		setThumbnailCreate(thumbnailFile,thumbnailPath, sFileName);
		
		// 3.썸네일 외 이미지들 파일 이름 가공 (파일 복사 하기 위함)
		String images = "";
		if(vo.getImages() != null && !vo.getImages().equals("")) {
			String imagesTemp = vo.getImages();
			//      0         1         2         3         4
			//      012345678901234567890123456789012345678901234567890123456789
			// <img src="/springProject3/data/imagesTemp/admin_250411102640_Image20250325143808.jpg" style="height:853px; width:1280px" />
			int position = 37;
			String nextImg = imagesTemp.substring(imagesTemp.indexOf("src=\"/") + position);
			boolean hasImage = true;
			
			while(hasImage) {
				String imgFileName = nextImg.substring(0, nextImg.indexOf("\""));
				images += imgFileName + "/";
				
				if(nextImg.indexOf("src=\"/") == -1) hasImage = false;
				else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		if(!images.equals("") && images!=null) images = images.substring(0, images.length() -1);
		//vo.setImages(images);
		
		// 4.파일 복사처리
		
		String origFilePath = realPath + "imagesTemp/";
		String copyFilePath = realPath +  "hotelImages/";
		
		String[] imagesArr = images.split("/");
		for(String image : imagesArr) {
			fileCopyCheck(origFilePath+image, copyFilePath+image);
		}
		
		// 4.DB 저장 처리
		vo.setImages(vo.getImages().replace("/imagesTemp", "/hotelImages"));
		return hotelDao.setHotelInput(vo);
	}
	
	// 썸네일용 이미지 파일 만들기
	private void setThumbnailCreate(MultipartFile file, String realPath, String sFileName) {
		try {
			
			// 썸네일 파일이 저장될 경로설정
			File realFileName = new File(realPath + sFileName);
			file.transferTo(realFileName);
			
			// 썸네일 이미지 생성 저장하기
			String thumbnailSaveName = realPath + "s_" + sFileName;
			File thumbnailFile = new File(thumbnailSaveName);
			
			int width = 800;
			int height = 600;
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 5. 파일 복사처리
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

	// 전송된 파일을 서버로 저장처리
	private void writeFile(MultipartFile thumbnailFile, String sFileName) throws IOException {
		// request 부르기 (Controller에서부터 넘겨도 됨)
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/hotelThumbnail/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(thumbnailFile.getBytes().length != -1) {
			fos.write(thumbnailFile.getBytes());
		}
		fos.flush();
		fos.close();
	}

	// 호텔 상세보기
	@Override
	public HotelVo getHotel(int idx) {
		return hotelDao.getHotel(idx);
	}

	// 호텔 상태 업데이트
	@Override
	public int setHotelStatusUpdate(int idx, String status) {
		return hotelDao.setHotelStatusUpdate(idx, status);
	}

	// 호텔 정보 수정 처리
	@Override
	public int setHotelUpdate(HotelVo vo, MultipartFile thumbnailFile) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		// 썸네일 파일 null 또는 비었을 때 기존 썸네일 이름으로 저장
	  if(thumbnailFile == null || thumbnailFile.isEmpty()) {
	  	vo.setThumbnail(vo.getOThumbnail());
	  }
	  else { // 썸네일 이미지 변경 했을 경우
	  	// 기존 썸네일 이미지 삭제 처리
	  	String thubmnailFilePath = realPath + "hotelThumbnail/" +vo.getOThumbnail();
	  	fileDelete(thubmnailFilePath);
	  	thubmnailFilePath = realPath + "hotelThumbnail/" + "s_" + vo.getOThumbnail();
	  	fileDelete(thubmnailFilePath);
	  	// 썸네일 파일 이름 중복처리 후 서버에 저장처리
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			String oFileName = thumbnailFile.getOriginalFilename(); // 업로드한 파일명 가져오기
			String sFileName = vo.getMid() + "_" + sdf.format(date) + "_" + oFileName; // 호텔 등록자 아이디 + "_" + 날짜 + "_" + oFileName;
			try {
				writeFile(thumbnailFile, sFileName); // 파일을 서버로 저장처리하는 메소드 호출
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
			vo.setThumbnail(sFileName);
			// 썸네일용 이미지 파일 만들기 (s_mid_날짜_oFileName)
			String thumbnailPath = realPath + "hotelThumbnail/";
			setThumbnailCreate(thumbnailFile, thumbnailPath, sFileName);
	  }
		
	  
	  // 썸네일 외 이미지들의 파일이 변경 되었다면 기존 이미지들 삭제 처리 후 새로 업로드된 이미지들 복사(imagesTemp -> hotelImages)
		HotelVo dbVo = hotelDao.getHotel(vo.getIdx());
		
		if((dbVo.getImages() == null && vo.getImages() != null) || 
		    (dbVo.getImages() != null && !dbVo.getImages().equals(vo.getImages()))) { // 기존 이미지 내용과 수정 된 이미지 내용이 다르다면 실행
			
			// 기존 이미지들 삭제
			if(dbVo.getImages() != null && !dbVo.getImages().equals("")) imgDelete(dbVo.getImages());
			
			// 썸네일 외 이미지들 파일 이름 가공
			String images = "";
			if(vo.getImages() != null && !vo.getImages().equals("")) {
				String imagesTemp = vo.getImages();
				//      0         1         2         3         4
				//      012345678901234567890123456789012345678901234567890123456789
				// <img src="/springProject3/data/imagesTemp/admin_250411102640_Image20250325143808.jpg" style="height:853px; width:1280px" />
				int position = 37;
				String nextImg = imagesTemp.substring(imagesTemp.indexOf("src=\"/") + position);
				boolean hasImage = true;
				
				while(hasImage) {
					String imgFileName = nextImg.substring(0, nextImg.indexOf("\""));
					images += imgFileName + "/";
					
					if(nextImg.indexOf("src=\"/") == -1) hasImage = false;
					else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
				}
			}
			
			if(images != null && !images.equals("")) images = images.substring(0, images.length() -1);
			//vo.setImages(images);
			
			// 파일 복사처리
			String origFilePath = realPath + "imagesTemp/";
			String copyFilePath = realPath +  "hotelImages/";
			String[] imagesArr = images.split("/");
			for(String image : imagesArr) {
				fileCopyCheck(origFilePath + image, copyFilePath + image);
			}
		}
		
		// DB 저장 처리
		vo.setImages(vo.getImages().replace("/imagesTemp", "/hotelImages"));
		
		return hotelDao.setHotelUpdate(vo);
	}

	// 이미지 파일 삭제 처리
	private void imgDelete(String images) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		//  0         1         2         3         4
		//      012345678901234567890123456789012345678901234567890123456789
		// <img src="/springProject3/data/hotelImages/admin_250411102640_Image20250325143808.jpg" style="height:853px; width:1280px" />
		int position = 38;
		String nextImg = images.substring(images.indexOf("src=\"/") + position);
		boolean hasImage = true;
		
		while(hasImage) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "hotelImages/" + imgFile;
			
			fileDelete(origFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) hasImage = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}
	
	//파일 삭제 처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int getHotelLike(String mid, int idx) {
		return hotelDao.getHotelLike(mid, idx);
	}

	@Override
	public int setHotelLikeOk(String mid, int hotelIdx) {
		return hotelDao.setHotelLikeOk(mid, hotelIdx);
	}

	@Override
	public int setHotelLikeNo(String mid, int hotelIdx) {
		return hotelDao.setHotelLikeNo(mid, hotelIdx);
	}

	@Override
	public List<Integer> getLikedHotelListIdx(String mid) {
		return hotelDao.getLikedHotelListIdx(mid);
	}

	@Override
	public List<HotelVo> getMoreHotels(int lastIdx, int count) {
		return hotelDao.getMoreHotels(lastIdx, count);
	}

	@Override
	public List<HotelVo> getSearchHotelList(String searchString, String checkinDate, String checkoutDate, int guestCount, int petCount, int startIndexNo, int pageSize) {
		return hotelDao.getSearchHotelList(searchString, checkinDate, checkoutDate, guestCount, petCount, startIndexNo, pageSize);
	}

	@Override
	public List<HotelVo> getHotelListByMid(String mid) {
		return hotelDao.getHotelListByMid(mid);
	}

	@Override
	public List<HotelVo> getHotelSearch(int idx) {
		return hotelDao.getHotelSearch(idx);
	}

	@Override
  public List<HotelVo> getRecentHotels(int limit) {
     return hotelDao.getRecentHotels(limit);
  }

	@Override
	public void ImageCopy(String images) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		//			0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/hotelImages/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/ImagesTemp/250321140356_2503.jpg" style="height:854px; width:1280px" />
		int position = 38;
		String nextImg = images.substring(images.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "hotelImages/" + imgFile;
			String copyFilePath = realPath + "ImagesTemp/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}
	
	
	
}
