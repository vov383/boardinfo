package com.example.boardinfo.model.tboard.dto;

public class TBoardDTO {

	private String tb_num;/*pk 게시물번호*/
	private String category;/*판매, 구매, 나눔, 완료*/
	private String title;/*제목*/
	private String price;/*가격*/
	private String description;/*본문*/
	private int view_count;/*조회수*/
	private int re_count;/*댓글 수*/
	private String del;/*삭제여부 'N' or 'Y'*/
	private String create_user;/*작성자*/
	private String nickname; /*작성자 닉네임.. member에서 join하려고*/
	private String create_date;/*작성일자*/
	private String update_user;
	private String update_date;

	/*거래장소
	* 시, 도
	* 시, 군, 구
	* 상세주소
	* 장소명
	* 좌표값 위도
	* 경도
	* */
	private String address1;
	private String address2;
	private String address3;
	private String place_name;
	private String lat;
	private String lng;

	private int good_count;/*좋아요 수*/
	private String[] files;
	private String tb_thumbnail;/*리스트에서 썸네일로 쓰려고 db에 미포함*/
	private String gnum;
	private String profile;

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getGnum() {
		return gnum;
	}

	public void setGnum(String gnum) {
		this.gnum = gnum;
	}
	//getter, setter

	public String getTb_num() {
		return tb_num;
	}

	public void setTb_num(String tb_num) {
		this.tb_num = tb_num;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getRe_count() {
		return re_count;
	}

	public void setRe_count(int re_count) {
		this.re_count = re_count;
	}

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getAddress3() {
		return address3;
	}

	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public int getGood_count() {
		return good_count;
	}

	public void setGood_count(int good_count) {
		this.good_count = good_count;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}

	public String getTb_thumbnail() {
		return tb_thumbnail;
	}

	public void setTb_thumbnail(String tb_thumbnail) {
		this.tb_thumbnail = tb_thumbnail;
	}


}
