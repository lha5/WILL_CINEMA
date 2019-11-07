package com.review.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.review.db.MovieReviewDAO;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;

public class MovieReviewUpadate implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MoviewReviewUpdate execute()------------------------------------------------");
		
		//한글 처리
		request.setCharacterEncoding("UTF-8");
		
		//세션 처리
		HttpSession session = request.getSession();
		
		// 파라미터값 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		
		String id = request.getParameter("id");
		
		System.out.println(num+","+ movie_num);
		
		//리뷰 전체 가져오기
		MovieReviewDAO mrdao = new MovieReviewDAOImpl(); 
		
		MovieReviewDTO mrdto = mrdao.getReview(id, movie_num, num);
		
		request.setAttribute("movie_num", movie_num);
		request.setAttribute("num", num);
		request.setAttribute("mrdto", mrdto);
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		
		forward.setPath("./review/reviewUpdate.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
