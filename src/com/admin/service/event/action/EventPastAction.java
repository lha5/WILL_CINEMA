package com.admin.service.event.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventPastAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*-------- eventSummary.jsp -> EventPastAction()(지난이벤트) -------*/");
		// 한글처리
		request.setCharacterEncoding("UTF-8");

		String keyward = request.getParameter("keyward");
		if (keyward == null) {
			keyward = "";
		}
		System.out.println("jsp 키워드 : "+keyward);
		String item = request.getParameter("item");
		if(item==null){
			item="movie";
		}
		// DB처리 객체 생성
		// AdminEventDAO 객체 생성
		AdminEventDAO aedao = new AdminEventDAOImpl();

		// 카테고리별 리스트 가져오는 메서드 생성 getGoodsList(item);
		List<AdminEventDTO> eventList = aedao.getPastSearch(item, keyward);

		// 정보 저장
		request.setAttribute("eventList", eventList);
		request.setAttribute("keyward", keyward);// 검색어
		ActionForward forward = new ActionForward();
		forward.setPath("./service/eventBoard/eventPast.jsp?item="+item);
		forward.setRedirect(false);
		return forward;
	}

}
