package com.admin.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAOImpl;

public class MovieDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MoovieDeleteAction_execute()--------------------------------");
		
		ActionForward forward = new ActionForward();
		
		// pageNum 저장(get)
		String pageNum = request.getParameter("pageNum");
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		
		MovieDAOImpl mvdaoImpl = new MovieDAOImpl();
		
		int check = mvdaoImpl.deleteBoard(movie_num);
		
		if(check == 1){
			System.out.println("삭제성공");
		}
		
		forward.setPath("./MovieList.mo");
		forward.setRedirect(true);
		return forward;
	}

}
