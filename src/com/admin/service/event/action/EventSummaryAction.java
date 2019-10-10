package com.admin.service.event.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;

public class EventSummaryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------------- EventSummaryAction()[이벤트 리스트(사용자)]-------------------------*/");
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// DB처리 객체 생성  
		// AdminEventDAO 객체 생성 
		AdminEventDAO aedao = new AdminEventDAOImpl();
		
		// 카테고리별 리스트 가져오는 메서드 생성 getGoodsList(item);
		List eventMovieList = aedao.getGoodsList("movie");
		List eventPreviewList = aedao.getGoodsList("preview");		
		List eventNeventList = aedao.getGoodsList("nevent");
		List eventCollaboList = aedao.getGoodsList("collabo");
		
		// 정보 저장 
		request.setAttribute("eventMovieList", eventMovieList);
		request.setAttribute("eventPreviewList", eventPreviewList);
		request.setAttribute("eventNeventList", eventNeventList);
		request.setAttribute("eventCollaboList", eventCollaboList);
				
		// 페이지 이동 (./service/eventBoard/eventSummary.jsp)		
		ActionForward forward=new ActionForward();
		forward.setPath("./service/eventBoard/eventSummary.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
