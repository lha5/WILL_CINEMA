package com.admin.service.FAQ.db;

import java.util.List;

public interface AdminFAQDAO {

	
	public void insertFAQ(AdminFAQDTO afdto);
	public int updateFAQ(AdminFAQDTO afdto);
	public int getFAQCount();
	public AdminFAQDTO getFAQ(int num);
	public int deleteFAQ(int num);
	
	public List<AdminFAQDTO> getFAQList();
	public List<AdminFAQDTO> getFAQList(String item, int startCnt, int viewCnt);
	public List<AdminFAQDTO> getSearch(String keyward);
		

	
	/*
	public int updateEvent(AdminEventDTO aedto);
	public int deleteEvent(int num);*/
}
