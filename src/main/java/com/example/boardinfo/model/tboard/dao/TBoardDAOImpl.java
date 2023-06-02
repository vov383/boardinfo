package com.example.boardinfo.model.tboard.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;

@Repository
public class TBoardDAOImpl implements TBoardDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public int countArticle(
			Map<String, Object> map) {
		//여기서 에러
		return sqlSession.selectOne("tboard.countArticle", map);
	}

	@Override
	public List<TBoardDTO> list(Map<String, Object> map) {
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

	@Override
	public void fileAttach(TBAttachDTO f_dto) {
		sqlSession.insert("tboard.insertFile", f_dto);
	}

}
