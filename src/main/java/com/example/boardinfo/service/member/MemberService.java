package com.example.boardinfo.service.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.member.dto.MemberDTO;

public interface MemberService {

	public List<MemberDTO> list();
	public void insertMember(MemberDTO dto);
	public boolean loginCheck(MemberDTO dto, HttpSession session);
	public boolean checkPw(String userid, String passwd);
	public void updateMember(MemberDTO dto);
	public void deleteMember(String userid);
	public MemberDTO viewMember(String userid);
	public void logout(HttpSession session);
	public boolean checkDuplicateId(String userid);
	
}
