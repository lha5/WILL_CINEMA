package com.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class MovieListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MovieDAOImpl mvdaoImpl  = new MovieDAOImpl();
		
		int count = mvdaoImpl.getBoardCount();
		
		int pageSize = 10;
		
		System.out.println("pageNum - 1 : " + request.getParameter("pageNum"));
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}List<MovieDTO> boardList = null;
		
		if( count != 0 ){ 
			  boardList = mvdaoImpl.getBoardList();
		}
		
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		
		forward.setPath("./moive/movieList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
