package com.review.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDTO;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class MoviewReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MovieReviewDTO mrdto = new MovieReviewDTO();
		
		System.out.println("movie_num : "+mrdto.getMovie_num());
		
		MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl(); 
		
		ActionForward forward = new ActionForward();
		
		List<MovieReviewDTO> boardList = null;
		
		boardList = mrdaoImpl.commentList(mrdto.getMovie_num());
		
		request.setAttribute("boardList", boardList);
		forward.setPath("./DetailView.mo");
		forward.setRedirect(false);
		
		return forward;
	}

}
