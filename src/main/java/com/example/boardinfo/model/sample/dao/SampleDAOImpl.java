package com.example.boardinfo.model.sample.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class SampleDAOImpl implements SampleDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public String sample(String test_message) {
		
		//return sqlSession.selectOne("sample.sampleTest", test_message);
		return "샘플입니다.";
		
	}
}
