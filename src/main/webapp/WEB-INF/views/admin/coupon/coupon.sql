show tables;

/* 사용할 쿠폰정보테이블 */
create table coupon (
  idx		int not null auto_increment,
  couponType char(1) not null default 'R',			/* 쿠폰분류(R:예약,E:이벤트) */
  couponCode varchar(13) not null,							/* 쿠폰코드(2025042500R) : 년월일(8)+숫자2자리+구분(R:예약,E:이벤트) */
  couponName varchar(50) not null,							/* 발행 쿠폰 이름 */
  discountType  char(1) not null default 'P', 	/* 쿠폰 할인유형 : P(Percentage:퍼센트), A(Amount:정액-현금) */
  discountValue double not null,								/* 할인 값(퍼센트비율, 금액) */
  issueDate  datetime  not null default now(),	/* 쿠폰 최초 발행일 */
  expiryDate datetime  not null default now(),	/* 쿠폰 사용 만료일 */
  isActive   tinyint   not null default 0,			/* 쿠폰 활성화(1), 비화성화(0) */
  photo      varchar(50),												/* 발행 쿠폰 안내 사진 */
  primary key(idx),
  unique key(couponCode)
);
drop table coupon;
desc coupon;

/* 사용자가 쿠폰사용하기위해 발급받은 쿠폰정보 등록하기 */
create table couponUser (
  userCouponIdx		int not null auto_increment,		/* 사용자에게 발급한 쿠폰 고유번호 */
  userCouponCode varchar(13) not null,						/* 사이트에서 발행한 쿠폰코드번호 */
  mid		varchar(20) not null,											/* 쿠폰 발급받은 사용자 아이디 */
  email	varchar(50) not null,											/* 쿠폰 발급받은 사용자 이메일 */
  userIssueDate datetime not null default now(),	/* 사용자 쿠폰 발행일 */
  isUse   char(4) not null default '미사용',				/* 쿠폰 사용 여부(미사용, 사용완료) */
  usedDate datetime not null default now(),				/* 쿠폰 사용날짜 */
  couponQrcode varchar(50) not null,							/* 발행한 쿠폰의 Qr코드(쿠폰코드+'_'+아이디+'.png') */
  primary key(userCouponIdx),
  foreign key(userCouponCode) references coupon(couponCode),
  foreign key(mid)  references member(mid)
);
drop table couponUser;

select ifnull(count(*), 0) from coupon;

select * from coupon order by idx desc limit 0,10;
select * from coupon where isActive = 1 order by idx desc limit 0,10;
select * from coupon where couponType = 'R' order by idx desc limit 0,10;
select * from coupon where couponType = 'R' and isActive = 0 order by idx desc limit 0,10;
select u.*, (select expiryDate from coupon where couponCode=u.userCouponCode) as expiryDate, (select photo from coupon where couponCode=u.userCouponCode) as photo from coupon c, couponUser u where u.userCouponCode = c.couponCode and u.userCouponCode = '202505206326E' order by expiryDate;
select u.*, (select expiryDate from coupon where couponCode=u.userCouponCode) as expiryDate from coupon c, couponUser u where u.userCouponCode = c.couponCode and mid = 'yd12321' order by expiryDate;

delete from coupon where idx = 5;

select count(*) from couponuser where usercouponCode = '202505206326E' and mid = 'yd12321';

select couponuser.*, coupon.discountType as discountType, coupon.discountValue as discountValue, coupon.couponname as couponName
from couponuser, coupon
where couponuser.usercouponcode = coupon.couponcode and couponuser.mid = 'yd12321' and couponuser.isUse = '미사용';

update couponUser set isUse='사용완료', usedDate = now() where mid = 'yd12321' and userCouponCode = '202505208050E';
