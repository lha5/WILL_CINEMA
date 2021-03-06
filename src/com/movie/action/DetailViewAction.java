package com.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDTO;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.review.db.MovieReviewDAO;
import com.review.db.MovieReviewDAOImpl;
import com.review.db.MovieReviewDTO;

public class DetailViewAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieContentAction_execute()---------------------------");
	
			
			//int num = Integer.parseInt(request.getParameter("num"));
			
			int movie_num = 0;
			System.out.println("Attribute movie_num2 : "+request.getAttribute("movie_num2"));
			System.out.println("parameter movie_num : "+request.getParameter("movie_num"));
			if(!request.getParameter("movie_num").equals(null)){
				
				movie_num = Integer.parseInt(request.getParameter("movie_num"));
				System.out.println("Parameter movie_num : "+movie_num);
				
			}else{
				
				movie_num = (int) request.getAttribute("movie_num2");
				System.out.println("Attribute movie_num : "+movie_num);
				
			}
			
			String pageNum = request.getParameter("pageNum");
		
			 //System.out.println("num : " + num + ", pageNum : " + pageNum);
		
			//MovieDAO 객체 생성
			MovieDAO mdao = new MovieDAOImpl(); 
			MovieReviewDAOImpl mrdaoImpl = new MovieReviewDAOImpl();
			
			
			List<MovieReviewDTO> boardList = null;
			boardList = mrdaoImpl.commentList(movie_num);
			
			// 평점 평균
			MovieReviewDAO mrdao = new MovieReviewDAOImpl();
			int avgRating = mrdao.avgRating(movie_num);
			
			mdao.setRating(movie_num,avgRating);
			// 글 번호에 해당하는 글 정보 가져오기
			AdminMovieDTO amdto = mdao.getBoard(movie_num);
						
			// 정보 저장
			request.setAttribute("mdto", amdto);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("boardList", boardList);
			//request.setAttribute("avgRating", avgRating);
			
			// 페이지 이동
			ActionForward forward = new ActionForward();
			forward.setPath("./movie/MovieContent.jsp");
			forward.setRedirect(false);
			return forward;
	}


}
