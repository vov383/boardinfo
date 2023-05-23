package com.example.boardinfo.model.member.dao;

import java.util.List;

import com.example.boardinfo.model.member.dto.MemberDTO;

public interface MemberDAO {
	public List<MemberDTO> list();
	public void insertMember(MemberDTO dto);
	public boolean loginCheck(MemberDTO dto);
	public boolean checkPw(String userid, String passwd);
	public void updateMember(MemberDTO dto);
	public void deleteMember(String userid);
	public MemberDTO viewMember(String userid);
	public int mbidCheck(String userid);
	
}
