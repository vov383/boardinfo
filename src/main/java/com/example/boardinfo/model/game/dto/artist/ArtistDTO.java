package com.example.boardinfo.model.game.dto.artist;

public class ArtistDTO {
  private int anum;
  private String artist;
  
  
  public ArtistDTO() {}
  public ArtistDTO(int anum, String artist) {
    super();
    this.anum = anum;
    this.artist = artist;
  }
  @Override
  public String toString() {
    return "ArtistDTO [anum=" + anum + ", artist=" + artist + "]";
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
  
  
}
