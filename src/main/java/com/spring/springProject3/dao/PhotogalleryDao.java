package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.PhotogalleryVo;
import com.spring.springProject3.vo.TouristSpotVo;

public interface PhotogalleryDao {

	List<PhotogalleryVo> getPhotogalleryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	int setPhotogalleryInputOk(@Param("vo") PhotogalleryVo vo);

	PhotogalleryVo getPhotogalleryDetail(@Param("idx") int idx);

	int getPhotogalleryTotRecCntSearch(@Param("part") String part);

	void setPhotogalleryGoodCheck(@Param("idx") int idx);

	int setPhotogalleryDelete(@Param("idx") int idx);

	int setPhotogalleryReadNumPlus(@Param("idx") int idx);

	List<TouristSpotVo> getTouristSpotList();

}
