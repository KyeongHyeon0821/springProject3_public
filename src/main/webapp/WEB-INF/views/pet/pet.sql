create table pet (
	petIdx int not null auto_increment,			/* 강아지 고유번호 */
	memberMid varchar(20) not null,				/* 회원 ID(member 테이블과 연결) */
	petName varchar(10) not null,				/* 강아지 이름 */
	breed varchar(10),							/* 견종 */
	petGender char(2),							/* 강아지 성별 */
	petAge varchar(5),							/* 강아지 나이 */
	weight varchar(5),							/* 몸무게 */
	photo varchar(255),							/* 기본 이미지 선택 */
	memo text,									/* 메모(성격, 특이사항 등) */
	primary key (petIdx),
	foreign key (memberMid) references member(mid) on delete cascade
);

show tables;
DROP TABLE IF EXISTS pet;