package com.example.boardinfo.model.game.dto.category;

public class CategoryDTO {
  private int cnum;
  private String gamecategory;
  
  
  public CategoryDTO() {}
  public CategoryDTO(int cnum, String gamecategory) {
    super();
    this.cnum = cnum;
    this.gamecategory = gamecategory;
  }
  @Override
  public String toString() {
    return "CategoryDTO [cnum=" + cnum + ", gamecategory=" + gamecategory + "]";
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
  
}
