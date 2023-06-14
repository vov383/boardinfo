package com.example.boardinfo.model.game.dto;

import java.util.Arrays;
import java.util.Date;

public class GameDTO {

	private int gnum; //테이블 인덱스 pk
	private int bggnum; //보드게임긱의 id값
	private String gametitle; //게임명 nn
	private String gametitle_eng; //게임명 영문 
	private String players; //인원 nn 모르면 정보없음입력
	private String playtime; //플레이시간 nn 모르면 정보없음입력
	private String ages; //사용연령 nn 모르면 정보없음입력
	private String language; //언어 nn
	private int release_year; //게임발매년도
	private Date create_date; //업로드날짜 nn sysout기본
	private String create_user; //업로드한 유저명
	private Date update_date; //수정 날짜
	private String update_user; //수정한 유저명
	//private int viewcount; //조회수 매일 자정 viewcount_date 테이블에 저장후 초기화됨
	private int totalviewcount; //조회수
	//private String del; //삭제 글 표시여부
	
	//따로 테이블 만들어서 관리.
	//게임등록시 값이 여러개일 경우 ',' 를 기준으로 spilt 할 수있게 문자열로 받은 다음
	//서비스에서 각 테이블로 배열로 값을 보냄.
	private String designer; //디자이너
	private String gamecategory; //게임카테고리
	private String publisher; //제작사
	private String artist; //아트웍담당
	private String mechanic; //게임 메카니즘
	private String expansion; //확장판게임
	private String reimplement; //재구현게임의

	//사진테이블의 자료를 사용하는 용도의 배열
	private String[] files;
	//보드게임긱에서 썸네일 가져오는 용도
	private String bgg_thumbnail;
	//테이블에 없지만 값을 dto에만 존재
	private String gamephoto_url; //게임사진파일경로
	//보드인이 평가한 랭킹과 난이도의 평균값
	private Double rate;
	private Double weight;

	
	//getter setter tostring 생성자
	public GameDTO() {}

	public GameDTO(int gnum, int bggnum, String gametitle, String gametitle_eng, String players, String playtime, String ages, String language, int release_year, Date create_date, String create_user, Date update_date, String update_user, int totalviewcount, String designer, String gamecategory, String publisher, String artist, String mechanic, String expansion, String reimplement, String[] files, String bgg_thumbnail, String gamephoto_url, Double rate, Double weight) {
		this.gnum = gnum;
		this.bggnum = bggnum;
		this.gametitle = gametitle;
		this.gametitle_eng = gametitle_eng;
		this.players = players;
		this.playtime = playtime;
		this.ages = ages;
		this.language = language;
		this.release_year = release_year;
		this.create_date = create_date;
		this.create_user = create_user;
		this.update_date = update_date;
		this.update_user = update_user;
		this.totalviewcount = totalviewcount;
		this.designer = designer;
		this.gamecategory = gamecategory;
		this.publisher = publisher;
		this.artist = artist;
		this.mechanic = mechanic;
		this.expansion = expansion;
		this.reimplement = reimplement;
		this.files = files;
		this.bgg_thumbnail = bgg_thumbnail;
		this.gamephoto_url = gamephoto_url;
		this.rate = rate;
		this.weight = weight;
	}

	@Override
	public String toString() {
		return "GameDTO{" +
				"gnum=" + gnum +
				", bggnum=" + bggnum +
				", gametitle='" + gametitle + '\'' +
				", gametitle_eng='" + gametitle_eng + '\'' +
				", players='" + players + '\'' +
				", playtime='" + playtime + '\'' +
				", ages='" + ages + '\'' +
				", language='" + language + '\'' +
				", release_year=" + release_year +
				", create_date=" + create_date +
				", create_user='" + create_user + '\'' +
				", update_date=" + update_date +
				", update_user='" + update_user + '\'' +
				", totalviewcount=" + totalviewcount +
				", designer='" + designer + '\'' +
				", gamecategory='" + gamecategory + '\'' +
				", publisher='" + publisher + '\'' +
				", artist='" + artist + '\'' +
				", mechanic='" + mechanic + '\'' +
				", expansion='" + expansion + '\'' +
				", reimplement='" + reimplement + '\'' +
				", files=" + Arrays.toString(files) +
				", bgg_thumbnail='" + bgg_thumbnail + '\'' +
				", gamephoto_url='" + gamephoto_url + '\'' +
				", rate=" + rate +
				", weight=" + weight +
				'}';
	}

	public int getGnum() {
		return gnum;
	}

	public void setGnum(int gnum) {
		this.gnum = gnum;
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

	public int getRelease_year() {
		return release_year;
	}

	public void setRelease_year(int release_year) {
		this.release_year = release_year;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public Date getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public int getTotalviewcount() {
		return totalviewcount;
	}

	public void setTotalviewcount(int totalviewcount) {
		this.totalviewcount = totalviewcount;
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

	public String getExpansion() {
		return expansion;
	}

	public void setExpansion(String expansion) {
		this.expansion = expansion;
	}

	public String getReimplement() {
		return reimplement;
	}

	public void setReimplement(String reimplement) {
		this.reimplement = reimplement;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}

	public String getBgg_thumbnail() {
		return bgg_thumbnail;
	}

	public void setBgg_thumbnail(String bgg_thumbnail) {
		this.bgg_thumbnail = bgg_thumbnail;
	}

	public String getGamephoto_url() {
		return gamephoto_url;
	}

	public void setGamephoto_url(String gamephoto_url) {
		this.gamephoto_url = gamephoto_url;
	}

	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}
}
