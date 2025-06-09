package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.PhotogalleryVo;
import com.spring.springProject3.vo.TouristSpotVo;

public interface PhotogalleryService {

	List<PhotogalleryVo> getPhotogalleryList(int startIndexNo, int pageSize, String part);

	int setPhotogalleryInputOk(PhotogalleryVo vo);

	void imgCheck(String content);

	PhotogalleryVo getPhotogalleryDetail(int idx);

	void setPhotogalleryGoodCheck(int idx);

	int setPhotogalleryDelete(int idx);

	int setPhotogalleryReadNumPlus(int idx);

	List<TouristSpotVo> getTouristSpotList();

}
