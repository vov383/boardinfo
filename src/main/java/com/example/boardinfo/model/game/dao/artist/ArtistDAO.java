package com.example.boardinfo.model.game.dao.artist;

import java.util.List;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;

public interface ArtistDAO {

	public int check_artist(String artist);
	public void insert_artist(String artist);
	public void insert_artist_mapping();
	public int artistnum(String artist);
	public void insert_artist_mapping(int anum);
	public List<ArtistDTO> getAutoArtist(String input);
}
