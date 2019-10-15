package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.event.db.AdminEventDAOImpl;

public class FAQDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		int num= Integer.parseInt(request.getParameter("num"));
		ActionForward forward = new ActionForward();
		if(!id.equals("admin")){
			forward.setPath("./Main.me");
			forward.setRedirect(true);
			return forward;
		}
		
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		int check = afdao.deleteFAQ(num);
		
		forward.setPath("./FAQList.af");
		forward.setRedirect(true);
		return forward;
	}

}
