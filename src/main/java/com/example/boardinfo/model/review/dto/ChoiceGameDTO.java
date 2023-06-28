package com.example.boardinfo.model.review.dto;

public class ChoiceGameDTO {

	private String choiceRegNum;	// 선택된 게임 테이블 PK
	private String gnum;			// 게임 테이블 PK
	private String regNum;	 		// 리뷰 테이블 PK
	private String reviewRegNum;	// 리뷰 테이블 PK (선택된 게임 테이블의 컬럼)
	private String category;		// 리뷰 테이블의 카테고리
	private String gametitle;		// 한글 게임명
	private String gametitleEng;	// 영어 게임명
	private String PLAYERS;			// 플레이 인수
	private String PLAYTIME;		// 플레이 시간
	private String AGES;			// 연령 제한
	private String LANGUAGE;		// 한글 제공 여부
	private String RELEASE_YEAR;	// 출시 연도
	private String del;				// 삭제 여부 (기본값 : N)
	private String createUser;		// 등록자
	private String createDate;		// 등록 일자
	private String updateUser;		// 수정자
	private String updateDate;		// 수정 일자

	public String getChoiceRegNum() {
		return choiceRegNum;
	}

	public void setChoiceRegNum(String choiceRegNum) {
		this.choiceRegNum = choiceRegNum;
	}

	public String getGnum() {
		return gnum;
	}

	public void setGnum(String gnum) {
		this.gnum = gnum;
	}

	public String getRegNum() {
		return regNum;
	}

	public void setRegNum(String regNum) {
		this.regNum = regNum;
	}

	public String getReviewRegNum() {
		return reviewRegNum;
	}

	public void setReviewRegNum(String reviewRegNum) {
		this.reviewRegNum = reviewRegNum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getGametitle() {
		return gametitle;
	}

	public void setGametitle(String gametitle) {
		this.gametitle = gametitle;
	}

	public String getGametitleEng() {
		return gametitleEng;
	}

	public void setGametitleEng(String gametitleEng) {
		this.gametitleEng = gametitleEng;
	}

	public String getPLAYERS() {
		return PLAYERS;
	}

	public void setPLAYERS(String PLAYERS) {
		this.PLAYERS = PLAYERS;
	}

	public String getPLAYTIME() {
		return PLAYTIME;
	}

	public void setPLAYTIME(String PLAYTIME) {
		this.PLAYTIME = PLAYTIME;
	}

	public String getAGES() {
		return AGES;
	}

	public void setAGES(String AGES) {
		this.AGES = AGES;
	}

	public String getLANGUAGE() {
		return LANGUAGE;
	}

	public void setLANGUAGE(String LANGUAGE) {
		this.LANGUAGE = LANGUAGE;
	}

	public String getRELEASE_YEAR() {
		return RELEASE_YEAR;
	}

	public void setRELEASE_YEAR(String RELEASE_YEAR) {
		this.RELEASE_YEAR = RELEASE_YEAR;
	}

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}








