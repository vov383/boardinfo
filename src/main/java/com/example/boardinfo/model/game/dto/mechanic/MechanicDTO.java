package com.example.boardinfo.model.game.dto.mechanic;

public class MechanicDTO {
  private int mnum;
  private String mechanic;
  private String userid;
  
  
  public MechanicDTO() {}

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

  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }

  @Override
  public String toString() {
    return "MechanicDTO{" +
            "mnum=" + mnum +
            ", mechanic='" + mechanic + '\'' +
            ", userid='" + userid + '\'' +
            '}';
  }

  public MechanicDTO(int mnum, String mechanic, String userid) {
    this.mnum = mnum;
    this.mechanic = mechanic;
    this.userid = userid;
  }
}
