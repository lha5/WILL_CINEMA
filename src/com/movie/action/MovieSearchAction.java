package com.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;

public class MovieSearchAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieSearchAction()-------------------");
		
		//한글처리 
		request.setCharacterEncoding("UTF-8");
		
		MovieDAOImpl movieDAOImpl = new MovieDAOImpl();
		
		// movieList에서 검색결과 받아옴
		String search = request.getParameter("searchText");
		// 리스트에서 옵션값을 가져옴
		String searchType = request.getParameter("searchType");
		
		
		System.out.println("검색어 : "+search);
		
		int count = movieDAOImpl.getBoardCount();
		// 10개까지만 글 화면에 출력됨
		int pageSize = 10;
		
		System.out.println("pageNum - 1 : " + request.getParameter("pageNum"));
		
		//현페이지가 몇 페이지인지 가져오기
		String pageNum = request.getParameter("pageNum");
	
		if(pageNum == null){
			pageNum = "1";
		}
		
		//시작행 구하기
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage -1) * pageSize +1;
		
		//끝행 구하기
		int endRow = currentPage * pageSize;
		
		List<MovieDTO> boardList = null;
		
		if( count !=0 ){
			boardList = movieDAOImpl.getSearch(searchType ,search, startRow, pageSize);
		}
		
		//전체 페이지수 구하기
		int pageCount = count/pageSize+(count % pageSize == 0? 0:1);
		
		int pageBlock = 1;
	
		
		//시작 페이지
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
		//끝페이지
		int endPage = startPage+pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./movie/movieList.jsp");
		forward.setRedirect(false);
		
		
		
		
		return forward;
	}

}
