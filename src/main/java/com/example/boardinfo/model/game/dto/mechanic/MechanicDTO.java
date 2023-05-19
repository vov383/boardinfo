package com.example.boardinfo.model.game.dto.mechanic;

public class MechanicDTO {
  private int mnum;
  private String mechanic;
  
  
  public MechanicDTO() {}
  public MechanicDTO(int mnum, String mechanic) {
    super();
    this.mnum = mnum;
    this.mechanic = mechanic;
  }
  @Override
  public String toString() {
    return "MechanicDTO [mnum=" + mnum + ", mechanic=" + mechanic + "]";
  }
  public int getMnum() {
    return mnum;
  }
  public void setMnum(int mnum) {
    this.mnum = mnum;
  }
  public String getMechanic() {
    return mechanic;
  }
  public void setMechanic(String mechanic) {
    this.mechanic = mechanic;
  }
  
  
}
