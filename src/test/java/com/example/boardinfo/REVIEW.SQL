-- 리뷰 테이블 SQL
CREATE TABLE REVIEW                                         -- 게임 및 모임 후기
(
    REG_NUM       NUMBER                       NOT NULL
        CONSTRAINT REVIEW_PK
            PRIMARY KEY,                                    -- 리뷰 테이블 PK
    CATEGORY      VARCHAR2(100)                NOT NULL,    -- GAME 리뷰 OR 모임 리뷰
    VIEWS         NUMBER       DEFAULT 0       NOT NULL,    -- 조회수
    GNUM          NUMBER,                                   -- 게임 테이블의 PK와 조인 예정
    GATHERING_ID  NUMBER,                                   -- 모임 테이블의 PK와 조인 예정
    TITLE         VARCHAR2(100)                NOT NULL,    -- 리뷰 제목
    FUN_SCORE     NUMBER(3, 1) DEFAULT 0,                   -- 재미 점수
    REVIEW_SCORE  NUMBER(3, 1) DEFAULT 0,                   -- 리뷰 점수
    GAME_SCORE    NUMBER(3, 1) DEFAULT 0,                   -- 게임 난이도
    REVIEW_DETAIL BLOB,                                     -- 리뷰 내용 (사진 포함)
    GOOD          VARCHAR2(10) DEFAULT 'N',                 -- 좋아요 여부 (기본값 : N)
    DEL           VARCHAR2(10) DEFAULT 'N'     NOT NULL,    -- 삭제 여부 (기본값 : N)
    CREATE_USER   VARCHAR2(100)                NOT NULL,    -- 작성자 → 회원 테이블의 PK와 조인 예정
    CREATE_DATE   DATE         DEFAULT SYSDATE NOT NULL,    -- 작성 일자
    UPDATE_USER   VARCHAR2(100),                            -- 수정자
    UPDATE_DATE   DATE                                      -- 수정 일자
);

COMMENT ON TABLE REVIEW IS '게임 및 모임 후기';
COMMENT ON COLUMN REVIEW.REG_NUM IS '리뷰 테이블 PK';
COMMENT ON COLUMN REVIEW.CATEGORY       IS 'GAME OR 모임';
COMMENT ON COLUMN REVIEW.VIEWS          IS '조회수';
COMMENT ON COLUMN REVIEW.GNUM           IS '게임 테이블의 PK';
COMMENT ON COLUMN REVIEW.GATHERING_ID   IS '모임 테이블의 PK';
COMMENT ON COLUMN REVIEW.TITLE          IS '리뷰 제목';
COMMENT ON COLUMN REVIEW.FUN_SCORE      IS '재미 점수';
COMMENT ON COLUMN REVIEW.REVIEW_SCORE   IS '리뷰 점수';
COMMENT ON COLUMN REVIEW.GAME_SCORE     IS '게임 난이도';
COMMENT ON COLUMN REVIEW.REVIEW_DETAIL  IS '리뷰 내용 (사진 포함)';
COMMENT ON COLUMN REVIEW.GOOD           IS '좋아요 여부';
COMMENT ON COLUMN REVIEW.DEL            IS '삭제 여부';
COMMENT ON COLUMN REVIEW.CREATE_USER    IS '작성자';
COMMENT ON COLUMN REVIEW.CREATE_DATE    IS '작성 일자';
COMMENT ON COLUMN REVIEW.UPDATE_USER    IS '수정자';
COMMENT ON COLUMN REVIEW.UPDATE_DATE    IS '수정 일자';

-- 유저 아이디, 유저 닉네임 → 회원 테이블에서 가져올 예정
-- 게임 아이디, 게임명 → 게임 테이블에서 가져올 예정

