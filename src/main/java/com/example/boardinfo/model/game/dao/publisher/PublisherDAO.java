package com.example.boardinfo.model.game.dao.publisher;

import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;

import java.util.List;
import java.util.Map;

public interface PublisherDAO {

	int check_publisher(String publisher);
	int check_publisher(String publisher, int gnum);
	void insert_publisher(String publisher, String userid);
	void insert_publisher_mapping();
	int publishernum(String publisher);
	void insert_publisher_mapping(int pnum);
    List<PublisherDTO> getAutoPublisher(String input);
    List<PublisherDTO> view(int gnum);
	void insert_publisher_mapping(int gnum, int pnum);
}
