--보드게임 목록 테이블
create table game (
gnum number not null primary key,     --보드게임 인덱스 기본키
exnum number,                                   --확장판게임의 경우 본게임과 연결하기위한 본게임의 gnum을 입력
renum varchar2(20),                                   --재구현게임의 경우 원게임과 연결하기위한 원게임의 gnum을 입력
bggnum number default 0,                    --보드게임긱 아이디값 아이디값을 모르면 0
gametitle varchar2(400) not null unique,  --게임 제목
gametitle_eng varchar2(400),                --게임 제목 영문
players varchar2(100) not null,              --적정인원
playtime varchar2(100) not null,            --플레이시간
ages varchar2(100) not null,                 --사용연령
language varchar2(100),                      --사용언어 
gamephoto_url varchar2(100),                    --게임사진파일경로(프론트에서 경로설정해서 썸네일로 쓸것)
release_year number,                            --게임 발매년도
bgg_game_score float,                           --bgg 게임 난이도
bggrank number,                                 --bgg랭킹
write_date date default sysdate,             --업로드 날짜
viewcount number default 0                 --조회수
);

--보드게임과 디자이너(제작자)를 연결하는 테이블
create table game_designer (
gnum number not null,                       --보드게임 테이블의 gnum의 외래키
dnum number not null                       --디자이너 테이블의 dnum의 외래키
);
--디자이너(제작자) 테이블
create table designer (
dnum number not null primary key,     --테이블의 인덱스 기본키
designer varchar2(100) not null           --디자이너
);
--보드게임과 카테고리를 연결하는 테이블
create table game_category (
gnum number not null,                       --보드게임 테이블의 gnum의 외래키
cnum number not null                        --카테고리 테이블의 cnum의 외래키
);
--카테고리 테이블
create table category (
cnum number not null primary key,    --테이블의 인덱스 기본키
gamecategory varchar2(100) not null    --카테고리
);
--보드게임과 제작사를 연결하는 테이블
create table game_publisher (
gnum number not null,                       --보드게임 테이블의 gnum의 외래키
pnum number not null                        --제작사 테이블의 pnum의 외래키
);
--제작사 테이블
create table publisher (
pnum number not null primary key,    --테이블의 인덱스 기본키
publisher varchar2(100) not null          --카테고리
);
--보드게임과 아티스트를 연결하는 테이블
create table game_artist (
gnum number not null,                       --보드게임 테이블의 gnum의 외래키
anum number not null                        --아티스트 테이블의 anum의 외래키
);
--제작사 테이블
create table artist (
anum number not null primary key,    --테이블의 인덱스 기본키
artist varchar2(100) not null          --카테고리
);
--보드게임과 메카닉를 연결하는 테이블
create table game_mechanic (
gnum number not null,                       --보드게임 테이블의 gnum의 외래키
mnum number not null                        --메카닉 테이블의 mnum의 외래키
);
--메카닉 테이블
create table mechanic (
mnum number not null primary key,    --테이블의 인덱스 기본키
mechanic varchar2(100) not null          --카테고리
);
-----------------------------------------------------
commit;
-------------------------------------------------------------

select * from game order by gnum;
select * from game_designer order by gnum;
select * from designer order by dnum desc;
select * from game_category order by gnum;
select * from category order by cnum desc;
select * from game_publisher;
select * from publisher order by pnum desc;
select * from game_artist;
select * from artist order by anum desc;
select * from game_artist;
select * from mechanic order by mnum desc;
select * from game_mechanic;
----------------------------------------

--보드게임 테이블 시퀀스 생성
create sequence seq_game
start with 200000
increment by 1;
--디자이너 테이블 시퀀스 생성
create sequence seq_designer
start with 200000
increment by 1;
--카테고리 테이블 시퀀스 생성
create sequence seq_category
start with 5000
increment by 1;
--제작사 테이블 시퀀스 생성
create sequence seq_publisher
start with 100000
increment by 1;
--아티스트 테이블 시퀀스 생성
create sequence seq_artist
start with 300000
increment by 1;
--메카닉 테이블 시퀀스 생성
create sequence seq_mechanic
start with 6000
increment by 1;

-----------------------------------------------
delete from game;
delete from game_designer;
delete from designer;
delete from game_category;
delete from category;
delete from game_publisher;
delete from publisher;
delete from game_artist;
delete from artist;
delete from game_mechanic;
delete from mechanic;
---------------------------------------
drop table game;
drop table game_designer;
drop table designer;
drop table game_category;
drop table category;
drop table game_publisher;
drop table publisher;
drop table game_artist;
drop table artist;
---------------------------------------
drop sequence seq_game;
drop sequence seq_designer;
drop sequence seq_category;
drop sequence seq_publisher;
drop sequence seq_artist;
drop sequence seq_mechanic;
---------------------------------------
commit;
------------------------------------------

