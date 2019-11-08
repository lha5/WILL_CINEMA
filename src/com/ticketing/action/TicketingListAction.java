package com.ticketing.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;
import com.ticketing.db.TicketDTO;

public class TicketingListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("TicketingListAction execute()---------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		TicketDAO tdao = new TicketDAOImpl();
		List<TicketDTO> bookList = null;
		
		if (id.equals("admin")) {
			bookList = tdao.getTicketingList();
		} else {
			bookList = tdao.getMyBookList(id);
		}
		
		request.setAttribute("bookList", bookList);
		
		forward.setPath("./ticketing/ticketingList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
