package com.member.db;

public interface MemberDAO {

//	public int idCheck(String id, String pass);
		
	public MemberDTO getMember(String id);
	
	public int updateMember(MemberDTO mdto);
	
	public int deleteMember(String id,String pass);
	
	
	public void insertMember(MemberDTO mdto);	
}
