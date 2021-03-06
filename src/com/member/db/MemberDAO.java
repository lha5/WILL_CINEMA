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
	public List forPointLevel(String id);
	
	// 비밀번호 변경
	public void updatePass(String id, String pass);
	
	// 포인트 적립
	public void addPoint(String id, int percentage);

	// 포인트 차감
	public void substractPoint(String id, int usingPoint);
	
	
  // 아이디 찾기
	List<MemberDTO> searchId(MemberDTO mdto);

  // 비밀번호 
	public List<MemberDTO> searchPass(MemberDTO mdto);


	public int emailCheck(String name, String email);

	
	//SNS회원 확인
	public String checkSNSMember(String id);
	
	//SNS회원 아이디 추가 번호
	public int SNSMemberinsertNum();
	
	//SNS회원 등록
	public void insertSNSMember(MemberDTO mdto);
}
