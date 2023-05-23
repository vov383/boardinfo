package com.example.boardinfo.model.game.dao.designer;

import javax.inject.Inject;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

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
	public void insert_designer(String designer) {
		sqlSession.insert("designer.insert", designer);
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
		List<DesignerDTO> list = sqlSession.selectList("designer.getAuto", input);
		System.out.println(list);
		return list;
	}
}
