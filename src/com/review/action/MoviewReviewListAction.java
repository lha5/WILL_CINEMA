package com.review.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class MoviewReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl(); 
		
		ActionForward forward = new ActionForward();
		
		List<MovieReviewDTO> boardList = null;
		
		boardList = mrdaoImpl.commentList();
			  
		request.setAttribute("boardList", boardList);
		forward.setPath("./review/reviewList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
