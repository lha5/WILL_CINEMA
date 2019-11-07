package com.cinema.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDAO;
import com.admin.movie.db.AdminMovieDAOImpl;
import com.admin.movie.db.AdminMovieDTO;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDAO;
import com.movie.db.MovieDAOImpl;
import com.movie.db.MovieDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;

public class CinemaUserViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("CinemaUserViewAction 나와용나와용 ");
		int cinema_num=Integer.parseInt(request.getParameter("cinema_num"));
	 
		 // 시네마 정보 가지고 오기 
		CineDAO cdao = new CineDAOImpl();
		CineDTO cineList = cdao.getCinema(cinema_num);
		
		//리스트저장
		System.out.println("지금 확인중"+ cinema_num);
	
		/////////////// 시네마 정보 
		
		AdminMovieDAO amdao  = new AdminMovieDAOImpl();
		int count = amdao.getBoardCount();
		int pageSize = 5;
		System.out.println(" pageNum - 1 : " + request.getParameter("pageNum"));
		
		List<AdminMovieDTO> boardList = null;
		
		MovieDAO mvdao = new MovieDAOImpl();
		if( count != 0 ){ 
			  boardList = mvdao.getBoardList();
		}
		// movie List
		
		
		/*-------------- 달력  --------------*/
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Calendar todayCal=null;
		Calendar endCal = Calendar.getInstance();
		Calendar startCal = Calendar.getInstance();
		
		//영화관DB 정보 다 가져오기
		TicketDAO tdao=new TicketDAOImpl();
		List<CineDTO> cineList2 = tdao.getCinemaList();
		
		/*-----영화관 각 상영관의 모든 영화 상영 날짜 리스트----------*/
		HashSet<String> allDate= new HashSet<>();

		for(int i =0; i<cineList2.size(); i++){
			CineDTO cdto=cineList2.get(i);
			//오늘 날짜부터 cdto.getEnd_priod()
			todayCal = Calendar.getInstance();
			
			//System.out.println(sdf.format(todayCal.getTime()));
			
			//영화관의 상영개수만큼
			for(int j =0; j<Integer.parseInt(cdto.getRoom()); j++){
				String endDate=cdto.getEnd_priod().split(",")[j];
				String startDate=cdto.getStart_priod().split(",")[j];
				//각 상영관의 영화 시작일
				startCal.set(Integer.parseInt(startDate.split("-")[0])
						, Integer.parseInt(startDate.split("-")[1])-1, Integer.parseInt(startDate.split("-")[2]));
				
				//각 상영관의 영화 마감일
				endCal.set(Integer.parseInt(endDate.split("-")[0])
						, Integer.parseInt(endDate.split("-")[1])-1, Integer.parseInt(endDate.split("-")[2]));
				todayCal = Calendar.getInstance(); //오늘 날짜
				
				while(todayCal.compareTo(startCal)!=-1
						&&todayCal.compareTo(endCal)!=1){//상영관의 영화 종료일이 오늘날짜와 같거나 클때
					//오늘부터 종료일까지 날짜를 저장
					allDate.add(sdf.format(todayCal.getTime()));
					todayCal.add(Calendar.DATE, 1);
					
					/*System.out.println(sdf.format(todayCal.getTime()) +", "+
							sdf.format(endCal.getTime()));*/
				}
				//System.out.println("=========================");
			}
		}
		
		
		List<String> allDay = new ArrayList(allDate);
		Collections.sort(allDay);
		/*-------------- 달력  --------------*/
		
		// 정보 저장 
		request.setAttribute("cineList", cineList);
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		
		//전체 영화 상영일
		request.setAttribute("allDay", allDay);
		
		
		//넘기기
		ActionForward forward= new ActionForward();
		forward.setPath("./userCinema/cinemaView.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}
