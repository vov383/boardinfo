package com.example.boardinfo.model.game.dao.designer;

import javax.inject.Inject;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class DesignerDAOImpl implements DesignerDAO {
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int check_designer(String designer) {
		int result = sqlSession.selectOne("designer.check", designer);
		return result;
	}
	
	@Override
	public void insert_designer(String designer, String userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("designer",designer);
		map.put("userid",userid);
		sqlSession.insert("designer.insert", map);
	}
	
	@Override
	public void insert_designer_mapping() {
		sqlSession.insert("designer.insertmapping");
	}
	
	@Override
	public int designernum(String designer) {
		return sqlSession.selectOne("designer.designer_num", designer);
	}
	
	@Override
	public void insert_designer_mapping(int dnum) {
		sqlSession.insert("designer.insertmapping_dnum",dnum);
	}

	public List<DesignerDTO> getAutoDesigner(String input){
		return sqlSession.selectList("designer.getAuto", input);
	}

	public List<DesignerDTO> view(int gnum) {
		return sqlSession.selectList("designer.view", gnum);
	}

	public int check_designer(String designer, int gnum){
		Map<String, Object> map = new HashMap<>();
		map.put("designer", designer);
		map.put("gnum",gnum);
		return sqlSession.selectOne("designer.updatecheck", map);
	}

	public void insert_designer_mapping(int gnum, int dnum){
		Map<String, Object> map = new HashMap<>();
		map.put("dnum", dnum);
		map.put("gnum",gnum);
		sqlSession.insert("designer.insertmapping_update", map);
	}
}
