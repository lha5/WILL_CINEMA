package com.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;

public class DetailViewAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieContentAction_execute()---------------------------");
	
			
			//int num = Integer.parseInt(request.getParameter("num"));
			
			int movie_num = 0;

			if(request.getParameter("movie_num").equals(null)){
				movie_num = (int) request.getAttribute("movie_num");
				System.out.println("Attribute movie_num : "+movie_num);
			}else{
				movie_num = Integer.parseInt(request.getParameter("movie_num"));
				System.out.println("Parameter movie_num : "+movie_num);
			}
			
			System.out.println("Attribute movie_num : "+request.getAttribute("movie_num"));
			String pageNum = request.getParameter("pageNum");
		
			 //System.out.println("num : " + num + ", pageNum : " + pageNum);
		
			//MovieDAO 객체 생성
			MovieDAOImpl mdao = new MovieDAOImpl(); 
			
			MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl(); 
		
			// 글 번호에 해당하는 글 정보 가져오기
			MovieDTO mdto = mdao.getBoard(movie_num);
			
			List<MovieReviewDTO> boardList = null;
			
			boardList = mrdaoImpl.commentList(movie_num);
	
			// 정보 저장
			request.setAttribute("mdto", mdto);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("boardList", boardList);
		
			
			// 페이지 이동
			ActionForward forward = new ActionForward();
			forward.setPath("./movie/MovieContent.jsp");
			forward.setRedirect(false);
			return forward;
	}


}
