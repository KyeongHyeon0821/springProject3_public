create table tourist_spot (
  idx int auto_increment primary key,        -- 관광지 고유번호
  hotelIdx int not null,                     -- 해당 호텔과 연관 (호텔 상세페이지용)
  name varchar(30) not null,                 -- 관광지 이름
  lat varchar(30) not null,                  -- 위도
  lng varchar(30) not null,                  -- 경도
  address varchar(200),                      -- 주소
  description text,                          -- 관광지 설명
  foreign key (hotelIdx) references hotel(idx) on delete cascade
);

select t.*, h.idx as hotelOriIdx, h.name as hotelName, h.description as hotelDescription, h.address as hotelAddress, h.tel as hotelTel from hotel h, tourist_spot t where h.status = '정상' and h.idx=1064 order by h.idx desc limit 1;

select * from hotel where status = '정상' order by idx desc;  