package com.example.boardinfo.model.game.dto.artist;

import java.util.Arrays;

public class ArtistDTO {
  private int anum;
  private String artist;
  private String userid;
  
  public ArtistDTO() {}

  public ArtistDTO(int anum, String artist, String userid) {
    this.anum = anum;
    this.artist = artist;
    this.userid = userid;
  }

  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }

  public int getAnum() {
    return anum;
  }

  public void setAnum(int anum) {
    this.anum = anum;
  }

  public String getArtist() {
    return artist;
  }

  public void setArtist(String artist) {
    this.artist = artist;
  }

  @Override
  public String toString() {
    return "ArtistDTO{" +
            "anum=" + anum +
            ", artist='" + artist + '\'' +
            ", userid='" + userid + '\'' +
            '}';
  }
}
