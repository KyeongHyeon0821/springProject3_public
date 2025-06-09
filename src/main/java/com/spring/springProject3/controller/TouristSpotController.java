package com.spring.springProject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.TouristSpotService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.TouristSpotVo;

@Controller
public class TouristSpotController {

    @Autowired
    TouristSpotService touristSpotService;
    
    @Autowired
    HotelService hotelService;

    // 관광지 등록 폼 이동
    @GetMapping("/touristSpotInput")
    public String touristInputForm(@RequestParam("hotelIdx") int hotelIdx, Model model) {
        model.addAttribute("hotelIdx", hotelIdx);
        
        HotelVo hotelVo = hotelService.getHotel(hotelIdx);
        if (hotelVo != null) {
            model.addAttribute("hotelName", hotelVo.getName());
            model.addAttribute("hotelX", hotelVo.getX()); // 경도 (lng)
            model.addAttribute("hotelY", hotelVo.getY()); // 위도 (lat)
        }
        return "touristSpot/touristSpotInput";
    }

    // 관광지 등록 처리
    @PostMapping("/touristInput")
    public String touristInputSubmit(TouristSpotVo vo) {
    	if (touristSpotService.checkSpot(vo.getHotelIdx(), vo.getName())) {
        return "redirect:/message/touristInputDuplicate?hotelIdx=" + vo.getHotelIdx();
      }
      touristSpotService.insertTouristSpot(vo);
      return "redirect:/message/touristInputOk?hotelIdx=" + vo.getHotelIdx(); // 등록 후 해당 호텔 상세로 이동
    }
}
