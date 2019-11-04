package com.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAOImpl;
import com.review.db.MovieReviewDAOImpl;

public class MovieReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MovieReviewDeleteAction execute()----------------------------------------------");
		
		ActionForward forward = new ActionForward();
		
		// pageNum 저장(get)
		String pageNum = request.getParameter("pageNum");
		int num = Integer.parseInt(request.getParameter("num"));
		
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		
		MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl();
		
		int check = mrdaoImpl.deleteComment(num);
		
		if(check == 1){
			System.out.println("삭제성공");
		}
		
		request.setAttribute("movie_num", movie_num);
		
		forward.setPath("./DetailView.mo");
		forward.setRedirect(true);
		return forward;
	}

}
