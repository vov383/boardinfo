package com.example.boardinfo.model.game.dto.artist;

import java.util.Arrays;

public class ArtistDTO {
  private int anum;
  private String artist;
  private String[] artists;
  
  
  public ArtistDTO() {}

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

  public String[] getArtists() {
    return artists;
  }

  public void setArtists(String[] artists) {
    this.artists = artists;
  }

  @Override
  public String toString() {
    return "ArtistDTO{" +
            "anum=" + anum +
            ", artist='" + artist + '\'' +
            ", artists=" + Arrays.toString(artists) +
            '}';
  }


}
