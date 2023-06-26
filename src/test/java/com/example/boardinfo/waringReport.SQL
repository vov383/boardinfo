
/*신고하기 테이블*/
create table WARNING_REPORT
(
    WARNING_NO       VARCHAR2(100) not null
        constraint WARNING_REPORT_PK
            primary key,
    TABLE_WRITING_PK VARCHAR2(100),
    WARING           VARCHAR2(50) default 'N',
    DEL              VARCHAR2(50) default 'N',
    CREATE_USER      VARCHAR2(100),
    CREATE_DATE      DATE         default SYSDATE,
    UPDATE_USER      VARCHAR2(100),
    UPDATE_DATE      DATE
)
/

comment on table WARNING_REPORT is '신고 테이블'
/

comment on column WARNING_REPORT.WARNING_NO is '신고 테이블의 PK'
/

comment on column WARNING_REPORT.TABLE_WRITING_PK is '각 테이블의 글 PK, 댓글 포함'
/

comment on column WARNING_REPORT.WARING is '신고여부, 기본값 : N'
/

comment on column WARNING_REPORT.DEL is '삭제여부, 기본값 : N'
/

comment on column WARNING_REPORT.CREATE_USER is '작성자'
/

comment on column WARNING_REPORT.CREATE_DATE is '작성일자'
/

comment on column WARNING_REPORT.UPDATE_USER is '수정자'
/

comment on column WARNING_REPORT.UPDATE_DATE is '수정일자'
/