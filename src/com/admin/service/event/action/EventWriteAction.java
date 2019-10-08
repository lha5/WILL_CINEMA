package com.admin.service.event.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("/*--------------- eventWirte.jsp[이벤트 작성 ]-> EventWriteAction()[이벤트 처리]-------------------------*/");
		//파일 위치(가상경로)
		ServletContext context=req.getServletContext();
		String realpath=context.getRealPath("/upload");
		
		//파일 크기
		int maxSize=10*1024*1024;
		
		AdminEventDTO aedto=new AdminEventDTO();
		
		AdminEventDAO aedao=new AdminEventDAOImpl();
		//aedao.eventInsert();

		ActionForward forward=new ActionForward();
		forward.setPath("/Main.me");
		forward.setRedirect(true);
		return forward;
	}

}
