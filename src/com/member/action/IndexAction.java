package com.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;

public class IndexAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ACTIon indexAction  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		MovieDAOImpl mvdaoImpl  = new MovieDAOImpl();

		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
	
AdminEventDAO aedao = new AdminEventDAOImpl();
		
		// 카테고리별 리스트 가져오는 메서드 생성 getGoodsList(item);
		List eventMovieList = aedao.getEventList("movie");
		List eventPreviewList = aedao.getEventList("preview");		
		List eventNeventList = aedao.getEventList("nevent");
		List eventCollaboList = aedao.getEventList("collabo");
		
		////////////////////////event
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		int faqcount = afdao.getBoardCount();
		int faqpageSize =3;
		List<AdminFAQDTO> FAQList = null;
		
			FAQList = afdao.getBoardList();
		
		////////////////////FAQ
		MovieDAOImpl mvdaoImpl  = new MovieDAOImpl();
				int count = mvdaoImpl.getBoardCount();
				int pageSize = 5;
		System.out.println(" pageNum - 1 : " + request.getParameter("pageNum"));
		
		List<MovieDTO> boardList = null;
	
		if( count != 0 ){ 
			  boardList = mvdaoImpl.getBoardList();
		}
		// movie List

		TicketDAO tdao=new TicketDAOImpl();
		List<CineDTO> cineList = tdao.getCinemaList();
		List<MovieDTO> bookRatingList=tdao.bookRatingList();//예매순
		List<MovieDTO> totalRatingList=tdao.totalRatingList();//평점순
		
		
		//예매순 가지고 오기 
		
		
		
		// 정보 저장 
		request.setAttribute("eventMovieList", eventMovieList);
		request.setAttribute("eventPreviewList", eventPreviewList);
		request.setAttribute("eventNeventList", eventNeventList);
		request.setAttribute("eventCollaboList", eventCollaboList);
						
		request.setAttribute("faqcount", faqcount);
		request.setAttribute("FAQList", FAQList);
		System.out.println("@@@@@@@@@@@"+faqcount+""+FAQList);
		
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		System.out.println("!!!!!!!!!"+count+""+boardList+"11");
		
		request.setAttribute("cineList", cineList);
		request.setAttribute("bookRatingList", bookRatingList);
		request.setAttribute("totalRatingList", totalRatingList);
		
		
		// 페이지 이동 
		
		ActionForward forward = new ActionForward();
		forward.setPath("/include/main.jsp");
		forward.setRedirect(false);		

		return forward;
	}

}
