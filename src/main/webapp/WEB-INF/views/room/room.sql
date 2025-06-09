/* 객실 테이블 */
create table room(
	idx int auto_increment,									/* 객실 아이디 */
	mid varchar(20) not null,								/* 호텔 등록자 아이디 */
	hotelIdx int not null,									/* 연결된 호텔 아이디 */
	name varchar(50) not null,							/* 객실명 */
	roomNumber varchar(20),									/* 객실 이름(번호) */
	price int not null,											/* 객실 1박 요금 */
	maxPeople int not null,									/* 최대 인원 수 */
	petSizeLimit varchar(10) not null,			/* 반려견 크기 제한 (소형/중형/대형) */
	petCountLimit int not null default 1,		/* 최대 반려견 수 */
	thumbnail varchar(100) not null,				/* 객실 썸네일 이미지 */
	images text,														/* 객실 이미지 */
	status varchar(20) default '정상', 				/* 객실 상태 (정상/서비스중지요청/서비스중지) */
	regDate datetime default now(),					/* 등록 날짜 */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx) on delete cascade,
	foreign key(mid) references member(mid)
);
select images from room where idx =6;


/* 객실 옵션 테이블 */
create table options (
  idx int auto_increment,         /* 옵션 아이디 */
  name varchar(50) not null,      /* 옵션 이름 */
  primary key (idx)
);

insert into options(name) values('TV');
insert into options(name) values('욕조');
insert into options(name) values('에어컨');
insert into options(name) values('냉장고');
insert into options(name) values('드라이기');
insert into options(name) values('전자레인지');
insert into options(name) values('전기포트');
insert into options(name) values('와이파이');
insert into options(name) values('반려견 방석');
insert into options(name) values('반려견 배변패드');
insert into options(name) values('반려견 샴푸');
insert into options(name) values('반려견 식기');
insert into options(name) values('펫 타월');
insert into options(name) values('피트니스 센터');
insert into options(name) values('실내 수영장');
insert into options(name) values('야외 수영장');
insert into options(name) values('레스토랑');
insert into options(name) values('금연객실');
insert into options(name) values('흡연구역');
insert into options(name) values('짐보관가능');
insert into options(name) values('주차가능');
insert into options(name) values('카페');
insert into options(name) values('레스토랑');
insert into options(name) values('엘리베이터');
insert into options(name) values('24시데스크');
insert into options(name) values('조식운영');
insert into options(name) values('테라스/발코니');


/* 객실-옵션 연결 테이블 */
create table roomOptions (
  roomIdx int not null,											/* 객실 아이디 */
  optionIdx int not null,										/* 옵션 아이디 */
  primary key (roomIdx, optionIdx),
  foreign key (roomIdx) references room(idx) on delete cascade,
  foreign key (optionIdx) references options(idx) on delete cascade
);

select * from options where idx in (select optionIdx from roomOptions where roomIdx = 1);

select * from roomOptions where roomIdx=4;

SELECT * FROM room 
WHERE hotelIdx = 29 AND maxPeople >= 1 AND petCountLimit >= 1
  AND status = '정상'
  AND idx NOT IN (SELECT roomIdx
									FROM reservation
									WHERE status != '예약취소'
  									AND (checkinDate < '2025-04-26' AND checkoutDate > '2025-04-25'));
  	
select * from reservation where status  != '예약취소';
