show tables;

create table qna(
	idx int not null, /* qna의 고유번호 */
	qnaIdx int not null, /* 답변글의 고유번호 */
	mid varchar(20) not null, /* 원본글(문의글)의 작성자 아이디 */
	nickName varchar(20) not null, /* qna 작성자의 닉네임 */
	title varchar(100) not null, /* qna의 글 제목 */
	email varchar(50) not null, /* 이메일 */
	content text not null, /* qna의 글제목 */
	ansLevel int not null, /* 질문글이든 답변글이든 작성자의 등급번호를 저장한다. (리스트 출력시에 질문글을 먼저 출력하고, 답변글을 ansLevel 오름차순으로 출력시켜준다.) */
	openSw char(2) not null default 'OK', /* 공개글,비밀글 체크용도 (공개:OK, 비공개:NO) */
	qnaSw varchar(2) not null default 'q', /* question(q) 인지 answer(a)인지 표시처리 */
	wDate datetime default now(), /* 작성 날짜*/
	delCheck char(2) default 'NO', /* 답변글이 있는데 '질문글'을 삭제하고자할때 'OK'로 저장시켜준다.(나중에 '답변글'을 모두 지웠을때 '질문글'의 delCheck가 'OK'라면 원본글(질문글)도 삭제한다.) */
	primary key(idx),
	foreign key(mid) references member(mid)
);

select ifnull(max(idx), 0) from qna;

/* 질문들에 대한 관리자의 답변여부를 기억시켜주기 위한 테이블 작성 */
create table qnaAdmin(
	idx int not null auto_increment primary key, /* 답변여부 테이블의 고유번호 */
	qnaIdx int not null, /* 원본글중에서 질문글의 고유번호 */
	qnaAnswer char(4) default '답변대기', /* 질문글에 대한 답변여부(답변대기/답변완료) */
	foreign key(qnaIdx) references qna(idx) /* 원본 질문글의 qnaIdx를 외래키지정. 원본글 고유번호와 매치 */
);

/* 
	처리조건 : 
			1. qna 등록시 qnaIdx를 결정해야한다. qnaIdx는 질문글(q)일경우는 자신글(질문글)의 고유번호인 idx를 갖고, 답변글(a)일 경우는 원본글의 idx값을 갖는다.
			따라서 idx를 auto_increment로 설정하지않는다.
			2. openSw는 '공개여부'의 용도로 사용한다. 공개:OK, 비공개:NO
			3. qnaSw는 질문글은 'q'로, 답변글은 'a'로 등록한다.
			4. ansLevel은 질문글이든 답변글이든, 글쓴이의 등급번호 (세션레벨(sLevel))를 저장한다.
			5. mid, nickName은 member테이블의 값을 그대로 저장하고, email은 member테이블의 값을 보여주되, 새로 입력받을수있도록 처리한다.
			6. 답변글 등록시 qna테이블의 title필드는 원본글(질문글)의 title필드를 그대로 사용하되, 앞에 '(Re)'를 붙여서 저장한다.
				단, '관리자'가 달은 '답변글'은 '빨간색'으로 저장처리한다.
			7. 답변글 등록시, qnaAdmin테이블에 대한 추가 저장처리를 한다.
				7-1. qnaIdx는 원본글인 '질문글'의 고유번호를 저장
				7-2. qnaAnswer필드는 질문글에 대한 답변여부(답변대기/답변완료)로 저장(초기값은 '답변대기')
						qnaAnswer필드는 일반사용자가 '답변글'을 달면  '답변대기'그대로 유지되지만, 관리자가 '답변글'을 달게되면 '답변완료'로 변경해줘야한다.
			8. 답변글은 누구나 등록할 수 있도록 처리한다. 단, 관리자가 답변글을 달았을때는 '답변완료'로 처리되기에 더이상 답변글을 달수없게한다.
				('답변완료'시에는 '답변'버튼 안보이게처리)
			9. qna는 리스트 출력시 아래와 같은 조건을 따른다.(페이징처리 할 것)
				9-1. 첫번째 정렬키 : qna테이블의 qnaIdx 내림차순으로 출력
				9-2. 두번째 정렬키 : qna테이블의 qnaSw 내림차순으로 출력 
				9-3. 세번째 정렬키 : qna테이블의 ansLevel 오름차순으로 출력
			10. '답변글'이 있는 '질문글'의 삭제시는, title필드와 content필드에 '현재 삭제된 글입니다.'라고 저장시켜둔다.
				 나중에 답변글을 삭제할시에 삭제된 원본글(질문글)도 같이 삭제처리한다.

select *,(select qnaAnswer from qnaAdmin where qnaIdx=1) as qnaAnswer from qna q order by qnaIdx desc, qnaSw desc, ansLevel;
