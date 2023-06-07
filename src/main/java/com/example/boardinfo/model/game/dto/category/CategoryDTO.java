package com.example.boardinfo.model.game.dto.category;

public class CategoryDTO {
  private int cnum;
  private String gamecategory;
  private String userid;
  
  
  public CategoryDTO() {}

  public CategoryDTO(int cnum, String gamecategory, String userid) {
    this.cnum = cnum;
    this.gamecategory = gamecategory;
    this.userid = userid;
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

  @Override
  public String toString() {
    return "CategoryDTO{" +
            "cnum=" + cnum +
            ", gamecategory='" + gamecategory + '\'' +
            ", userid='" + userid + '\'' +
            '}';
  }
}
