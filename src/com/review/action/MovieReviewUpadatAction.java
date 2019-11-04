package com.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;

public class MovieReviewUpadatAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MoviewReviewUpdateAction execute()------------------------------------------------");
		
		// 한글처리 
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		int num = Integer.parseInt(request.getParameter("num"));
		
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		
		MovieReviewDTO mrdto = new MovieReviewDTO();
		System.out.println("rating : "+request.getParameter("rating"));
		mrdto.setNum(num);
		mrdto.setId(id);
		mrdto.setRating(Integer.parseInt(request.getParameter("rating")));
		mrdto.setContent(request.getParameter("content"));
		
		MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl();
		
		mrdaoImpl.modifyComment(mrdto);
		
		ActionForward forward = new ActionForward();
		
		request.setAttribute("movie_num", movie_num);
		
		forward.setPath("./DetailView.mo");
		forward.setRedirect(true);
		return forward;
	}

}
