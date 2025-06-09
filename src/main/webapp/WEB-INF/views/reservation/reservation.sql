/* 예약 테이블 */
create table reservation (
  idx           int auto_increment primary key,         /* 예약 아이디	*/
  reservationNo varchar(20) not null unique,					  /* 예약 번호 (년월일시분 10자리 + uuid 2자리 + 객실idx) */
  mid      		  varchar(20) not null,                		/* 예약한 회원 아이디 */
  name					varchar(10) not null,										/* 예약자 이름 */
  tel						varchar(15) not null,										/* 예약자 연락처 */
  email					varchar(50) not null,										/* 예약자 이메일 */
  roomIdx       int not null,                           /* 예약한 객실 번호 */
  checkinDate  date not null,                           /* 체크인 날짜 */
  checkoutDate date not null,                           /* 체크아웃 날짜 */
  guestCount    int not null,                           /* 인원 수 */
  petCount      int not null,                           /* 반려견 수 */
  totalPrice    int not null,                           /* 총 결제 금액 */
  status        varchar(20) not null default '대기중',    /* 예약 상태 (결제대기, 결제완료, 예약취소, 이용완료, 리뷰작성) */
  memo					varchar(300),														/* 예약자 메모 */
  regDate       datetime default now(), 						    /* 예약 등록일 */
  foreign key (mid) references member(mid) on delete cascade,
  foreign key (roomIdx) references room(idx) on delete cascade
);
ALTER TABLE reservation ADD CONSTRAINT unique_reservationNo UNIQUE (reservationNo);
select * from reservation;
SELECT * FROM room 
WHERE hotelIdx = 29 AND maxPeople >= 1 AND petCountLimit >= 1
  AND status = '정상'
  AND idx NOT IN (SELECT roomIdx
									FROM reservation
									WHERE status != '예약취소'
  									AND (checkinDate < '2025-04-26' AND checkoutDate > '2025-04-25'))
  									order by name desc;
