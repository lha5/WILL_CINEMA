package com.member.db;

import java.util.List;

public interface MemberDAO {
	// 로그인 시 아이디와 비밀번호 체크
	public int idCheck(String id, String pass);
	
	// 회원가입
	public void insertMember(MemberDTO mdto);
	
	//중복체크
	public int JoinIdCheck(String id);
	
	// 내 정보 가져오기
	public MemberDTO getMember(String id);
			
	// 내 정보 수정
	public int updateMember(MemberDTO mdto);
	
	// 회원 탈퇴(계정 삭제)
	public int deleteMember(String id,String pass);
	
	// 가입한 회원의 목록 가져오기
	public List<MemberDTO> getMemberList();	

	// 회원 마이 페이지 이름값 가져가기
	public List forNameNLevel(String id);
	
	// 비밀번호 변경
	public void updatePass(String id, String pass);
}
