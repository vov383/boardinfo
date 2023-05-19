package com.example.boardinfo.model.tboard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;

@Repository
public class TBoardDAOImpl implements TBoardDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<TBoardDTO> list(String select_category, 
			String search_option, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("tboard.selectBoardList", map);
	}

	@Override
	public void insert(TBoardDTO dto) {
		sqlSession.insert("tboard.insertBoard", dto);
	}

	@Override
	public TBoardDTO viewPost(int tb_num) {
		return sqlSession.selectOne("tboard.viewPost", tb_num);
	}

	@Override
	public void update(TBoardDTO dto) {
		sqlSession.update("tboard.updatePost", dto);
	}

	@Override
	public void delete(int tb_num) {
		sqlSession.delete("tboard.deletePost", tb_num);
	}
	
	@Override
	public int countArticle(
			String select_category, 
			String search_option, String keyword) {
		Map<String, String> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		return sqlSession.selectOne("tboard.countArticle", map);
	}

	@Override
	public void increaseViewcnt(int tb_num) {
		sqlSession.update("tboard.increaseViewcnt", tb_num);
	}

	@Override
	public void increaseRecnt(int tb_num) {
		sqlSession.update("tboard.increaseRecnt", tb_num);
	}

	@Override
	public List<String> getAttach(int tb_num) {
		return sqlSession.selectList("tboard.getAttachList", tb_num);
	}

	@Override
	public void deleteFile(String fileName) {
		sqlSession.delete("tboard.deleteAttach", fileName);
	}


}
