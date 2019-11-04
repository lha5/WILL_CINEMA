package com.admin.service.event.db;

import java.util.List;

public interface AdminEventDAO {
	public void eventInsert(AdminEventDTO aedto);
	
	public List<AdminEventDTO> getAllList(int startCnt, int viewCnt);
	
	public List<AdminEventDTO> getEventList();
	public List<AdminEventDTO> getEventList(String item);
	public List<AdminEventDTO> getEventList(int startCnt, int viewCnt);
	public List<AdminEventDTO> getEventList(String item, int startCnt, int viewCnt);
	public List<AdminEventDTO> getEventList(String item, String keyward, int startCnt, int viewCnt);
	
	public List<AdminEventDTO> getSearch(String item,String keyward);
	public List<AdminEventDTO> getSearch(String keyward, int startCnt, int viewCnt);
	
	public List<AdminEventDTO> getPastSearch(String item, String keyward);
	public List<AdminEventDTO> getPastList(String item, int startCnt, int viewCnt);
	
	public AdminEventDTO getEvent(int eventId);
	//public AdminEventDTO getPastEvent(int eventId);//지난 이벤트 
	
	public int updateEvent(AdminEventDTO aedto);
	public int deleteEvent(int num);
	
	public int getEventCount(String item, String keyward);
	public int getEventCount(String keyward);
	public int getEventCount();
}