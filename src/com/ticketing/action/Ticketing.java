package com.ticketing.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class Ticketing implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("---------------------- Ticketing() 예매 페이지  ---------------------");
		
		
		
		//영화관DB 정보 다 가져오기
		
		//영화DB 정보 다 가져오기
		
		ActionForward forward=new ActionForward();
		forward.setPath("./ticketing/ticketing.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
