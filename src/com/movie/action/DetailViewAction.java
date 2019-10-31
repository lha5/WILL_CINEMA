package com.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;

public class DetailViewAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieContentAction_execute()---------------------------");
	
			
			//int num = Integer.parseInt(request.getParameter("num"));
			// int num = 1;


			int num = Integer.parseInt(request.getParameter("movie_num"));


			int num = Integer.parseInt(request.getParameter("movie_num"));


			String pageNum = request.getParameter("pageNum");
		
			 //System.out.println("num : " + num + ", pageNum : " + pageNum);
		
			//MovieDAO 객체 생성
			MovieDAO mdao = new MovieDAOImpl(); 
		
			// 글 번호에 해당하는 글 정보 가져오기
			MovieDTO mdto = mdao.getBoard(num);
	
			// 정보 저장
			request.setAttribute("mdto", mdto);
			request.setAttribute("pageNum", pageNum);
		
			
			// 페이지 이동
			ActionForward forward = new ActionForward();
			forward.setPath("./movie/MovieContent.jsp");
			forward.setRedirect(false);
			return forward;
	}


}
