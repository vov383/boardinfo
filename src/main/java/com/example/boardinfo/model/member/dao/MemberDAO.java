package com.example.boardinfo.model.member.dao;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.member.dto.MemberDTO;

public interface MemberDAO {
	List<MemberDTO> list();
	void insertMember(MemberDTO dto);
	boolean loginCheck(MemberDTO dto);
	boolean checkPw(String userid, String passwd);
	void updateMember(MemberDTO dto);
	void deleteMember(String userid);
	MemberDTO viewMember(String userid);
	MemberDTO selectMemberById(String userid);
	MemberDTO selectMemberByNick(String nickname);
	MemberDTO getDelValue(String userid);
    public String getNickname(String userId);
	String get_searchId(String name, String hp);
	String get_PwCheck(String userid, String email);
	void pass_change(Map<String, Object> map, MemberDTO dto);
}
