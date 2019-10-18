package com.admin.service.FAQ.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		// AdminNoticeDAO 객체 생성
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
	
	
		afdao.updateReadcount(num);
		
		// 글번호에 해당하는 글정보를 가져오기
		AdminFAQDTO afdto = afdao.getFAQ(num);
	
		// 정보 저장 (글정보,pageNum)
		request.setAttribute("afdto", afdto);
		request.setAttribute("pageNum", pageNum);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./service/FAQBoard/faqContent.jsp");
		forward.setRedirect(false);
		return forward;
	
	}

}
