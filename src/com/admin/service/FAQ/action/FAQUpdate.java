package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

	int  num= Integer.parseInt(request.getParameter("num"));	
	String pageNum = request.getParameter("pageNum");
			
	System.out.println(num+","+pageNum);
	
	 AdminFAQDAO afdao = new AdminFAQDAOImpl();
	 AdminFAQDTO afdto = afdao.getFAQ(num);
		
	 // 정보저장
	 request.setAttribute("afdto", afdto);
	 request.setAttribute("pageNum", pageNum);
	 
	 ActionForward forward = new ActionForward();
	 forward.setPath("./FAQBoard/faqUpdate.jsp");
	 forward.setRedirect(false);
	 return forward;
	}

}
