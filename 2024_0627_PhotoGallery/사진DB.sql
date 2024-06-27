

-- 일련번호 관리객체 시퀀스 생성

create sequence seq_photo_idx

-- 테이블 생성

create table photo
(
	p_idx		int,					-- 일련번호
	p_title		varchar2(200) not null,	-- 제목
	p_content	varchar2(2000)not null,	-- 내용
	p_filename	varchar2(200) not null, -- 파일명
	p_ip		varchar2(100) not null, -- 아이피
	p_regdate	varchar2(100),			-- 등록일자
	mem_idx		int,					-- 작성자
	mem_name	varchar2(100) not null	-- 회원명
)

-- 기본키 설정

alter table photo
	add constraint pk_photo_idx primary key(p_idx);
	
-- 외래키

alter table photo
	add constraint fk_photo_mem_idx foreign key(mem_idx)
									references member(mem_idx)
									on delete cascade -- 부모삭제시->자식게시물도 삭제
-- 내가 참조할 키는 멤버 테이블에 있는 mem_idx를 가져올 것 입니다.
-- 부모키는 어디서 내가 참조되고 있으면, 사용중인 부모키는 삭제가 안된다
-- ex) a 회원의 올렸던 게시글의 데이터가 mem_idx를 참조하고 있으면 a 회원의 데이터가 삭제가 안된다.
-- a회원이 올렸던 게시글도 삭제하고 싶으면 제약조건을 달아야한다.