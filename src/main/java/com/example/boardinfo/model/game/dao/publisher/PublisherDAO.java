package com.example.boardinfo.model.game.dao.publisher;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;

import java.util.List;
import java.util.Map;

public interface PublisherDAO {

	int check_publisher(String publisher);
	int check_publisher(String publisher, int gnum);
	void insert_publisher(String publisher, String userid);
	void insert_publisher_mapping();
	void insert_publisher_mapping(int pnum);
    List<PublisherDTO> getAutoPublisher(String input);
    List<PublisherDTO> view(int gnum);
	void insert_publisher_mapping(int gnum, int pnum);
    List<String> viewPublisher(int gnum);
    void deleteGame_Publisher(String value, int gnum);
    List<PublisherDTO> totalSearch(Map<String, Object> map);
    int totalSearchCount(Map<String, Object> map);

    List<PublisherDTO> confirmList(Map<String, Object> map);

    void deleteitem(int num);
}
