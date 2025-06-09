package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.PetDao;
import com.spring.springProject3.vo.PetVo;

@Service
public class PetServiceImpl implements PetService {

    @Autowired
    PetDao petDao;

    @Override
    public int insertPet(PetVo vo) {
        return petDao.insertPet(vo);
    }

    @Override
    public List<PetVo> getPetList(String memberMid) {
        return petDao.getPetList(memberMid);
    }

    @Override
    public int getPetCountByMember(String memberMid) {
        return petDao.getPetCountByMember(memberMid);
    }

    @Override
    public void deletePet(PetVo vo) {
        petDao.deletePet(vo);
    }

	@Override
	public PetVo getPetById(int petIdx) {
		return petDao.getPetById(petIdx);
	}

	@Override
	public int updatePet(PetVo vo) {
		return petDao.updatePet(vo);
	}
}
