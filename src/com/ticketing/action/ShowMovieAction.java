package com.ticketing.action;

import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.admin.movie.db.AdminMovieDTO;
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
		List<AdminMovieDTO> bookRatingList = tdao.bookRatingList();// 예매순
		List<AdminMovieDTO> totalRatingList = tdao.totalRatingList();// 평점순
		
		int[] movieArray=new int[bookRatingList.size()];
		for(int i=0; i<bookRatingList.size(); i++)
			movieArray[i]=bookRatingList.get(i).getMovie_num();
		
		// 오늘 날짜부터 cdto.getEnd_priod()
		todayCal.set(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]) - 1,
				Integer.parseInt(date.split("-")[2]));
		//System.out.println("선택 날짜 : " + sdf.format(todayCal.getTime()));
		
		JSONArray cineList=new JSONArray(); //하나의 상영관의 정보
		int[] runningMovie=null;
		//선택된 영화가 있는 영화관
		List<Integer> curRegion=null;
		List<CineDTO> allCineList=tdao.getCinemaList();
		if(cinema!=""){ //선택한 영화관이 있으면
			System.out.println("1--------");
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
				  
				//상영관의 영화 정보
				AdminMovieDTO movieList
					=tdao.getMovie(Integer.parseInt(cdto.getMovie_num().split(",")[i]));

				if(todayCal.compareTo(startCal)!=-1
				  &&todayCal.compareTo(endCal)!=1/* && movie==""*/){//오늘 날짜의 영화관의 모든 정보를 저장 CineDTO(영화관 선택시)
					runningMovie[i]=movieList.getMovie_num();

				}/*else if(todayCal.compareTo(startCal)!=-1//오늘 날짜의 영화관의 선택된 영화 정보를 저장 CineDTO(영화 선택시)
						  &&todayCal.compareTo(endCal)!=1 && movie.equals(movieList.getTitle()) ){
					System.out.println("선택된 영화 있음");
					String[] tStart=cdto.getStart_times().split(",");
					String[] tEnd=cdto.getEnd_times().split(",");
				}*/
			}
		}else if(cinema=="" && movie!=""){//선택한 영화관이 없으면
			System.out.println("2--------");
			curRegion=new ArrayList<Integer>();
			for (int i = 0; i < allCineList.size(); i++) {
				CineDTO cdto=allCineList.get(i);
				for(int j=0; j<Integer.parseInt(cdto.getRoom()); j++){
					String endDate = cdto.getEnd_priod().split(",")[j];
					String startDate = cdto.getStart_priod().split(",")[j];
					String curMovie="";
					// 각 상영관의 영화 시작일
					startCal.set(Integer.parseInt(startDate.split("-")[0]), Integer.parseInt(startDate.split("-")[1]) - 1,
							Integer.parseInt(startDate.split("-")[2]));
		
					// 각 상영관의 영화 마감일
					endCal.set(Integer.parseInt(endDate.split("-")[0]), Integer.parseInt(endDate.split("-")[1]) - 1,
							Integer.parseInt(endDate.split("-")[2]));
	
					if(todayCal.compareTo(startCal)!=-1
					  &&todayCal.compareTo(endCal)!=1){//오늘 날짜의 영화관의 모든 정보를 저장 CineDTO(영화관 선택시)
						//상영관의 영화 정보
						AdminMovieDTO movieList
							=tdao.getMovie(Integer.parseInt(cdto.getMovie_num().split(",")[j]));
							
						//선택된 영화가 상영되는 영화관이 있으면
						if(movie.equals(movieList.getTitle())){
							curRegion.add(cdto.getCinema_num());
						}
					}
				}
			}
		}
		//movieArray, runningMovie
		/*for(int i=0; i<movieArray.length; i++)
			System.out.println(movieArray[i]);
		*/
		
		JSONObject jsonObj=new JSONObject();
		//전체 영화 리스트에서 상영중인 영화를 제외
		HashSet<Integer> movieList = new HashSet<Integer>();
		if(runningMovie!=null){
			for(int i:movieArray){
				movieList.add(i);
			}
			for(int i:runningMovie){
				if(movieList.contains(i)){
					movieList.remove(i);
				}
			}
		}
		//전체 영화관 리스트에서 선택한 영화를 상영중인 영화관을 제외
		HashSet<Integer> cinemaList = new HashSet<Integer>();
		if(curRegion!=null){
			for(CineDTO i:allCineList){
				cinemaList.add(i.getCinema_num());
			}
			for(int i:curRegion){
				if(cinemaList.contains(i)){
					cinemaList.remove(i);
				}
			}
		}		
		
		jsonObj.put("regionList", cinemaList);
		jsonObj.put("movieList", movieList);
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.write(jsonObj.toJSONString());
		return null;
	}

}
