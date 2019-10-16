package com.admin.service.event.db;

import java.util.List;

public interface AdminEventDAO {
	public void eventInsert(AdminEventDTO aedto);
	
	public List<AdminEventDTO> getAllList(int startCnt, int viewCnt);
	
	public List<AdminEventDTO> getEventList();
	public List<AdminEventDTO> getEventList(String item);
<<<<<<< HEAD
	public List<AdminEventDTO> getSearch(String keyward);
=======
	public List<AdminEventDTO> getEventList(int startCnt, int viewCnt);
	public List<AdminEventDTO> getEventList(String item, int startCnt, int viewCnt);
	public List<AdminEventDTO> getEventList(String item, String keyward, int startCnt, int viewCnt);
	
	public List<AdminEventDTO> getSearch(String item,String keyward);
	public List<AdminEventDTO> getSearch(String keyward, int startCnt, int viewCnt);
	
	public List<AdminEventDTO> getPastSearch(String item, String keyward);
	public List<AdminEventDTO> getPastList(String item, int startCnt, int viewCnt);
	
>>>>>>> branch 'master' of https://github.com/lha5/WILL_CINEMA.git
	public AdminEventDTO getEvent(int eventId);
	
	public int updateEvent(AdminEventDTO aedto);
	public int deleteEvent(int num);
	
	public int getEventCount(String item, String keyward);
	public int getEventCount(String keyward);
	public int getEventCount();
}
