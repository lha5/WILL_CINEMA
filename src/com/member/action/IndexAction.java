package com.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;

public class IndexAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ACTIon indexAction  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		MovieDAOImpl mvdaoImpl  = new MovieDAOImpl();
		
		int count = mvdaoImpl.getBoardCount();
		
		int pageSize = 10;
		
		System.out.println(" pageNum - 1 : " + request.getParameter("pageNum"));
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		
		List<MovieDTO> boardList = null;
		
		if( count != 0 ){ 
			  boardList = mvdaoImpl.getBoardList();
		}
		
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		System.out.println(count+""+boardList+"11");
		
		ActionForward forward = new ActionForward();
		forward.setPath("/include/main.jsp");
		forward.setRedirect(false);		

		return forward;
	}

}
