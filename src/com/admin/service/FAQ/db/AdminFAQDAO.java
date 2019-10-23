package com.admin.service.FAQ.db;

import java.util.List;

import com.admin.service.notice.db.AdminNoticeDTO;

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
	
	
	

	
	
}
