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
		
		//세션처리
		// 세션 -> 아이디, 파라미터 -> num,movie_num 값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		int num = Integer.parseInt(request.getParameter("num"));
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		System.out.println(" movie_num(update) : "+movie_num);
		
		
		MovieReviewDTO mrdto = new MovieReviewDTO();
		System.out.println("rating : "+request.getParameter("rating"));
		mrdto.setNum(num);
		mrdto.setId(id);
		mrdto.setRating(Integer.parseInt(request.getParameter("rating")));
		mrdto.setContent(request.getParameter("content"));
		
		MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl();
		
		mrdaoImpl.modifyComment(mrdto);
		
		ActionForward forward = new ActionForward();
		
		request.setAttribute("movie_num2", movie_num);
		
		System.out.println("Attribute movie_num(update) : "+request.getAttribute("movie_num2"));
		
		forward.setPath("./DetailView.mo?movie_num="+movie_num);
		forward.setRedirect(true);
		return forward;
	}

}
