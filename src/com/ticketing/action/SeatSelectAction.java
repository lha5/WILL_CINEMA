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
		
		
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		//forward.setPath("./");
		//forward.setRedirect(false);
		
		return null;
	}

}
