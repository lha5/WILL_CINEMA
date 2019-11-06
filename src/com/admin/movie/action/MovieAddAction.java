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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MovieAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			

		System.out.println("MovieAddAction execute()----------------------------------------------------");

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

		AdminMovieDTO amdto = new AdminMovieDTO();

		amdto.setTitle(multi.getParameter("title"));
		amdto.setStory(multi.getParameter("story"));
		amdto.setCountry(multi.getParameter("country"));
		amdto.setGenre(multi.getParameter("genre"));
		amdto.setOpen_date(transformDate(multi.getParameter("open_date")));
		amdto.setClose_date(transformDate(multi.getParameter("close_date")));
		amdto.setDirector(multi.getParameter("director"));
		amdto.setActor(multi.getParameter("actor"));
		amdto.setRunning_time(Integer.parseInt(multi.getParameter("running_time")));
		amdto.setPoster(multi.getFilesystemName("poster"));
		amdto.setImage(multi.getFilesystemName("image"));

		AdminMovieDAO amdao = new AdminMovieDAOImpl();


		amdao.insertBoard(amdto);
		
		forward.setPath("./MovieList.mo");
		forward.setRedirect(true);
		return forward;
	}
	
	
	
	// 개봉일과 마감일 타입 변환 메소드
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
