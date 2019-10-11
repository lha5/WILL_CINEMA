package com.admin.service.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------- EventUpdate() -> eventUpdate.jsp ------------------------*/");
		
		int num=Integer.parseInt(request.getParameter("num"));
		
		AdminEventDAO aedao = new AdminEventDAOImpl();
		AdminEventDTO aedto=aedao.getEvent(num);
		
		request.setAttribute("aedto", aedto);

		ActionForward forward=new ActionForward();
		forward.setPath("./service/eventBoard/eventUpdate.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
