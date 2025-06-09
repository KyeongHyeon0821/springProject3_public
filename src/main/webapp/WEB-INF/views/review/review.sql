/* 리뷰 달기 */
create table review (
  idx           int not null auto_increment,   /* 댓글 고유번호 */
  hotelIdx  int not null,                  /* 원본글 호텔의 고유번호 - 외래키로 지정 */
  roomIdx      int not null,                /* 원본글 호텔-객실의 고유번호*/
  reservationIdx int not null,         /* 예약 아이디 */
  reservationNo varchar(20) not null unique, /* 예약 번호 */
  mid           varchar(20) not null,      /* 댓글 올린이 아이디 */
  nickName  varchar(20) not null,      /* 댓글 올린이 닉네임 */
  roomName   varchar(50) not null,      /* room테이블의 name 참조. 객실명*/
  purpose      varchar(20) not null,      /* 숙박인원의 단위/목적(예:가족과여행/연인과여행/친구와여행/회사/행사) */
  star      int(1) not null default 5,
  content   text not null,               /* 댓글 내용 */
  hostIp      varchar(50) not null,      /* 댓글 올린 PC의 고유 IP */
  reviewDate   datetime default now(),   /* 댓글 올린 날짜/시간 */
  primary key(idx),
  foreign key(hotelIdx) references hotel(idx) on delete cascade,
  foreign key(roomIdx) references room(idx) on delete cascade,
  foreign key(reservationIdx) references reservation(idx),
  foreign key(reservationNo) references reservation(reservationNo)
);