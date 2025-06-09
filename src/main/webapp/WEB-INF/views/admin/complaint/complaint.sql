show tables;

/* 신고테이블(complaint) */
create table complaint(
  idx  int not null auto_increment,	/* 신고테이블 고유번호 */
  part varchar(15) not null,				/* 신고분류(게시판:board, 자료실:pds, 방명록:guest) */
  boardIdx int default 1,						/* 신고분류항목(게시판:board) 글의 고유번호 */
  pdsIdx int default 1,							/* 신고분류항목(자료실:pds) 글의 고유번호 */
  cpMid varchar(20) not null,				/* 신고자 아이디 */
  cpContent text not null,					/* 신고 사유 */
  cpDate datetime default now(),		/* 신고한 날짜 */
  primary key(idx),
  foreign key(cpMid) references member(mid),
  foreign key(boardIdx) references board(idx) on delete cascade,
  foreign key(pdsIdx) references pds(idx) on delete cascade
);
drop table complaint;
desc complaint;

insert into complaint values (default, 'board', 49, default, 'kms1234', '불법정보',default);
update board set complaint = 'OK' where idx = 49;

select * from board order by idx desc;

select * from complaint order by idx desc;

select * from complaint c, board b, pds p where c.boardIdx=b.idx and c.pdsIdx=p.idx order by c.idx desc;

select c.*,date_format(cpDate,'%Y-%m-%d %H:%i') as cpDate from complaint c, board b, pds p where c.boardIdx=b.idx and c.pdsIdx=p.idx order by c.idx desc;


-- 앞의 설계 무시하고 다시 complaint 설계합니다.
/* 신고테이블(complaint) */
create table complaint(
  idx  int not null auto_increment,			/* 신고테이블 고유번호 */
  part varchar(15) not null,						/* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
  partIdx int not null,									/* 신고분류항목 글의 고유번호 */
  cpMid varchar(20) not null,						/* 신고자 아이디 */
  cpContent text not null,							/* 신고 사유 */
  cpDate datetime default now(),				/* 신고한 날짜 */
  progress varchar(10) default '신고접수',/* 진행상황 : '신고접수/처리완료(S)/처리완료(H)/처리완료(D)' S:문제없음(보이기), H:가리기, D:삭제하기 */
  primary key(idx),
  foreign key(cpMid) references member(mid)
);
desc complaint;

/*
 * 신고처리 테이블 : boardIdx필드와 pdsIdx필드 삭제후, partIdx필드(해당 part의 고유번호)추가, progress필드 추가
	// 신고 처리하기
	// complaintSw : H(감추기-board테이블의 complaint필드값을 'HI' , complaint테이블의 progress필드값을 '처리완료(H)')
	// complaintSw : S(보이기-신고해제-board테이블의 complaint필드값을 'NO' , complaint테이블의 progress필드값을 '처리완료(S)')
	// complaintSw : D(삭제하기-board테이블의 해당레코드 삭제처리 , complaint테이블의 progress필드값을 '처리완료(D)')
*/
