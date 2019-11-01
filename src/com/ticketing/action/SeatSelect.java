package com.ticketing.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;

public class SeatSelect implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SeatSelect execute()---------------------------------------------------");
		
		//세션 처리
		
		//영화 데이터
		//MovieDTO mdto = request.getAttribute("mdto");
		
		// 시험중이기에 데이터베이스에서 바로 가져옴 
		// 후에 합칠때 예매페이지에서 데이터 받아와야함
		MovieDAOImpl mdaoimpl = new MovieDAOImpl();
		MovieDTO mdto = mdaoimpl.getBoard(1);
		
		
		//영화관 데이터
		//CineDTO cdto = request.getAttribute("cdto");
		
		// 시험중이기에 데이터베이스에서 바로 가져옴 
		// 후에 합칠때 예매페이지에서 데이터 받아와야함
		CineDAOImpl cdaoimpl = new CineDAOImpl();
		CineDTO cdto = cdaoimpl.getCinema(1);
		
		
		//예매 데이터

		//request.getAttribute("");
		
		// 시험중이라 데이터 임의로 넣음 
		// 후에 합칠때 예매페이지에서 데이버 받아와야함
		// 후에 TicketDTO에 저장할 것 
		String running_date = "2019-10-30(수)";
		String running_time = "11:00~12:40";
		
		
		
		// 데이터 저장
		// 영화데이터, 영화관데이터, 예매 데이터
		// 가능하면 TicketDTO에 해당 데이터 저장후 이동이 좋음
		request.setAttribute("mdto", mdto);
		request.setAttribute("cdto", cdto);
		request.setAttribute("running_date", running_date);
		request.setAttribute("running_time", running_time);
		
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./ticketing/seat-ticketing.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}
