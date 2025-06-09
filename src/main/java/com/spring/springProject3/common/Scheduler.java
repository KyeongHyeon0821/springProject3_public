package com.spring.springProject3.common;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.springProject3.service.ReservationService;

@Component
public class Scheduler {

	@Autowired
	ReservationService reservationService;
	
	// 매일 밤 12시 예악 상태 없데이트
  @Scheduled(cron = "0 0 0 * * *")
  public void processReservationStatusNightly() {
    reservationService.setReservationAutoCancel();   // 결제대기 -> 예약취소 (당일 미결제시)
    reservationService.setReservationUpdateToDone(); // 결제완료 -> 이용완료 (결제 후 숙박 완료시)
  }
  
  
  // 매일 새벽 1시 imagesTemp폴더 내 모든 파일 삭제
  @Scheduled(cron = "0 0 1 * * *")
  public void deleteAllFilesInFolder() {
		File folder = new File("D:\\springProject\\project\\works\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\springProject3\\resources\\data\\imagesTemp");
		if(!folder.exists()) return;
		
		File[] files = folder.listFiles();
		
		if(files.length != 0) {
			for(File file : files) {
				file.delete();
			}
		}
	}
  	
  
}
