package com.ticketing.action;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDTO;
import com.cinema.db.CineDTO;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;

public class TicketOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("seat-ticketing.jsp -> TicketOrderAction execute()------------------------------------");
		
		//세션처리
		request.setCharacterEncoding("UTF-8");
		
		// 세션값 체크
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		System.out.println("현제 세션 아이디 값 : " + id);
		
		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 회원 상세
		MemberDAO memdao = new MemberDAOImpl();
				
		// 현재 사용자의 내용만 가져옴
		MemberDTO memdto = memdao.getMember(id); 
		
		//실제 가격
		int payment = Integer.parseInt(request.getParameter("payment"));
		//10,000 형식 가격
		String price=(String)request.getParameter("price");
		String person_num=(String)request.getParameter("person_num");//인원수
		//영화 번호
		int movie_num=Integer.parseInt(request.getParameter("movie_num"));
		//상영일, 상영시간
		String running_date=(String)request.getParameter("running_date").substring(0, 10);//상영일
		String running_time=(String)request.getParameter("running_time");	
	    String week=(String)request.getParameter("running_date").substring(11, 12);//요일
	    int cinema_num=Integer.parseInt(request.getParameter("cinema_num"));//영화관 번호
	    
		//상영관번호
		String roomNum=(String)request.getParameter("roomNum");
		String seat=(String)request.getParameter("seat");
		
		System.out.println(movie_num+" "+roomNum+
				+cinema_num+" "+running_date+" "+running_time+" "+week+" "+price+" "+payment);
		
		TicketDAO tdao = new TicketDAOImpl();
		AdminMovieDTO mdto = tdao.getMovie(movie_num);
		CineDTO cdto=tdao.getSelectList(cinema_num);
		
		request.setAttribute("memdto", memdto);//회원정보
		request.setAttribute("person_num", person_num);
		request.setAttribute("mdto", mdto);
		request.setAttribute("roomNum", roomNum);
		request.setAttribute("cdto", cdto);
		request.setAttribute("running_date", running_date);
		request.setAttribute("running_time", running_time);
		request.setAttribute("week", week);
		request.setAttribute("price", price);
		request.setAttribute("payment", payment);
		request.setAttribute("seat", seat);
		
		// 페이지 이동
		forward.setPath("./ticketing/ticketOrder.jsp");
		forward.setRedirect(false);
				
		return forward;
	}
}
