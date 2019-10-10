package com.admin.service.event.db;

import java.util.List;

public interface AdminEventDAO {
	public void eventInsert(AdminEventDTO aedto);
	public List<AdminEventDTO> getGoodsList(String item);
	public AdminEventDTO getEvent(int eventId);
}
