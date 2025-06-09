show tables;

create table photogallery (
	idx int not null auto_increment, /* 고유번호 */
	mid varchar(20) not null,        /* 아이디 */
	nickName varchar(20) not null,   /* 작성자 */
	title varchar(100) not null,     /* 제목 */
	content text not null,           /* 글내용 */
	part varchar(20) not null,       /* 분류 (주변(관광)여행지) */
	good int not null default 0,     /* 게시글의 좋아요 수 */ 
	wDate datetime not null default now(),  /* 게시글 작성날짜 */
	readNum int not null default 0,       /* 조회수 */
	thumbnail varchar(50) not null,  /* 썸네일 */
	spotIdx int not null,
	primary key(idx),
	foreign key (mid) references member(mid),
	foreign key (spotIdx) references tourist_spot(idx)
);

drop table photogallery;
/* content에는 사진이 거의 무조건 들어감
   좋아요 중복 불가 
*/	