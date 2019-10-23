package com.admin.movie.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class MovieAddAction implements Action {

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
			// QnADTO객체 생성
			MovieDTO mdto = new MovieDTO();
			String title = request.getParameter("title");
			String genre = request.getParameter("genre");
			String director = request.getParameter("director");
			String story = request.getParameter("story");
			String actor = request.getParameter("actor");
			int running_time = Integer.parseInt(request.getParameter("running_time"));
				
			System.out.print("title : "+ title + " id : "+ id + " running_time : "+running_time);
				
<<<<<<< HEAD
			mdto.setTitle(title);
=======
			mdto.setTitle(name);
>>>>>>> branch 'master' of https://github.com/lha5/WILL_CINEMA.git
			mdto.setGenre(genre);
			mdto.setDirector(director);
			mdto.setStory(story);
			mdto.setActor(actor);
			mdto.setRunning_time(running_time);
				
			// QnaDAOImpl객체 생성
			MovieDAOImpl mvdaoImpl = new MovieDAOImpl();
			// insertBoard()
			mvdaoImpl.insertBoard(mdto);
				
			forward.setPath("./MovieList.mo");
			forward.setRedirect(true);
			return forward;
	}

}
