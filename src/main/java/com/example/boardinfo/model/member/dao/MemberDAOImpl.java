package com.example.boardinfo.model.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.member.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<MemberDTO> list() {
		return sqlSession.selectList("member.memberList");
	}

	@Override
	public void insertMember(MemberDTO dto) {
		 sqlSession.insert("member.insertMember",dto);
	}

	@Override
	public boolean loginCheck(MemberDTO dto) {
		String name=sqlSession.selectOne("member.login_check",dto);
		// 조건식 ? true일 때의 값 : false일 때의 값
		return name != null;
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		boolean result=false;
		
		Map<String,String> map=new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		int count=sqlSession.selectOne("member.checkPw", map);
		//비번이 맞으면(1), 틀리면(0) 리턴
		if(count==1) {
			result=true;
		}
		return result;
	}

	@Override
	public void updateMember(MemberDTO dto) {
		sqlSession.selectOne("member.updateMember",dto);
	}

	@Override
	public void deleteMember(String userid) {
		sqlSession.update("member.deleteMember",userid);
	}

	@Override
	public MemberDTO viewMember(String userid) {
		return sqlSession.selectOne("member.viewMember", userid);
	}

	@Override
	public MemberDTO selectMemberById(String userid) {
		return sqlSession.selectOne("member.selectMemberById",userid);
	}

	@Override
	public MemberDTO selectMemberByNick(String nickname) {
		return sqlSession.selectOne("member.selectMemberByNick", nickname);
	}

	@Override
	public MemberDTO getDelValue(String userid) {
		return sqlSession.selectOne("member.getDelValue",userid);
	}


	
	

}
