package com.example.boardinfo.service.member;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.model.member.dto.MemberDTO;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;
	
	@Override
	public List<MemberDTO> list() {
		return memberDao.list();
	}

	@Override
	public void insertMember(MemberDTO dto) {
		memberDao.insertMember(dto);
		
	}

	public void insertMember(MemberDTO dto, MultipartFile multipartFile){

	}

	@Override
	public boolean loginCheck(MemberDTO dto, HttpSession session) {
		boolean result=memberDao.loginCheck(dto);
		if(result) {//로그인 성공
			//세션변수에 값 저장
			MemberDTO dto2=viewMember(dto.getUserid());
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", dto2.getName());
			System.out.println(session.getAttribute("userid"));
			System.out.println(session.getAttribute("name"));
		}
		return result;
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		return memberDao.checkPw(userid, passwd);
	}

	@Override
	public void updateMember(MemberDTO dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMember(String userid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDTO viewMember(String userid) {
		return memberDao.viewMember(userid);
	}

	@Override
	public void logout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
		
	}
	
	//중복확인
	@Override
	public boolean checkDuplicateId(String userid) {
		MemberDTO existingMember = memberDao.selectMemberById(userid);
	    return existingMember != null;
	}

	@Override
	public boolean checkDuplicateNick(String nickname) {
		MemberDTO existingMember = memberDao.selectMemberByNick(nickname);
	    return existingMember != null;
	}

}
