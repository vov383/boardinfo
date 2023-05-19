package com.example.boardinfo.model.review.dto;

public class ChoiceGameDTO {

	private String choiceRegNum;	// 선택된 게임 테이블 PK
	private String gnum;			// 게임 테이블 PK
	private String choiceGame;		// 선택된 게임
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

	public String getChoiceGame() {
		return choiceGame;
	}

	public void setChoiceGame(String choiceGame) {
		this.choiceGame = choiceGame;
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








