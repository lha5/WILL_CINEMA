package com.cinema.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDAO;
import com.admin.movie.db.AdminMovieDAOImpl;
import com.admin.movie.db.AdminMovieDTO;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;

public class CinemaUserViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("CinemaUserViewAction 나와용나와용 ");
		int cinema_num=Integer.parseInt(request.getParameter("cinema_num"));
	 
		 // 시네마 정보 가지고 오기 
		CineDAO cdao = new CineDAOImpl();
		CineDTO cineList = cdao.getCinema(cinema_num);
		
		//리스트저장
		System.out.println("지금 확인중"+ cinema_num);
	
		/////////////// 시네마 정보 
		
		AdminMovieDAO amdao  = new AdminMovieDAOImpl();
		int count = amdao.getBoardCount();
		int pageSize = 5;
		System.out.println(" pageNum - 1 : " + request.getParameter("pageNum"));
		
		List<AdminMovieDTO> boardList = null;
		
		MovieDAO mvdao = new MovieDAOImpl();
		if( count != 0 ){ 
			  boardList = mvdao.getBoardList();
		}
		// movie List
		
		// 정보 저장 
		request.setAttribute("cineList", cineList);
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		
		//넘기기
		ActionForward forward= new ActionForward();
		forward.setPath("./userCinema/cinemaView.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}
