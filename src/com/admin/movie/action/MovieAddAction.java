package com.admin.movie.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDTO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

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
			
			// QnADTO객체 생성
			AdminMovieDTO amdto = new AdminMovieDTO();
			
			amdto.setTitle(multi.getParameter("title"));
			amdto.setStory(multi.getParameter("story"));
			amdto.setCountry(multi.getParameter("country"));
			amdto.setGenre(multi.getParameter("genre"));
			System.out.println("opendate 값 : " + multi.getParameter("open_date") + ", " + "closedate 값 : " + multi.getParameter("close_date"));
			//amdto.setOpen_date(multi.getParameter("open_date"));
			//amdto.setClose_date(multi.getParameter("close_date"));
			amdto.setDirector(multi.getParameter("director"));
			amdto.setActor(multi.getParameter("actor"));
			amdto.setRunning_time(Integer.parseInt(multi.getParameter("running_time")));
			amdto.setPoster(multi.getFilesystemName("poster"));
			amdto.setImage(multi.getFilesystemName("image"));
				
			// QnaDAOImpl객체 생성
			MovieDAOImpl amdao = new MovieDAOImpl();
			
			// insertBoard()
			
				
			forward.setPath("./MovieList.mo");
			forward.setRedirect(true);
			return forward;
	}

}
