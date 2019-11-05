package com.admin.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDAO;
import com.admin.movie.db.AdminMovieDAOImpl;
import com.movie.db.MovieDAOImpl;

public class MovieDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MoovieDeleteAction_execute()--------------------------------");
		
		ActionForward forward = new ActionForward();
		
		// pageNum 저장(get)
		String pageNum = request.getParameter("pageNum");
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		
		AdminMovieDAO mvdaoImpl = new AdminMovieDAOImpl();
		
		int check = mvdaoImpl.deleteBoard(movie_num);
		
		if(check == 1){
			System.out.println("영화 삭제가 완료되었습니다.");
		}
		
		forward.setPath("./MovieList.mo");
		forward.setRedirect(true);
		return forward;
	}

}
