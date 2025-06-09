show databases;
show tables;

create table member (
	idx			int not null auto_increment,			/* 회원 고유번호 */
	mid			varchar(20) not null,					/* 아이디(중복불허/수정가능) */
	pwd			varchar(100) not null,					/* 비밀번호(BCryptPasswordEncoder) */
	nickName	varchar(20) not null,					/* 닉네임(중복불허/수정가능) */
	name		varchar(10) not null,					/* 성명(수정불가능) */
	gender		char(2)		not null default '남자',		/* 성별(수정불가능) */
	birthday	datetime default now(),					/* 생일 */
	tel			varchar(15),							/* 전화번호 */
	address		varchar(100),							/* 주소(다음 우편번호 API 사용) */
	email		varchar(50) not null,					/* 이메일(회원가입시 인증 또는 '아이디/비밀번호'분실시 사용 - 정규식 필수 체크 */
	userDel		char(2) default 'NO',					/* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */
	level		int default 2,							/* 회원등급(0:관리자, 1:사업자회원, 2:일반회원) */
	businessNo  varchar(20),							/* 사업자등록번호(수정불가능) */
	userInfor 	varchar(10) default '공개',				/* 정보 공개여부(공개/비공개) */
	primary key (idx),
	unique key (mid)
);

desc member;

select * from member;

drop table if exists member;