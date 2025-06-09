
--------------------------------------------------------


/* 호텔 테이블 */
create table hotel(
	idx int auto_increment,							/* 호텔 아이디 */
	mid varchar(20) not null,						/* 호텔 등록자 아이디 */
	name varchar(100) not null,				  /* 호텔 이름 */
	address varchar(200) not null,			/* 호텔 주소 */
	tel varchar(20),										/* 호텔 연락처 */
	description text,										/* 호텔 소개글 */
	thumbnail varchar(100) not null,		/* 호텔 썸네일 이미지 */
	images text,												/* 호텔 이미지 */
	regDate datetime default now(), 		/* 등록 날짜 */
	status varchar(20) default '정상',		/* 호텔 상태 (정상/서비스중지요청/서비스중지) */
	x double,														/* 경도 */
	y double,														/* 위도 */
	primary key(idx),
	foreign key(mid) references member(mid)
);
alter table hotel add column status varchar(20) default '정상';
select * from hotel;
insert into hotel values(default, 'admin', '롯데시티호텔 명동', '서울 중구 삼일대로 362', '02-6112-1000', '롯데시티호텔명동은 서울 시내 비즈니스와 쇼핑의 중심지인 명동과 서울의 오아시스인 청계천 사이에 위치하고 있으며, 27층 규모의 탁 트인 전망과 430의 객실과 멀티 스타일리시 뷔페 레스토랑, 미팅룸, 피트니스 등을 갖춘 프리미엄 비즈니스호텔입니다. 성공적인 비즈니스와 만족스런 여행을 위한 최고의 실용성과 차별화된 서비스, 합리적인 가격으로 비즈니스 고객과 레저여행객 모두에게 잊지 못할 추억을 선사합니다.', '롯데시티호텔명동.jpg',null, default);
insert into hotel values(default, 'admin', '소테츠호텔즈 더 스프라지르 서울 명동', '서울 중구 남대문로5길 15', '02-772-0900', '서울 비즈니스 구역 중심에 위치한 ''소테츠 호텔즈 더 스프라지르 서울 명동''은 ''지하철 4호선 회현역 7번출구''와 ''지하철 1, 2호선 시청역 7번출구''에서 도보 7분 내에 위치하고 있어 서울의 주요 관광지와 명소에 편리하게 이동할 수 있으며, 공항 리무진 버스를 타고 70분 안에 인천국제공항에 도착할 수 있습니다.', '소테츠호텔.jpg', null, default);




/* 호텔 객실 테이블 */
create table room(
	idx int auto_increment,						/* 객실 아이디 */
	hotelIdx int not null,						/* 연결된 호텔 아이디 */
	name varchar(50) not null,				/* 객실명 */
	price int not null,								/* 객실 1박 요금 */
	maxPeople int not null,						/* 최대 인원 수 */
	petSizeLimit varchar(10),					/* 반려견 크기 제한 (소형/중형/대형) */
	petCountLimit int default 1,			/* 최대 반려견 수 */
	thumbnail varchar(100) not null,	/* 객실 썸네일 이미지 */
	images text,											/* 객실 이미지 */
	status varchar(20) default '정상', /* 객실 상태 (정상/비활성화/삭제) */
	regDate datetime default now(),		/* 등록 날짜 */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx) on delete cascade
);




/* 예약 테이블 */
create table reservation (
  idx           int auto_increment primary key,         /* 예약 번호	*/
  mid      		  varchar(20) not null,                		/* 예약한 회원 아이디 */
  roomIdx       int not null,                           /* 예약한 객실 번호 */
  checkinDate  date not null,                           /* 체크인 날짜 */
  checkoutDate date not null,                           /* 체크아웃 날짜 */
  status        varchar(20) default '대기중',     		    /* 예약 상태 (대기중, 예약완료, 예약취소) */
  regDate       datetime default now(), 						    /* 예약 등록일 */
  foreign key (mid) references member(mid) on delete cascade,
  foreign key (roomIdx) references room(idx) on delete cascade
);


/* 찜 테이블 */
create table hotelLike (
	idx int auto_increment primary key,				/* 찜 번호 */
	mid varchar(20) not null,									/* 찜한 회원 아이디 */
	hotelIdx int not null,										/* 찜한 호텔 아이디 */
	likedDate datetime default now(),					/* 찜한 날짜 */
	UNIQUE KEY (mid, hotelIdx),
	foreign key (mid) references member(mid) on delete cascade,
  foreign key (hotelIdx) references hotel(idx) on delete cascade
);



