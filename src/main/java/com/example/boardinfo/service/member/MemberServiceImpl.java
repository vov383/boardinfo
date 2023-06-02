package com.example.boardinfo.service.member;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.model.member.dto.MemberDTO;

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
			memberDao.updateMember(dto);
	}

	@Override
	public void deleteMember(String userid , HttpSession session) {
			memberDao.deleteMember(userid);
			session.invalidate();
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

	@Override
	public boolean getDelValue(String userid) {
	    MemberDTO delMember = memberDao.getDelValue(userid);
	    if (delMember != null && "y".equals(delMember.getDel())) {
	        return true; // 탈퇴한 회원인 경우
	    }
	    return false; // 탈퇴하지 않은 회원인 경우
	}

}
