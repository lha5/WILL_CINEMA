package com.ticketing.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;

public class ShowTimeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//ajax에서 전달 받은 값
		String cinema=request.getParameter("cinema");
		String movie=request.getParameter("movie");
		String date=request.getParameter("date");
		System.out.println(cinema + ", " + movie + ", " + date);

		// 선택된 날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar todayCal = Calendar.getInstance();
		Calendar endCal = Calendar.getInstance();
		Calendar startCal = Calendar.getInstance();

		// 영화관DB 정보 다 가져오기
		TicketDAO tdao = new TicketDAOImpl();
		CineDTO cdto = tdao.getSelectList(cinema);
		// List<CineDTO> todayCine = new ArrayList<CineDTO>(); //ajax

		// 영화DB 정보 다 가져오기
		List<MovieDTO> bookRatingList = tdao.bookRatingList();// 예매순
		List<MovieDTO> totalRatingList = tdao.totalRatingList();// 평점순

		/*-----영화관 각 상영관의 모든 영화 상영 날짜 리스트----------*/
		HashSet<String> allDate = new HashSet<>();

		// 오늘 날짜부터 cdto.getEnd_priod()
		todayCal.set(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]) - 1,
				Integer.parseInt(date.split("-")[2]));
		System.out.println("선택 날짜 : " + sdf.format(todayCal.getTime()));
		
		// 영화관의 상영개수만큼
		for (int i = 0; i < Integer.parseInt(cdto.getRoom()); i++) {
			String endDate = cdto.getEnd_priod().split(",")[i];
			String startDate = cdto.getStart_priod().split(",")[i];
			// 각 상영관의 영화 시작일
			startCal.set(Integer.parseInt(startDate.split("-")[0]), Integer.parseInt(startDate.split("-")[1]) - 1,
					Integer.parseInt(startDate.split("-")[2]));

			// 각 상영관의 영화 마감일
			endCal.set(Integer.parseInt(endDate.split("-")[0]), Integer.parseInt(endDate.split("-")[1]) - 1,
					Integer.parseInt(endDate.split("-")[2]));
			todayCal = Calendar.getInstance(); // 오늘 날짜

			if(movie==""){//영화 선택 안했을때 상영관의 모든 영화(상영시간) 보여주기
				 System.out.println("없음"); 
				 
			}else{
				  
			}
			  //ajax사용할때 
			if(todayCal.compareTo(startCal)!=-1
			  &&todayCal.compareTo(endCal)!=1){//오늘 날짜의 영화관 정보를 저장 CineDTO
			  CineDTO todaydto = new CineDTO();
			  int seat=Integer.parseInt(cdto.getSeat().split(" ")[0])
					  *Integer.parseInt(cdto.getSeat().split(" ")[1]);
			  todaydto.setCinema_num(cdto.getCinema_num());
			  todaydto.setRegion(cdto.getRegion());
			  todaydto.setName(cdto.getName());
			  todaydto.setRoom(cdto.getRoom());
			  todaydto.setSeat(seat+"");
			  todaydto.setStart_times(cdto.getStart_times());
			  todaydto.setEnd_times(cdto.getEnd_times());
			  todaydto.setStart_priod(cdto.getStart_priod());
			  todaydto.setEnd_priod(cdto.getEnd_priod());
			  //todaydto.setMovie_num(cdto.getString("movie_num"));
			  //cineList.add(cdto); 
			} 
		}

		JSONObject jsonObj = new JSONObject();

		
		 
		 

		jsonObj.put("ajaxm", movie);
		jsonObj.put("ajaxc", cinema);
		jsonObj.put("ajaxd", date);
		
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.write(jsonObj.toJSONString());
		return null;
	}

}
