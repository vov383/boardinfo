package com.example.boardinfo.model.game.dto;

import java.util.Date;

public class GameDTO {

	private int gnum; //테이블 인덱스 pk
	private int exnum; //확장판게임의 경우 본게임의 gnum을 입력
	private String renum; //재구현게임의 경우 본게임의 gnum을 입력(복수일 경우 존재해 문자열로 배열형태로 저장)
	private int bggnum; //보드게임긱의 id값
	private String gametitle; //게임명 nn
	private String gametitle_eng; //게임명 영문 
	private String players; //인원 nn 모르면 정보없음입력
	private String playtime; //플레이시간 nn 모르면 정보없음입력
	private String ages; //사용연령 nn 모르면 정보없음입력
	private String language; //언어 nn
	private String gamephoto_url; //게임사진파일경로 
	private int release_year; //게임발매년도 
	private float bgg_game_score; //보드게임긱 게임 난이도
	private int bggrank;  //보드게임긱 랭킹
	private Date write_date; //업로드날짜 nn sysout기본
	private int viewcount; //조회수 나중에 주간랭킹같은것 구현 고려
	
	//따로 테이블 만들어서 관리.
	private String designer; //디자이너 nn 모르면 정보없음입력
	private String gamecategory; //게임카테고리
	private String publisher; //제작사
	private String artist; //아트웍담당
	private String mechanic; //게임 메카니즘
	
	//테이블에 없을것들 일단 적어놨지만 나중에 dto가 아닌 map으로 값 넘길수도 있음.
	private double g_rate; //게임 평점
	private double l_rate; //게임 난이도
	private int g_rank; //게임순위
	
	
	//getter setter tostring 생성자
	public GameDTO() {}


	public GameDTO(int gnum, int exnum, String renum, int bggnum, String gametitle, String gametitle_eng,
			String players, String playtime, String ages, String language, String gamephoto_url, int release_year,
			float bgg_game_score, int bggrank, Date write_date, int viewcount, String designer, String gamecategory,
			String publisher, String artist, String mechanic, double g_rate, double l_rate, int g_rank) {
		super();
		this.gnum = gnum;
		this.exnum = exnum;
		this.renum = renum;
		this.bggnum = bggnum;
		this.gametitle = gametitle;
		this.gametitle_eng = gametitle_eng;
		this.players = players;
		this.playtime = playtime;
		this.ages = ages;
		this.language = language;
		this.gamephoto_url = gamephoto_url;
		this.release_year = release_year;
		this.bgg_game_score = bgg_game_score;
		this.bggrank = bggrank;
		this.write_date = write_date;
		this.viewcount = viewcount;
		this.designer = designer;
		this.gamecategory = gamecategory;
		this.publisher = publisher;
		this.artist = artist;
		this.mechanic = mechanic;
		this.g_rate = g_rate;
		this.l_rate = l_rate;
		this.g_rank = g_rank;
	}


	@Override
	public String toString() {
		return "GameDTO [gnum=" + gnum + ", exnum=" + exnum + ", renum=" + renum + ", bggnum=" + bggnum + ", gametitle="
				+ gametitle + ", gametitle_eng=" + gametitle_eng + ", players=" + players + ", playtime=" + playtime
				+ ", ages=" + ages + ", language=" + language + ", gamephoto_url=" + gamephoto_url + ", release_year="
				+ release_year + ", bgg_game_score=" + bgg_game_score + ", bggrank=" + bggrank + ", write_date="
				+ write_date + ", viewcount=" + viewcount + ", designer=" + designer + ", gamecategory=" + gamecategory
				+ ", publisher=" + publisher + ", artist=" + artist + ", mechanic=" + mechanic + ", g_rate=" + g_rate
				+ ", l_rate=" + l_rate + ", g_rank=" + g_rank + "]";
	}


	public int getGnum() {
		return gnum;
	}


	public void setGnum(int gnum) {
		this.gnum = gnum;
	}


	public int getExnum() {
		return exnum;
	}


	public void setExnum(int exnum) {
		this.exnum = exnum;
	}


	public String getRenum() {
		return renum;
	}


	public void setRenum(String renum) {
		this.renum = renum;
	}


	public int getBggnum() {
		return bggnum;
	}


	public void setBggnum(int bggnum) {
		this.bggnum = bggnum;
	}


	public String getGametitle() {
		return gametitle;
	}


	public void setGametitle(String gametitle) {
		this.gametitle = gametitle;
	}


	public String getGametitle_eng() {
		return gametitle_eng;
	}


	public void setGametitle_eng(String gametitle_eng) {
		this.gametitle_eng = gametitle_eng;
	}


	public String getPlayers() {
		return players;
	}


	public void setPlayers(String players) {
		this.players = players;
	}


	public String getPlaytime() {
		return playtime;
	}


	public void setPlaytime(String playtime) {
		this.playtime = playtime;
	}


	public String getAges() {
		return ages;
	}


	public void setAges(String ages) {
		this.ages = ages;
	}


	public String getLanguage() {
		return language;
	}


	public void setLanguage(String language) {
		this.language = language;
	}


	public String getGamephoto_url() {
		return gamephoto_url;
	}


	public void setGamephoto_url(String gamephoto_url) {
		this.gamephoto_url = gamephoto_url;
	}


	public int getRelease_year() {
		return release_year;
	}


	public void setRelease_year(int release_year) {
		this.release_year = release_year;
	}


	public float getBgg_game_score() {
		return bgg_game_score;
	}


	public void setBgg_game_score(float bgg_game_score) {
		this.bgg_game_score = bgg_game_score;
	}


	public int getBggrank() {
		return bggrank;
	}


	public void setBggrank(int bggrank) {
		this.bggrank = bggrank;
	}


	public Date getWrite_date() {
		return write_date;
	}


	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}


	public int getViewcount() {
		return viewcount;
	}


	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}


	public String getDesigner() {
		return designer;
	}


	public void setDesigner(String designer) {
		this.designer = designer;
	}


	public String getGamecategory() {
		return gamecategory;
	}


	public void setGamecategory(String gamecategory) {
		this.gamecategory = gamecategory;
	}


	public String getPublisher() {
		return publisher;
	}


	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}


	public String getArtist() {
		return artist;
	}


	public void setArtist(String artist) {
		this.artist = artist;
	}


	public String getMechanic() {
		return mechanic;
	}


	public void setMechanic(String mechanic) {
		this.mechanic = mechanic;
	}


	public double getG_rate() {
		return g_rate;
	}


	public void setG_rate(double g_rate) {
		this.g_rate = g_rate;
	}


	public double getL_rate() {
		return l_rate;
	}


	public void setL_rate(double l_rate) {
		this.l_rate = l_rate;
	}


	public int getG_rank() {
		return g_rank;
	}


	public void setG_rank(int g_rank) {
		this.g_rank = g_rank;
	}



}
