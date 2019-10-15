package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	System.out.println("updateAction ~~~!!!");	
		
	request.setCharacterEncoding("UTF-8");
		
	Integer num = Integer.parseInt(request.getParameter("num"));
	
	AdminFAQDTO afdto = new AdminFAQDTO();
	afdto.setSubject(request.getParameter("subject"));
	afdto.setCategory(request.getParameter("category"));
	afdto.setContent(request.getParameter("content"));
	afdto.setImage(request.getParameter("image"));
		
	AdminFAQDAO afdao = new AdminFAQDAOImpl();
	int check = afdao.updateFAQ(afdto);
	
	ActionForward forward = new ActionForward();
	forward.setPath("./FAQList.af");
	forward.setRedirect(true);
	return forward;
	

	}

}
