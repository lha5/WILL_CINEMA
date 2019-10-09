package com.member.db;

import java.util.List;

public interface MemberDAO {

	public int idCheck(String id, String pass);
	
	public void insertMember(MemberDTO mdto);	
		
	public MemberDTO getMember(String id);
	
	public int updateMember(MemberDTO mdto);
	
	public int deleteMember(String id,String pass);
	
	public List<MemberDTO> getMemberList();	
}
