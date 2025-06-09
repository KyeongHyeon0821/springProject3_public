create table board (
  idx int not null auto_increment primary key,		/* 게시글 고유 번호 */
  mid varchar(50) not null,							/* 작성자 ID */
  title varchar(200) not null,						/* 게시글 제목 */
  content text not null,							/* 게시글 내용 */
  readCount int default 0,							/* 조회수 */
  createdAt datetime default now()					/* 작성일 */
);

create table boardReply (
  idx int primary key auto_increment,		/* 댓글 고유 번호 */
  boardIdx int,								/* 연결된 게시글 번호 */
  mid  varchar(20),							/* 작성자 ID */
  nickName  varchar(20),					/* 작성자 닉네임 */
  content text,								/* 댓글 내용 */
  createdAt datetime default now()			/* 작성일 */
 );