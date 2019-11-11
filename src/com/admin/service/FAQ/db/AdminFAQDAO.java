package com.admin.service.FAQ.db;

import java.util.List;



public interface AdminFAQDAO {

	//FAQ글쓰기
	public void insertFAQ(AdminFAQDTO afdto);
	//FAQ 수정 
	public int updateFAQ(AdminFAQDTO afdto);
	
	public void updateReadcount(int num);
	
	public int getFAQCount();
	
	public List<AdminFAQDTO> getFAQList(int startRow,int pageSize);
	
	public AdminFAQDTO getFAQ(int num);
	
	public int deleteFAQ(int num,String pass);
	
	
	// 메인 뿌리기위해 만들것 
	public int getBoardCount();
	
	public List<AdminFAQDTO> getBoardList();
	
	// 찾기 
	public List<AdminFAQDTO> getSearch(String search,int startRow,int pageSize);
	
}
