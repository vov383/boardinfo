--게시물
CREATE TABLE t_board (
                         tb_num        NUMBER NOT NULL PRIMARY KEY, --글번호
                         title         VARCHAR2(200) NOT NULL, --제목
                         price         NUMBER, --가격
                         description   CLOB NOT NULL, --상품설명
                         view_count    NUMBER DEFAULT 0, --조회수
                         re_count      NUMBER DEFAULT 0, --댓글 갯수
                         category      VARCHAR2(10) DEFAULT 's', --말머리 s(판매) b(구매) n(나눔) f(거래완료)
                         meeting_place VARCHAR2(200), --직거래 할거면 카카오맵 API로 위치 정보 표시

                         del           VARCHAR2(10) DEFAULT 'N' NOT NULL, -- , N, Y 삭제여부
                         create_user   VARCHAR2(100) NOT NULL,
                         create_date   DATE DEFAULT sysdate NOT NULL,
                         update_user   VARCHAR2(100),
                         update_date   DATE DEFAULT sysdate NOT NULL
);

--댓글테이블 버전2
CREATE TABLE tb_comments (
                             reply_reg_num        NUMBER NOT NULL PRIMARY KEY,
                             reply_parent_reg_num NUMBER, -- Comment level
                             tb_num               NUMBER NOT NULL, --fk
                             content              CLOB, --comment content
                             del                  VARCHAR2(10) DEFAULT 'N' NOT NULL, -- , N, Y Whether to delete
                             create_user          VARCHAR2(100) NOT NULL,
                             create_date          DATE DEFAULT sysdate NOT NULL,
                             update_user          VARCHAR2(100),
                             update_date          DATE DEFAULT sysdate NOT NULL
--    foreign key(tb_num) references t_board(tb_num),
--    foreign key(reply_parent_reg_num) references tb_comments(reply_reg_num) -- add foreign key to parent comment
);

--첨부파일
CREATE TABLE tb_files (
                          file_reg_num NUMBER NOT NULL PRIMARY KEY, --PK,
                          tb_num       NUMBER NOT NULL,
                          fullname     VARCHAR2(200) NOT NULL, --파일명
                          formatname   VARCHAR2(100), --파일 종류
                          filedata     BLOB, --데이터,
                          del          VARCHAR2(10) DEFAULT 'N' NOT NULL, -- , N, Y 삭제여부
                          create_user  VARCHAR2(100) NOT NULL,
                          create_date  DATE DEFAULT sysdate NOT NULL,
                          update_user  VARCHAR2(100),
                          update_date  DATE DEFAULT sysdate NOT NULL
--   foreign key(TB_NUM) references t_board(tb_num)
);

CREATE SEQUENCE seq_tboard START WITH 1 INCREMENT BY 1 NOMAXVALUE MINVALUE 1 CACHE 20 NOORDER NOCYCLE;

CREATE SEQUENCE seq_tb_comments START WITH 1 INCREMENT BY 1 NOMAXVALUE MINVALUE 1 CACHE 20 NOORDER NOCYCLE;

CREATE SEQUENCE seq_tb_files START WITH 1 INCREMENT BY 1 NOMAXVALUE MINVALUE 1 CACHE 20 NOORDER NOCYCLE;

INSERT INTO t_board (
    tb_num,
    create_user,
    title,
    price,
    description
) VALUES (
             seq_tboard.NEXTVAL,
             '홍길동',
             '판매 테스트',
             100000,
             '아무거나 팔아요'
         );

COMMIT;


