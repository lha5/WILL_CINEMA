package com.admin.service.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------- eventSummary.jsp -> EventDetailAction ------------------------*/");
		
		int eventId = Integer.parseInt(request.getParameter("eventId"));
		
		// 디비 처리 객체 DAO 생성
		AdminEventDAO aedao = new AdminEventDAOImpl();
		
		// 이벤트 번호에 해당하는 이벤트 정보를 가져오는 메서드
		// getEvent(num); -> DTO 리턴
		AdminEventDTO aedto = aedao.getEvent(eventId);

		// DTO 객체 저장
		request.setAttribute("aedto", aedto);

		ActionForward forward=new ActionForward();
		forward.setPath("./service/eventBoard/eventDetail.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
