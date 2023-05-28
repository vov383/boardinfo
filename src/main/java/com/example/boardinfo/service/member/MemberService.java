package com.example.boardinfo.service.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.member.dto.MemberDTO;

public interface MemberService {

	List<MemberDTO> list();
	void insertMember(MemberDTO dto);
	boolean loginCheck(MemberDTO dto, HttpSession session);
	boolean checkPw(String userid, String passwd);
	void updateMember(MemberDTO dto);
	void deleteMember(String userid);
	MemberDTO viewMember(String userid);
	void logout(HttpSession session);
	boolean checkDuplicateId(String userid);
	boolean checkDuplicateNick(String nickname);
	
}
