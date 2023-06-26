package com.example.boardinfo.model.game.dto.category;

public class CategoryDTO {
  private int cnum;
  private String gamecategory;
  private String userid;
  private int count;

  @Override
  public String toString() {
    return "CategoryDTO{" +
            "cnum=" + cnum +
            ", gamecategory='" + gamecategory + '\'' +
            ", userid='" + userid + '\'' +
            ", count=" + count +
            '}';
  }

  public int getCnum() {
    return cnum;
  }

  public void setCnum(int cnum) {
    this.cnum = cnum;
  }

  public String getGamecategory() {
    return gamecategory;
  }

  public void setGamecategory(String gamecategory) {
    this.gamecategory = gamecategory;
  }

  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }

  public int getCount() {
    return count;
  }

  public void setCount(int count) {
    this.count = count;
  }

  public CategoryDTO(int cnum, String gamecategory, String userid, int count) {
    this.cnum = cnum;
    this.gamecategory = gamecategory;
    this.userid = userid;
    this.count = count;
  }

  public CategoryDTO() {}

}
