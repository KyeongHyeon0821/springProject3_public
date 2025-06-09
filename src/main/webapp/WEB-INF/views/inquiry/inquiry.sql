show tables;

/* 1:1 문의 */
create table inquiry (
		idx int not null auto_increment,              /* 고유번호 */
		mid varchar(20) not null,                      /* 아이디 */
		title varchar(100) not null,                   /* 1:1문의 제목 */
		part varchar(20) not null,                    /* 분류 (카테고리) */
		wDate datetime not null default now(), /* 문의 작성 날짜*/
		reservation varchar(50),                      /* 예약 번호 */
		content text not null,                           /* 문의 내역 */
		fSName varchar(200),                          /* 문의시에 올린 서버에 저장되는 이름*/
		reply varchar(10) default '답변대기중',      /* 답변 여부(답변대기중/답변완료/답변보류) */
		primary key (idx),
		foreign key (mid) references member(mid) 
);

insert into inquiry values (default, 'admin', '문의합니다', '결제/환불문의', default, '', '결제가 안된거같습니다.', '', default);
select count(*) from inquiry;
select * from inquiry;

desc inquiry;

/* 1:1 문의 답변글 */
create table inquiryReply(
		reIdx int not null auto_increment,            /* 답변 고유번호*/
		inquiryIdx int not null,                            /* 문의글 고유번호*/
		reWDate datetime not null default now(), /* 답변 작성 날짜*/
		reContent text not null,                          /* 답변 내용 */
		primary key (reIdx),
		foreign key (inquiryIdx) references inquiry (idx)
);

desc inquiryReply;
select *,(select reIdx from inquiryReply where inquiryIdx=a.idx) as reIdx,(select reContent from inquiryReply where inquiryIdx=a.idx) as reContent  from inquiry a where idx = 2;
