package com.ticketing.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;

public class Ticketing implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("---------------------- Ticketing() 예매 페이지  ---------------------");
		//오늘 날짜
		Date now = new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String today=sdf.format(now);
		Calendar todayCal=null;
		Calendar endCal = Calendar.getInstance();
		Calendar startCal = Calendar.getInstance();
		
		//영화관DB 정보 다 가져오기
		TicketDAO tdao=new TicketDAOImpl();
		List<CineDTO> cineList = tdao.getCinemaList();
		//List<CineDTO> todayCine = new ArrayList<CineDTO>(); //ajax
		
		//영화DB 정보 다 가져오기
		List<MovieDTO> movieList=tdao.getMovieList();
		
		/*-----영화관 각 상영관의 모든 영화 상영 날짜 리스트----------*/
		HashSet<String> allDate= new HashSet<>();
		
		for(int i =0; i<cineList.size(); i++){
			CineDTO cdto=cineList.get(i);
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
				
				/*
				   //ajax사용할때
				 * if(todayCal.compareTo(startCal)!=-1
						&&todayCal.compareTo(endCal)!=1){//오늘 날짜의 영화관 정보를 저장
					CineDTO todaydto = new CineDTO();
					
					todaydto.setCinema_num(cdto.getCinema_num());
					todaydto.setRegion(cdto.getRegion().sp);
					todaydto.setName(rs.getString("name"));
					todaydto.setRoom(rs.getString("room"));
					todaydto.setSeat(rs.getString("seat"));
					todaydto.setAddr(rs.getString("addr"));
					todaydto.setTel(rs.getString("tel"));
					todaydto.setStart_times(rs.getString("start_times"));
					todaydto.setEnd_times(rs.getString("end_times"));
					todaydto.setStart_priod(rs.getString("start_priod"));
					todaydto.setEnd_priod(rs.getString("end_priod"));
					todaydto.setMovie_num(rs.getString("movie_num"));
					
					cineList.add(cdto);
				}
				*/
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

		//오늘 날짜에 상영정보가 있는 상영관 리스트
		
		//영화관 상영 날짜순 정렬
		List<String> allDay = new ArrayList<>(allDate);
		Collections.sort(allDay);

		//view 페이지로 값 전달
		request.setAttribute("cineList", cineList);
		request.setAttribute("movieList", movieList);
		request.setAttribute("allDay", allDay);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./ticketing/ticketing.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
