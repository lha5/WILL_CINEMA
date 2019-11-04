package com.ticketing.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class SeatSelectAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SeatSelectAction execute()---------------------------------------------------");
		
		
		//영화 데이터
		
		
		//영화관 데이터
		
		
		//시간 데이터
		
		//좌석 데이터
		//나이에 따른 인원수  
		String adult = request.getParameter("adult");
		String teenager = request.getParameter("teenager");
		String senior = request.getParameter("senior");
		
		System.out.println("인원수 가져오기 : "+adult+","+teenager+","+senior);
		
		
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		//forward.setPath("./");
		//forward.setRedirect(false);
		
		return null;
	}

}
