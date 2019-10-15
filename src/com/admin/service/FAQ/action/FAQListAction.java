package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;

public class FAQListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = (String) request.getAttribute("id");
		
		
		
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		
		
		int count = afdao.getFAQCount();		
	
		ActionForward forward = new ActionForward();
		forward.setPath("./faq/faqList.jsp");
		forward.setRedirect(false);		

		return forward;
	}

}
