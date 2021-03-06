package com.ticketing.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDTO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;

public class SeatSelect implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SeatSelect execute()---------------------------------------------------");
		
		//세션 처리
		request.setCharacterEncoding("UTF-8");
		
		//세션값 체크
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		System.out.println("현제 세션 아이디 값 : " + id);
		
		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		//ticketing.jsp에서 전달받은 데이터
		int movie_num=Integer.parseInt(request.getParameter("movie_num")); //영화번호
		
		int cinema_num=Integer.parseInt(request.getParameter("cinema_num"));//영화관 번호
        
        String saleTime=(String)request.getParameter("saleTime"); //할인정보(조조,심야)
		String running_date=(String)request.getParameter("running_date");//상영일
		String running_time=(String)request.getParameter("running_time");//상영시간
		int roomNum=Integer.parseInt(request.getParameter("roomNum"));//관 이름
		String week=request.getParameter("week").substring(11, 12); //요일
		
		
		System.out.println(movie_num+" "+saleTime+" "+roomNum+" "
		+cinema_num+" "+running_date+" "+running_time+" "+week);
		// 시험중이기에 데이터베이스에서 바로 가져옴 
		// 후에 합칠때 예매페이지에서 데이터 받아와야함
		TicketDAO tdao = new TicketDAOImpl();
		AdminMovieDTO mdto = tdao.getMovie(movie_num);
		//영화관,영화번호,상영관,상영일,상영시간
		String seatNum=tdao.getSeatNum(cinema_num,movie_num,roomNum,running_date,running_time);
		List<String> seatRow=new ArrayList<String>();
		List<String> seatCol=new ArrayList<String>();
		if(seatNum==""){
			System.out.println("좌석 번호 없음");
		}else{
			System.out.println("좌석 번호"+seatNum);

			String[] reserSeat=seatNum.split(",");

			for(int i=0; i<reserSeat.length;i++){
				seatRow.add(reserSeat[i].split(" ")[0]);
				seatCol.add(reserSeat[i].split(" ")[1]);
				//System.out.println("좌석 행 :"+seatRow[i]+", 좌석 열 :"+seatCol[i]);
			}
		}
		//영화관 데이터
		//CineDTO cdto = request.getAttribute("cdto");
		
		// 시험중이기에 데이터베이스에서 바로 가져옴 
		// 후에 합칠때 예매페이지에서 데이터 받아와야함
		CineDTO cdto = tdao.getSelectList(cinema_num);
		
		
		//예매 데이터

		//request.getAttribute("");
		
		// 시험중이라 데이터 임의로 넣음 
		// 후에 합칠때 예매페이지에서 데이버 받아와야함
		// 후에 TicketDTO에 저장할 것 
		
		
		
		// 데이터 저장
		// 영화데이터, 영화관데이터, 예매 데이터
		// 가능하면 TicketDTO에 해당 데이터 저장후 이동이 좋음
		request.setAttribute("mdto", mdto);
		request.setAttribute("cdto", cdto);
		request.setAttribute("running_date", running_date);
		request.setAttribute("running_time", running_time);
		request.setAttribute("saleTime", saleTime);
		request.setAttribute("roomNum", roomNum);
		request.setAttribute("seatRow", seatRow);//좌석번호
		request.setAttribute("seatCol", seatCol);
		request.setAttribute("week", week);
		
		// 페이지 이동
		forward.setPath("./ticketing/seat-ticketing.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}
