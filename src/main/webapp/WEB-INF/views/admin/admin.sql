show tables;




-- 공부용입니다 프로젝트용 아닙니다--


select * from member;

select mid from member where userDel='OK';

--날짜함수--
select now();
select year(now());
select month(now());
select day(now());
select hour(now());
select minute(now());
select second(now());
select week(now());
select weekday(now());
select weekday('2025-3-22');
select weekday('2025-3-23');

select day(now()),month(now()),day(now());
select day(now()) 년,month(now()) 월,day(now()) 일;

select concat(year(now()),'-',month(now()),'-',day(now())) as ymd;

-- 시간 연산
select second(now());
select date_add(now(), interval 10 second);

select minute(now());
select date_add(now(), interval 10 minute);

select hour(now());
select date_add(now(), interval 10 hour);

select day(now());
select date_add(now(), interval 10 day);

select month(now());
select date_add(now(), interval 10 month);

select year(now());
select date_add(now(), interval 10 year);

select hour(now());
select date_sub(now(), interval 10 hour);

select hour(now());
select date_add(now(), interval -10 hour);

-- 날짜 차이를 구하는 함수 : datediff / timestampdiff
-- 1. 앞에서 뒤를 뺌
select datediff(now(), '2025-3-18');
select datediff('2025-3-18', now());

select datediff(now(), lastDate);

-- 2. 뒤에서 앞을 뺌
select timestampdiff(minute, '2025-3-18 15:30:0', now());
select timestampdiff(day, '2025-3-18 15:30:0', now());

select mid 아이디,startDate 가입일 from member;

-- 가입한 날로부터 오늘은 몇일이 지났는지를 출력?

select mid 아이디,startDate 가입일, datediff(now(), startDate) as 지난날수 from member;
select mid 아이디,startDate 가입일, datediff(now(), startDate) as 지난날수 from member where userDel='OK';

select mid ,startDate , datediff(now(), startDate) as deleteDiff from member where userDel='OK';
select mid 아이디,startDate 가입일, timestampdiff(day, startDate, now()) as 지난날수 from member;

select * from board;
select date_format(wDate, '%y-%m-%d') from board; /* %y : 2자리 연도 */
select date_format(wDate, '%y/%m/%d') from board; /* %y : 2자리 연도 */
select date_format(wDate, '%y년%m월%d일') from board; /* %y : 2자리 연도 */
select date_format(wDate, '%Y-%m-%d') from board; /* %Y : 4자리 연도 */
select date_format(wDate, '%Y-%m-%d %w') from board; /* %w : 요일(숫자: 월-1)*/
select date_format(wDate, '%Y-%m-%d %W') from board; /* %w : 요일(영어로)*/
select date_format(wDate, '%Y-%M-%d') from board;	/* %M : 월이 영어로 */
select date_format(wDate, '%Y-%m-%d %p %h:%i') from board; /* %p : AM/PM, %h:12시간제 */
select date_format(wDate, '%Y-%m-%d %H:%i') from board; /* %H : 24시간제 */


/*리뷰테이블*/
create table review (
	idx int not null auto_increment, /*리뷰 고유번호*/
	part varchar(10) not null, 				/*분야(borad, pds,....)*/ 
	partIdx int not null,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	star		int not null default 0,
	content text,
	rDate		datetime default now(),
	primary key(idx),
	foreign key(mid) references member(mid)
);
/*리뷰에 댓글달기*/
create table reviewReply(
	replyIdx int not null auto_increment,			/* 댓글 고유번호 */
	reviewPart varchar(10) not null,					/*분야(board, pds, ....)*/
	reviewIdx int not null,										/* 원본글(부모글:리뷰)의 고유번호 */
	replyMid varchar(20) not null,
	replyNickName varchar(20) not null,
	replyRDate datetime default now(),  			/* 댓글 올린 날짜 */
	replyContent text not null,								/* 댓글 내용 */
	primary key(replyIdx),
	foreign key(reviewIdx) references review(idx),
  foreign key(replyMid) references member(mid)
);

