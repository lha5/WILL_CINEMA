package com.admin.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;

public class MovieModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
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
					
			MovieDTO mdto = new MovieDTO();
			int movie_num = Integer.parseInt(request.getParameter("movie_num"));
			String name = request.getParameter("name");
			String genre = request.getParameter("genre");
			String director = request.getParameter("director");
			String story = request.getParameter("story");
			String actor = request.getParameter("actor");
			int running_time = Integer.parseInt(request.getParameter("running_time"));
						
			System.out.print("name : "+ name + " id : "+ id + " running_time : "+running_time+"movie_num(Action) : "+movie_num);
			
			mdto.setMovie_num(movie_num);
			mdto.setTitle(name);
			mdto.setGenre(genre);
			mdto.setDirector(director);
			mdto.setStory(story);
			mdto.setActor(actor);
			mdto.setRunning_time(running_time);
						
			// QnaDAOImpl객체 생성
			MovieDAOImpl mvdaoImpl = new MovieDAOImpl();
			// insertBoard()
			mvdaoImpl.updateBoard(mdto);
					
			forward.setPath("./MovieList.mo");
			forward.setRedirect(true);
			return forward;
	
	}

}
