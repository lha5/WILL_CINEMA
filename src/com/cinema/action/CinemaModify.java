package com.cinema.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;

public class CinemaModify implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CinemaModify execute()-----------------------------------------------------");
		
		request.setCharacterEncoding("UTF-8");
		
		int location_num = Integer.parseInt(request.getParameter("location_num"));
		System.out.println("영화관 번호 : "+location_num);
		
		// CineDAO 객체 생성
		CineDAO cdao = new CineDAOImpl();
		
		//getCinema(location_num);
		CineDTO cdto = cdao.getCinema(location_num);
		
		// DB에서 가져온 정보를 저장
		request.setAttribute("cdto", cdto);
		System.out.println(cdto.toString());
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./adminCinema/cinemaModify.jsp");
		forward.setRedirect(false);	// 가상주소에서 실제 jsp로 가야하기 때문에 false(forwarding 방식)

		return forward;
	}
	

}
