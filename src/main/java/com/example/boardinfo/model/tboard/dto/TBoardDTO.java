package com.example.boardinfo.model.tboard.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class TBoardDTO {

	private int tb_num;/*pk 게시물번호*/
	private String category;/*판매, 구매, 나눔, 완료*/
	private String title;/*제목*/
	private int price;/*가격*/
	private String description;/*본문*/
	private int view_count;/*조회수*/
	private int re_count;/*댓글 수*/
	private String del;/*삭제여부 'N' or 'Y'*/
	private String create_user;/*작성자*/
	private String nickname;
	private Date create_date;/*작성일자*/
	private String update_user;
	private Date update_date;

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
	private double lat;
	private double lng;

	private int interestCount;/*좋아요 수*/
	private MultipartFile[] files;
	//getter, setter
	public int getTb_num() {
		return tb_num;
	}
	public void setTb_num(int tb_num) {
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
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

	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getUpdate_user() {
		return update_user;
	}
	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
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

	public int getInterestCount() {
		return interestCount;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public void setInterestCount(int interestCount) {
		this.interestCount = interestCount;
	}

	public MultipartFile[] getFiles() {
		return files;
	}

	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "TBoardDTO{" +
				"tb_num=" + tb_num +
				", category='" + category + '\'' +
				", title='" + title + '\'' +
				", price=" + price +
				", description='" + description + '\'' +
				", view_count=" + view_count +
				", re_count=" + re_count +
				", del='" + del + '\'' +
				", create_user='" + create_user + '\'' +
				", nickname='" + nickname + '\'' +
				", create_date=" + create_date +
				", update_user='" + update_user + '\'' +
				", update_date=" + update_date +
				", address1='" + address1 + '\'' +
				", address2='" + address2 + '\'' +
				", address3='" + address3 + '\'' +
				", place_name='" + place_name + '\'' +
				", lat=" + lat +
				", lng=" + lng +
				", interestCount=" + interestCount +
				", files=" + Arrays.toString(files) +
				'}';
	}

}
