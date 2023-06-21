package com.example.boardinfo.model.game.dao.artist;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;

public interface ArtistDAO {

	int check_artist(String artist);
	int check_artist(String artist, int gnum);
	void insert_artist(String artist, String userid);
	void insert_artist_mapping();
	void insert_artist_mapping(int anum);
	List<ArtistDTO> getAutoArtist(String input);
    List<ArtistDTO> view(int gnum);
	void insert_artist_mapping(int gnum,int anum);
    List<String> viewArtist(int gnum);

    void deleteGame_Artist(String value, int gnum);
}
