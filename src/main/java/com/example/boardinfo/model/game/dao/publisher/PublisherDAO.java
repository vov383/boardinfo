package com.example.boardinfo.model.game.dao.publisher;

import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;

import java.util.List;

public interface PublisherDAO {

	public int check_publisher(String publisher);
	public void insert_publisher(String publisher);
	public void insert_publisher_mapping();
	public int publishernum(String publisher);
	public void insert_publisher_mapping(int pnum);
    public List<PublisherDTO> getAutoPublisher(String input);
}
