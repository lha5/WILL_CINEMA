package com.cinema.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;

public class CinemaAdminDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("CinemaDetailAction execute()-----------------------------------------------------");
		
		// CineDAO 객체 생성
		CineDAO cdao = new CineDAOImpl();
		
		// getCineList(); >> List 형태의 데이터를 리턴
		List<CineDTO> cineList = cdao.getCineList();
		
		// DB에서 가져온 정보를 저장
		request.setAttribute("cineList", cineList);
		
		
		// 페이지 이동(./CinemaDetail.ci)
		
		ActionForward forward = new ActionForward();
		forward.setPath("./adminCinema/cinemaAdminList.jsp");
		forward.setRedirect(false);	// 가상주소에서 실제 jsp로 가야하기 때문에 false(forwarding 방식)

		
		return forward;
	}

}
