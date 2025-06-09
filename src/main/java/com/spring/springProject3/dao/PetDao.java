package com.spring.springProject3.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.springProject3.vo.PetVo;

public interface PetDao {

    int insertPet(@Param("vo") PetVo vo);

    List<PetVo> getPetList(@Param("memberMid") String memberMid);

    int getPetCountByMember(@Param("memberMid") String memberMid);

    void deletePet(@Param("vo") PetVo vo);

	PetVo getPetById(@Param("petIdx") int petIdx);

    int updatePet(@Param("vo") PetVo vo);
}
