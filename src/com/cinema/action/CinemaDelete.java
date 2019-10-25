package com.cinema.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;

public class CinemaDelete implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CinemaModify execute()-----------------------------------------------------");
		
		request.setCharacterEncoding("UTF-8");
		
		int cinema_num = Integer.parseInt(request.getParameter("cinema_num"));
		//String room = request.getParameter("room");
		System.out.println("영화관 번호 : "+cinema_num);
		
		// CineDAO 객체 생성
		CineDAO cdao = new CineDAOImpl();
		
		//getCinema(cinema_num);
		CineDTO cdto = cdao.getCinema(cinema_num);
		
		// DB에서 가져온 정보를 저장
		request.setAttribute("cdto", cdto);
		System.out.println(cdto.toString());
		
		//request.setAttribute("room",room);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./adminCinema/cinemaDelete.jsp");
		forward.setRedirect(false);	// 가상주소에서 실제 jsp로 가야하기 때문에 false(forwarding 방식)

		return forward;
		
	}
	
}
