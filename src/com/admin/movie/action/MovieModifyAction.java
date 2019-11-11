package com.admin.movie.action;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDAO;
import com.admin.movie.db.AdminMovieDAOImpl;
import com.admin.movie.db.AdminMovieDTO;

import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;




public class MovieModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("영화 수정 진행중!!!!!!!!!!!!!!!!!!!!!");
		
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
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");

		System.out.println("realPath : "+realPath);

		int maxSize = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request,realPath,maxSize,"UTF-8", new DefaultFileRenamePolicy());

		System.out.println(request.getParameter("running_time"));
		System.out.println(request.getAttribute("running_time"));
		
		AdminMovieDTO amdto = new AdminMovieDTO();
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));

		String title = multi.getParameter("title");
		String genre = multi.getParameter("genre");
		String country=multi.getParameter("country");
		String director = multi.getParameter("director");
		String story = multi.getParameter("story");
		String actor = multi.getParameter("actor");
		String image = multi.getFilesystemName("image");
		String poster = multi.getFilesystemName("poster");
		int running_time = Integer.parseInt(multi.getParameter("running_time"));

		amdto.setMovie_num(movie_num);
		amdto.setTitle(title);
		amdto.setCountry(country);
		amdto.setGenre(genre);
		amdto.setDirector(director);
		amdto.setStory(story);
		amdto.setActor(actor);
		amdto.setRunning_time(running_time);
		amdto.setImage(image);
		amdto.setPoster(poster);
		amdto.setGrade(multi.getParameter("grade"));
		amdto.setOpen_date(transformDate(multi.getParameter("open_date")));
		amdto.setClose_date(transformDate(multi.getParameter("close_date")));

		// QnaDAOImpl객체 생성
		AdminMovieDAO amdao = new AdminMovieDAOImpl();

		// updateBoard()
		amdao.updateBoard(amdto);

		forward.setPath("./MovieList.mo");
		forward.setRedirect(true);
		return forward;
		
	}

	public static Date transformDate(String date) {
		SimpleDateFormat before = new SimpleDateFormat("yyyyMMdd");
		
		// yyyyMMdd -> yyyy-MM-dd
		SimpleDateFormat after = new SimpleDateFormat("yyyy-MM-dd");
		
		java.util.Date tempDate = null;
		
		try {
			tempDate = before.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		String transformation = after.format(tempDate);
		
		Date dt = Date.valueOf(transformation);
		
		return dt;
	}
}
