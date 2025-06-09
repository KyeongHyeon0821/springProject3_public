package com.spring.springProject3.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TouristSpotVo {
    private int idx;
    private int hotelIdx;
    private String name;
    private String lat;         
    private String lng;         
    private String address;     
    private String description; 
    
//    private int hotelOriIdx;         
//    private String hotelName;         
//    private String hotelDescription;         
//    private String hotelAdress;         
//    private String hotelTel;         
    
}