-- 댓글 테이블 SQL
CREATE TABLE REPLY_COMMENTS                                     -- 댓글 및 답글 테이블
(
    REPLY_REG_NUM     NUMBER       DEFAULT 0       NOT NULL
        CONSTRAINT REPLY_COMMENTS_PK
            PRIMARY KEY,                                        -- 댓글 테이블 PK
    REG_NUM           NUMBER NOT NULL,                          -- 리뷰 테이블 PK
    TOP_REPLY_REG_NUM NUMBER       DEFAULT 0,                   -- 상위 댓글 키
    COMMENT_DETAIL    VARCHAR2(4000),                           -- 댓글 내용
    DEL               VARCHAR2(10) DEFAULT 'N',                 -- 삭제 여부 (기본값 : N)
    CREATE_USER       VARCHAR2(100)                NOT NULL,    -- 작성자
    CREATE_DATE       DATE         DEFAULT SYSDATE NOT NULL,    -- 작성 일자
    UPDATE_USER       VARCHAR2(100),                            -- 수정자
    UPDATE_DATE       DATE                                      -- 수정 일자
);

COMMENT ON TABLE REPLY_COMMENTS                     IS '댓글 및 답글 테이블';
COMMENT ON COLUMN REPLY_COMMENTS.REPLY_REG_NUM      IS '댓글 테이블_PK';
-- 상위 댓글 키 : 키 작성시 댓글의 답글이 됨, 작성 시간으로 댓글과 답글의 정렬 예정
COMMENT ON COLUMN REPLY_COMMENTS.REG_NUM            IS '리뷰 테이블 PK';
COMMENT ON COLUMN REPLY_COMMENTS.TOP_REPLY_REG_NUM  IS '상위 댓글 키';
COMMENT ON COLUMN REPLY_COMMENTS.COMMENT_DETAIL     IS '댓글 내용';
COMMENT ON COLUMN REPLY_COMMENTS.DEL                IS '삭제 여부';
COMMENT ON COLUMN REPLY_COMMENTS.CREATE_USER        IS '작성자';
COMMENT ON COLUMN REPLY_COMMENTS.CREATE_DATE        IS '작성 일자';
COMMENT ON COLUMN REPLY_COMMENTS.UPDATE_USER        IS '수정자';
COMMENT ON COLUMN REPLY_COMMENTS.UPDATE_DATE        IS '수정 일자';

-- 선택된 게임 테이블 SQL
CREATE TABLE CHOICE_GAME                                        -- 선택된 게임 테이블
(
    CHOICE_REG_NUM     NUMBER       DEFAULT 0       NOT NULL
        CONSTRAINT CHOICE_REG_NUM_PK
            PRIMARY KEY,                                        -- 선택된 게임 테이블 PK
    GNUM              NUMBER NOT NULL,                          -- 게임 테이블 PK
    CHOICE_GAME       VARCHAR2(2000) NOT NULL,                  -- 선택된 게임
    DEL               VARCHAR2(10) DEFAULT 'N',                 -- 삭제 여부 (기본값 : N)
    CREATE_USER       VARCHAR2(100)                NOT NULL,    -- 작성자
    CREATE_DATE       DATE         DEFAULT SYSDATE NOT NULL,    -- 작성 일자
    UPDATE_USER       VARCHAR2(100),                            -- 수정자
    UPDATE_DATE       DATE                                      -- 수정 일자
);

COMMENT ON TABLE CHOICE_GAME IS '선택된 게임 테이블';
COMMENT ON COLUMN CHOICE_GAME.CHOICE_REG_NUM IS '선택된 게임 테이블의 PK';
COMMENT ON COLUMN CHOICE_GAME.GNUM           IS '게임 테이블 PK';
COMMENT ON COLUMN CHOICE_GAME.CHOICE_GAME    IS '선택된 게임';
COMMENT ON COLUMN CHOICE_GAME.DEL            IS '삭제 여부';
COMMENT ON COLUMN CHOICE_GAME.CREATE_USER    IS '작성자';
COMMENT ON COLUMN CHOICE_GAME.CREATE_DATE    IS '작성 일자';
COMMENT ON COLUMN CHOICE_GAME.UPDATE_USER    IS '수정자';
COMMENT ON COLUMN CHOICE_GAME.UPDATE_DATE    IS '수정 일자';









