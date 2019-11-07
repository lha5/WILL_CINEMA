package com.admin.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDAO;
import com.admin.movie.db.AdminMovieDAOImpl;
import com.admin.movie.db.AdminMovieDTO;


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

		System.out.println(request.getParameter("running_time"));
		System.out.println(request.getAttribute("running_time"));
		
		AdminMovieDTO amdto = new AdminMovieDTO();
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		String name = request.getParameter("name");
		String genre = request.getParameter("genre");
		String director = request.getParameter("director");
		String story = request.getParameter("story");
		String actor = request.getParameter("actor");
		int running_time = Integer.parseInt(request.getParameter("running_time"));

		System.out.print("name : "+ name + " id : "+ id + " runing_time : "+running_time+"movie_num(Action) : "+movie_num);

		amdto.setMovie_num(movie_num);
		amdto.setTitle(name);
		amdto.setGenre(genre);
		amdto.setDirector(director);
		amdto.setStory(story);
		amdto.setActor(actor);
		amdto.setRunning_time(running_time);

		// QnaDAOImpl객체 생성
		AdminMovieDAO amdao = new AdminMovieDAOImpl();

		// updateBoard()
		amdao.updateBoard(amdto);

		forward.setPath("./MovieList.mo");
		forward.setRedirect(true);
		return forward;
		
	}
}
