package com.example.boardinfo.model.game.dao.artist;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;

public interface ArtistDAO {

	int check_artist(String artist);
	void insert_artist(String artist);
	void insert_artist_mapping();
	int artistnum(String artist);
	void insert_artist_mapping(int anum);
	List<ArtistDTO> getAutoArtist(String input);
    List<ArtistDTO> view(int gnum);
}
