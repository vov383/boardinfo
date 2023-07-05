package com.example.boardinfo.service.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.member.dto.MemberDTO;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {

	List<MemberDTO> list();
	void insertMember(MemberDTO dto);
	void insertMember(MemberDTO dto, MultipartFile multipartFile);
	boolean loginCheck(MemberDTO dto, HttpSession session);
	boolean checkPw(String userid, String passwd);
	void updateMember(MemberDTO dto);
	void deleteMember(String userid , HttpSession session);
	MemberDTO viewMember(String userid);
	void logout(HttpSession session);
	boolean checkDuplicateId(String userid);
	boolean checkDuplicateNick(String nickname);
	boolean getDelValue(String userid);
    public String getNickname(String user_id);
	String get_searchId(String name, String hp);
	String get_PwCheck(String userid, String email);
	void pass_change(Map<String, Object> map, MemberDTO dto, HttpSession session);
	String getCurrentPassword(String userid);
    String getProfile(String userId);
}
