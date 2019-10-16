package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;
import com.admin.service.event.db.AdminEventDAOImpl;

public class FAQWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("FAQWrite액션 나옵니다~!!~!");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id= (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		
						
		AdminFAQDTO afdto = new AdminFAQDTO();
		
		afdto.setCategory(request.getParameter("category"));
		afdto.setSubject(request.getParameter("subject"));
		afdto.setContent(request.getParameter("content"));
		afdto.setImage(request.getParameter("image"));
		
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		afdao.insertFAQ(afdto);
		
		
		forward.setPath("./FAQList.af");
		forward.setRedirect(true);
		return forward;
		
		
		
	}

}
