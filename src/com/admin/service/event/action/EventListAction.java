package com.admin.service.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class EventListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------------- eventWirte.jsp[이벤트 작성 ]-> EventWriteAction()[이벤트 처리]-------------------------*/");
		
		
		
		ActionForward forward=new ActionForward();
		forward.setPath("./Main.me");
		forward.setRedirect(true);
		return forward;
	}

}
