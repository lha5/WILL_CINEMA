package com.admin.service.event.db;

import java.util.List;

public interface AdminEventDAO {
	public void eventInsert(AdminEventDTO aedto);
	public List<AdminEventDTO> getEventList();
	public List<AdminEventDTO> getEventList(String item, int startCnt, int viewCnt);
	public List<AdminEventDTO> getSearch(String keyward);
	public AdminEventDTO getEvent(int eventId);
	public int updateEvent(AdminEventDTO aedto);
	public int deleteEvent(int num);
}
