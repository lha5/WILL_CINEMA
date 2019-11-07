package com.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;

public class MoviewReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MoviewReviewWriteAction execute()------------------------------------------------");
		
		// 한글처리 
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = new ActionForward();
		
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		System.out.println(" movie_num(write) : "+movie_num);
		
		MovieReviewDTO mrdto = new MovieReviewDTO();
		System.out.println("rating : "+request.getParameter("rating")+" movie_num : "+movie_num);
		mrdto.setMovie_num(movie_num);
		mrdto.setId(id);
		mrdto.setRating(Integer.parseInt(request.getParameter("rating")));
		mrdto.setContent(request.getParameter("content"));
		
		MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl();
		
		mrdaoImpl.writeComment(mrdto);
		
		request.setAttribute("movie_num2", movie_num);
		
		System.out.println("Attribute movie_num(write) : "+request.getAttribute("movie_num2"));
		
		forward.setPath("./DetailView.mo?movie_num="+movie_num);
		forward.setRedirect(true);
		
		return forward;
	}

}
