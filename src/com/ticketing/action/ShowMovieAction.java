package com.ticketing.action;

import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;
import com.ticketing.db.TicketDTO;

public class ShowMovieAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//ajax에서 전달 받은 값
		String cinema=request.getParameter("cinema");
		String movie=request.getParameter("movie");
		String date=request.getParameter("date");
		System.out.println("jsp에서 받은 값 : " + cinema + ", " + movie + ", " + date);
		
		// 선택된 날짜
		Calendar todayCal = Calendar.getInstance();
		Calendar endCal = Calendar.getInstance();
		Calendar startCal = Calendar.getInstance();
		Calendar currentTime=Calendar.getInstance();//오늘 시간
		String currentH="";
		String currentM="";
				
		if(currentTime.get(Calendar.HOUR_OF_DAY)<10)currentH="0"+currentTime.get(Calendar.HOUR_OF_DAY);
		else currentH+=currentTime.get(Calendar.HOUR_OF_DAY);
		if(currentTime.get(Calendar.MINUTE)<10)currentM="0"+currentTime.get(Calendar.MINUTE);
		else currentM+=currentTime.get(Calendar.MINUTE);
		currentH=currentH+":"+currentM;
		
		// 영화관DB 정보 다 가져오기
		TicketDAO tdao = new TicketDAOImpl();
		

		// 영화DB 정보 다 가져오기
		List<MovieDTO> bookRatingList = tdao.bookRatingList();// 예매순
		List<MovieDTO> totalRatingList = tdao.totalRatingList();// 평점순
		
		int[] movieArray=new int[bookRatingList.size()];
		for(int i=0; i<bookRatingList.size(); i++)
			movieArray[i]=bookRatingList.get(i).getMovie_num();
		
		// 오늘 날짜부터 cdto.getEnd_priod()
		todayCal.set(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]) - 1,
				Integer.parseInt(date.split("-")[2]));
		//System.out.println("선택 날짜 : " + sdf.format(todayCal.getTime()));
		
		JSONArray cineList=new JSONArray(); //하나의 상영관의 정보
		int[] runningMovie={0};
		if(cinema!=""){ //선택한 영화관이 있으면
			CineDTO cdto = tdao.getSelectList(cinema);
			runningMovie=new int[Integer.parseInt(cdto.getRoom())];
			// 영화관의 상영개수만큼
			for (int i = 0; i < Integer.parseInt(cdto.getRoom()); i++) {
				String[] seat=new String[Integer.parseInt(cdto.getRoom())];
	
				String endDate = cdto.getEnd_priod().split(",")[i];
				String startDate = cdto.getStart_priod().split(",")[i];
				// 각 상영관의 영화 시작일
				startCal.set(Integer.parseInt(startDate.split("-")[0]), Integer.parseInt(startDate.split("-")[1]) - 1,
						Integer.parseInt(startDate.split("-")[2]));
	
				// 각 상영관의 영화 마감일
				endCal.set(Integer.parseInt(endDate.split("-")[0]), Integer.parseInt(endDate.split("-")[1]) - 1,
						Integer.parseInt(endDate.split("-")[2]));

				JSONObject jsonObj=new JSONObject();
				  
				//상영관의 영화 정보
				MovieDTO movieList
					=tdao.getMovie(Integer.parseInt(cdto.getMovie_num().split(",")[i]));

				if(todayCal.compareTo(startCal)!=-1
				  &&todayCal.compareTo(endCal)!=1 && movie==""){//오늘 날짜의 영화관의 모든 정보를 저장 CineDTO(영화관 선택시)

					runningMovie[i]=movieList.getMovie_num();

				}else if(todayCal.compareTo(startCal)!=-1//오늘 날짜의 영화관의 선택된 영화 정보를 저장 CineDTO(영화 선택시)
						  &&todayCal.compareTo(endCal)!=1 && movie.equals(movieList.getTitle()) ){
					System.out.println("선택된 영화 있음");
					String[] tStart=cdto.getStart_times().split(",");
					String[] tEnd=cdto.getEnd_times().split(",");
					jsonObj.put("cinema_num",cdto.getCinema_num());
					jsonObj.put("region",cdto.getRegion());
					jsonObj.put("name",cdto.getName());
					jsonObj.put("room",cdto.getRoom());
					//book DB의 자리수 빼기
					jsonObj.put("allSeat", Integer.parseInt(seat[i].split(" ")[0])
						 *Integer.parseInt(seat[i].split(" ")[1]));
					jsonObj.put("movie_name", movieList.getTitle());
					jsonObj.put("movie_num", movieList.getMovie_num());
					jsonObj.put("movie_grade", movieList.getGrade());
				
					cineList.add(jsonObj);
				}
			}
		}/*else{//선택한 영화관이 없으면
			
		}*/
		//movieArray, runningMovie
		/*for(int i=0; i<movieArray.length; i++)
			System.out.println(movieArray[i]);
		*/
		for(int i=0; i<runningMovie.length; i++)
			System.out.print(runningMovie[i]+"  ");
		
		HashSet<Integer> map = new HashSet<Integer>();
		for(int i:movieArray){
			map.add(i);
		}
		for(int i:runningMovie){
			if(map.contains(i)){
				map.remove(i);
			}
		}
		JSONObject jsonObj=new JSONObject();
		jsonObj.put("movieList", map);
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.write(jsonObj.toJSONString());
		return null;
	}

}