insert into hotelLike values(default, 'admin', 29, default);
select * from hotellike;

select idx from hotelLike where mid = 'admin';

select * from hotel where status = '정상' order by idx desc;  

select min(price) from room where hotelIdx = 29;

select hotel.*, min(room.price) as minPrice from hotel left outer join room on hotel.idx = room.hotelIdx
where hotel.status = '정상' group by hotel.idx order by hotel.idx desc;


SELECT * FROM hotel
  WHERE name LIKE CONCAT('%', '호텔', '%')
  AND EXISTS (
    SELECT 1 
    FROM room r
    WHERE r.hotelidx = hotel.idx 
      AND r.maxpeople >= 1
      AND r.petcountlimit >= 1
      AND r.status = '정상'
      AND NOT EXISTS (
        SELECT 1 
        FROM reservation res
        WHERE res.roomidx = r.idx
          AND res.status IN ('결제대기', '결제완료') 
          AND (res.checkinDate < '2025-04-30' AND res.checkoutDate > '2025-04-29')
      )
  );
  
  
select h.idx, h.name, h.thumbnail, h.address, h.tel, min(r.price) as minprice, round(avg(rv.star), 1) as averageStar 
from hotel h
left outer join room r on h.idx = r.hotelidx
left outer join review rv on rv.hotelidx = h.idx
where (h.name like concat('%', '소노', '%') 
   or h.address like concat('%', '서울', '%'))
   and h.status = '정상'
   and exists (
       select 1 
       from room r2
       where r2.hotelidx = h.idx 
         and r2.maxpeople >= 1
         and r2.petcountlimit >= 1
         and r2.status = '정상'
         and not exists (
             select 1 
             from reservation res
             where res.roomidx = r2.idx
               and res.status in ('결제대기', '결제완료')
               and (res.checkindate < '2025-05-03' and res.checkoutdate > '2025-05-02')
         )
   )
group by h.idx
order by h.idx desc
limit 0, 6
;


/* 전체 호텔리스트 조회 최종 */
select 
  h.idx,
  h.name,
  h.thumbnail,
  h.address,
  h.tel,
  roomPrice.minPrice,
  reviewStats.averageStar,
  reviewStats.reviewCount
from hotel h
left join (
  select hotelIdx, min(price) as minPrice
  from room
  group by hotelIdx
) roomPrice on h.idx = roomPrice.hotelIdx
left join (
  select hotelIdx, round(avg(star), 1) as averageStar, count(*) as reviewCount
  from review
  group by hotelIdx
) reviewStats on h.idx = reviewStats.hotelIdx
where h.status = '정상'
order by h.idx desc
limit 0, 6;


/* 검색으로 호텔리스트 조회 최종 */
/* 예약 가능한 객실의 최저가와 평점 */
select 
  h.idx, 
  h.name, 
  h.thumbnail, 
  h.address, 
  h.tel, 
  
  (
    select min(r2.price)
    from room r2
    where r2.hotelIdx = h.idx
      and r2.maxPeople >= 1
      and r2.petCountLimit >= 1
      and r2.status = '정상'
      and not exists (
        select 1
        from reservation res
        where res.roomIdx = r2.idx
          and res.status in ('결제대기', '결제완료')
          and (res.checkInDate < '2025-05-03' and res.checkOutDate > '2025-05-02')
      )
  ) as minPrice,
  
  (
    select ifnull(round(avg(rv.star), 1), 0.0)
    from review rv
    where rv.hotelIdx = h.idx
  ) as averageStar,
  
  (
    select count(rv.idx)
    from review rv
    where rv.hotelIdx = h.idx
  ) as reviewCount

from hotel h
where (h.name like concat('%', '소노', '%') or h.address like concat('%', '서울', '%'))
  and h.status = '정상'
  and exists (
    select 1
    from room r2
    where r2.hotelIdx = h.idx
      and r2.maxPeople >= 1
      and r2.petCountLimit >= 1
      and r2.status = '정상'
      and not exists (
        select 1
        from reservation res
        where res.roomIdx = r2.idx
          and res.status in ('결제대기', '결제완료')
          and (res.checkInDate < '2025-05-03' and res.checkOutDate > '2025-05-02')
      )
  )
order by h.idx desc
limit 0, 6;


