package com.cinema.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;

public class CinemaDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CinemaDeleteAction execute()-----------------------------------------------------");
		
		
		
		//영화관 번호 가져오기
		int location_num = Integer.parseInt(request.getParameter("location_num"));
		
		
		// CineDAO 객체 생성
		CineDAO cdao = new CineDAOImpl();
		// deleteCinema() 영화관 삭제 매서드
		cdao.deleteCinema(location_num);
		
		
		// 페이지 이동(./CinemaDetail.ci)
		ActionForward forward = new ActionForward();
		forward.setPath("./CinemaAdminDetail.ci");
		forward.setRedirect(true);	
		
		return forward;
	}
	
}
