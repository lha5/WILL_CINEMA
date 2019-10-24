package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class FAQDelete implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("FAQDelete_execute()------------------------------------");
		
		// num, pageNum
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		AdminFAQDTO afdto = afdao.getFAQ(num);
		
		request.setAttribute("afdto", afdto );
		request.setAttribute("pageNum", pageNum);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./service/FAQBoard/faqDelete.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
