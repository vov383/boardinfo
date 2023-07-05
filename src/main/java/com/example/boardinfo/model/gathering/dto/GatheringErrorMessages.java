package com.example.boardinfo.model.gathering.dto;

public final class GatheringErrorMessages {
    public static final String ERROR_DURING_PROCESS = "요청하신 작업 처리 도중 에러가 발생했습니다.";
    public static final String UNAUTHORIZED = "권한이 없습니다.";
    public static final String FULL = "이미 모임 정원이 꽉 찼습니다.";
    public static final String FINISHED = "이 모임은 종료되었습니다.";
    public static final String DELETED = "이 모임은 삭제되었습니다.";
    public static final String ALREADY_ATTENDING = "이미 모임에 참여중입니다.";
    public static final String WAITING = "모임장의 승인을 기다리는 중입니다.";
    public static final String WRITER_CANNOT_LEAVE = "게시글 작성자는 모임 글을 삭제하기 전에는 모임에서 탈퇴할 수 없습니다.";
    public static final String WRITER_CANNOT_BE_THROWN = "글쓴이 자기 자신은 강퇴할 수 없습니다.";
    public static final String NOT_ATTENDING = "요청하신 작업 처리 중 에러가 발생하였습니다.\n이 모임의 참가자가 맞는지 다시 확인해주세요.";
    public static final String CANNOT_EDIT_FINISHED_GATHERING = "모임 기간이 지난 글은 수정할 수 없습니다.";

}
