package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.TouristSpotDao;
import com.spring.springProject3.vo.TouristSpotVo;

@Service
public class TouristSpotServiceImpl implements TouristSpotService {

    @Autowired
    TouristSpotDao touristSpotDao;

    @Override
    public List<TouristSpotVo> getSpotsByHotelIdx(int hotelIdx) {
        return touristSpotDao.getSpotsByHotelIdx(hotelIdx);
    }

    @Override
    public void insertTouristSpot(TouristSpotVo vo) {
        touristSpotDao.insertTouristSpot(vo);
    }
    
    @Override
    public boolean checkSpot(int hotelIdx, String name) {
        return touristSpotDao.checkSpot(hotelIdx, name) > 0;
    }

} 
