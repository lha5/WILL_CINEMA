package com.admin.service.event.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventConSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*-------- eventContent.jsp -> EventConSearchAction()[검색] -------------*/");
		//수정
		String keyward=request.getParameter("keyward");
		String title=request.getParameter("title");
		
		AdminEventDAO aedao=new AdminEventDAOImpl();
		List<AdminEventDTO> eventList=aedao.getSearch(keyward);
		
		request.setAttribute("eventList", eventList);
		request.setAttribute(keyward, "keyward");
		
		ActionForward forward=new ActionForward();
		forward.setPath("./EventContent.ae?item="+title);
		forward.setRedirect(true);
		return forward;
	}
}
