package com.spring.springProject3.common;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Service
public class ProjectProvide {
	
	@Autowired
	JavaMailSender mailSender;

	// 파일 저장하는 메소드 (업로드파일명, 저장파일명, 저장경로)
	public void writeFile(MultipartFile fName, String sFileName, String urlPath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	// 파일 삭제처리
	public void deleteFile(String photo, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		File file = new File(realPath + photo);
		if(file.exists()) file.delete();
	}

	// 파일명 중복방지를 위한 처리1
	public String saveFileName(String oFileName) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		return sdf.format(date) + "_" + oFileName;
	}
	
	// 파일명 중복방지를 위한 처리2
	public String newNameCreate(int len) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
		String newName = sdf.format(date);
		newName += RandomStringUtils.randomAlphanumeric(len) + "_";
		return newName;
	}

	// QR Code 생성하기
	public void qrCodeCreate(String qrCodeName, String qrCodeImage, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		try {
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1");
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 200, 200);
			
			int qrCodeColor = 0xFF000000;
			int qrCodeBackColor = 0xFFFFFFFF;
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
	}

	public static void imagesDelete(String content, String string) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+string+"/");
		
		File file = new File(realPath + content);
		if(file.exists()) file.delete();
		
	}

  // 1.공통으로 사용하는 ckeditor폴더(aFlag)에 임시그림파일 저장후 실제 저장할폴더(qna)로 복사하기(사용될 실제 파일이 저장될 경로를 bFlag에 받아온다.)
 // 2.실제로 저장된 폴더(qna(aFlag))에서, 공통으로 사용하는 ckeditor폴더(bFlag)에 그림파일을 복사하기
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

	private static void fileCopyCheck(String origFilePath, String copyFilePath) {
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
	
	// 지정길이만큼의 숫자 입력받기 : (int) (Math.random()*(최대값-최소값+1)) + 최소값
	public String newNumberCreate(int num) {
		long randomNum = 0;
		
		if(num >= 8)      randomNum = (int)(Math.random()*(99999999-10000000+1)) + 10000000;
		else if(num >= 7) randomNum = (int)(Math.random()*(9999999 -1000000 +1)) + 1000000;
		else if(num >= 6) randomNum = (int)(Math.random()*(999999  -100000  +1)) + 100000;
		else if(num >= 5) randomNum = (int)(Math.random()*(99999   -10000   +1)) + 10000;
		else              randomNum = (int)(Math.random()*(9999    -1000    +1)) + 1000;
		
		return randomNum + "";
	}
	
	public void imgBackup(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
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

	public void imgDelete(String content, String filePath) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/photogallery/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/faq/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 0;
		if(filePath.equals("faq")) position = 30;
		if(filePath.equals("photogallery")) position = 39;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + filePath + "/" + imgFile;
			
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
	
	//날짜(년월일)를 문자형식으로 돌려주는 메소드
	public String newDateToString() {
		String strDate = LocalDateTime.now().toString();
		return strDate.substring(0,4) + strDate.substring(5,7) + strDate.substring(8,10);
	}
	
	//QR코드 메일 전송하기
	public void qrMailSend(String email, String title, String couponImage, String qrCodeName) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 작성한 메세지들의 정보를 모두 저장시킨후 작업처리...
		messageHelper.setTo(email);			// 받는 사람 메일 주소
		messageHelper.setSubject(title);	// 메일 제목
		messageHelper.setText(content);		// 메일 내용
		
		// 메세지 보관함의 내용(content)에 , 발신자의 필요한 정보를 추가로 담아서 전송처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>"+title+"</h3><hr><br>";
		content += "<p><img src=\"cid:"+couponImage+"\" width='500px'></p>";
		content += "<p>아래 발송된 QR코드를 방문시 직원에게 제시해주세요.</p>";
		content += "<p><img src=\"cid:"+qrCodeName+"\" width='250px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재될 그림파일의 경로를 별도로 표시시켜준다. 그런후 다시 보관함에 저장한다.
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/coupon/"+couponImage));
		messageHelper.addInline(couponImage, file);
		
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/couponQrcode/"+qrCodeName));
		messageHelper.addInline(qrCodeName, file);
		
		// 메일 전송하기
		mailSender.send(message);
	}

	
}
