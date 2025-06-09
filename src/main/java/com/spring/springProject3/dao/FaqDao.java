package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.FaqVo;

public interface FaqDao {
	
	int getFaqTotRecCntSearch(@Param("category") String category, @Param("searchString") String searchString);

	List<FaqVo> getFaqList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("category") String category, @Param("searchString") String searchString);
	

	int setAdFaqInputOk(@Param("vo") FaqVo vo);


	void setFaqReadNumPlus(@Param("idx") int idx);


	FaqVo getFaqDetail(@Param("idx") int idx);


	FaqVo getPreNextSearch(@Param("idx") int idx, @Param("preNext") String preNext);


	int setFaqDelete(@Param("idx") int idx);


	int setFaqUpdate(@Param("vo") FaqVo vo);

}
