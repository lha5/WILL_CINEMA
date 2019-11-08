package com.ticketing.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;
import com.ticketing.db.TicketDTO;

public class TicketingDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("TicketingDetailAction execute()-------------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		int book_num = Integer.parseInt(request.getParameter("book_num"));
		
		TicketDAO tdao = new TicketDAOImpl();
		TicketDTO tdto = tdao.getBookDetail(book_num);
		
		MovieDAO mdao = new MovieDAOImpl();
		String title = mdao.getTitle(tdto.getMovie_num());
		
		request.setAttribute("tdto", tdto);
		request.setAttribute("title", title);
		
		forward.setPath("./ticketing/ticketingDetail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
