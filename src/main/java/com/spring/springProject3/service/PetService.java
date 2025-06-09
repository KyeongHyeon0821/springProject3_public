package com.spring.springProject3.service;

import java.util.List;
import com.spring.springProject3.vo.PetVo;

public interface PetService {
	
    int insertPet(PetVo vo);
    
    List<PetVo> getPetList(String memberMid);
    
    int getPetCountByMember(String memberMid);

	void deletePet(PetVo vo);

	PetVo getPetById(int petIdx);

	int updatePet(PetVo vo);
}