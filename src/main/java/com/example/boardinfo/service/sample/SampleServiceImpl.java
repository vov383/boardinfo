package com.example.boardinfo.service.sample;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.sample.dao.SampleDAO;

@Service
public class SampleServiceImpl implements SampleService {

	@Inject
	SampleDAO sampleDao;
	
	@Override
	public String sample(String test_message) {
		return sampleDao.sample(test_message);
	}
}
