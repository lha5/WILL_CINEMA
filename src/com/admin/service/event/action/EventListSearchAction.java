package com.admin.service.event.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventListSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------------- EventListSearchAction()[관리자 검색 리스트]-------------------------*/");
		
		AdminEventDAO aedao =new AdminEventDAOImpl();
		List<AdminEventDTO> arr=aedao.getEventList();
		//DB에서 가져온 정보 저장
		request.setAttribute("arr", arr);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./service/eventBoard/eventList.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
