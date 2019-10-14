package com.admin.service.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class EventPastAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*-------- eventSummary.jsp -> EventPastAction()(지난이벤트) -------*/");
		
		
		
		return null;
	}

}
