package com.ticketing.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
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

public class ShowTimeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//ajax에서 전달 받은 값
		String cinema=request.getParameter("cinema");
		String movie=request.getParameter("movie");
		String date=request.getParameter("date");
		System.out.println("jsp에서 받은 값 : " + cinema + ", " + movie + ", " + date);
		
		// 선택된 날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar todayCal = Calendar.getInstance();
		Calendar endCal = Calendar.getInstance();
		Calendar startCal = Calendar.getInstance();

		// 영화관DB 정보 다 가져오기
		TicketDAO tdao = new TicketDAOImpl();
		

		// 영화DB 정보 다 가져오기
		List<MovieDTO> bookRatingList = tdao.bookRatingList();// 예매순
		List<MovieDTO> totalRatingList = tdao.totalRatingList();// 평점순
		
		//예매DB 정보 다 가져오기
		List<TicketDTO> ticketList=tdao.getTicketList(date);
		
		// 오늘 날짜부터 cdto.getEnd_priod()
		todayCal.set(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]) - 1,
				Integer.parseInt(date.split("-")[2]));
		//System.out.println("선택 날짜 : " + sdf.format(todayCal.getTime()));
		
		JSONArray cineList=new JSONArray(); //하나의 상영관의 정보
		if(cinema!=""){ //선택한 영화관이 있으면
			CineDTO cdto = tdao.getSelectList(cinema);
			// 영화관의 상영개수만큼
			for (int i = 0; i < Integer.parseInt(cdto.getRoom()); i++) {
				String[] seat=new String[Integer.parseInt(cdto.getRoom())];
				seat=cdto.getSeat().split(",");
	
				String endDate = cdto.getEnd_priod().split(",")[i];
				String startDate = cdto.getStart_priod().split(",")[i];
				// 각 상영관의 영화 시작일
				startCal.set(Integer.parseInt(startDate.split("-")[0]), Integer.parseInt(startDate.split("-")[1]) - 1,
						Integer.parseInt(startDate.split("-")[2]));
	
				// 각 상영관의 영화 마감일
				endCal.set(Integer.parseInt(endDate.split("-")[0]), Integer.parseInt(endDate.split("-")[1]) - 1,
						Integer.parseInt(endDate.split("-")[2]));
				//todayCal = Calendar.getInstance(); // 오늘 날짜
				 //System.out.println(Integer.parseInt(cdto.getSeat().split(" ")[1]));
				if(movie==""){//영화 선택 안했을때 상영관의 모든 영화(상영시간) 보여주기
					 System.out.println("없음"); 
					 
				}else{
					  
				}
				
				CineDTO todaydto = new CineDTO();
				JSONObject jsonObj=new JSONObject();
				  
				//상영관의 영화 정보
				MovieDTO movieList
					=tdao.getMovie(Integer.parseInt(cdto.getMovie_num().split(",")[i]));
				
				  //ajax사용할때 
				if(todayCal.compareTo(startCal)!=-1
				  &&todayCal.compareTo(endCal)!=1 && movie==""){//오늘 날짜의 영화관의 모든 정보를 저장 CineDTO
				 
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
				  //todaydto.setMovie_num(cdto.getString("movie_num"));
				  //cineList.add(cdto); 
				  
				  //한 상영관의 하루 런타임
				  //runtimeList
				  
				  //영화의 런타임
				  int mTime=movieList.getRunning_time();
				  //상영관의 하루 시작시간
				  int sTime=Integer.parseInt(tStart[i].split(":")[0])*60
						  +Integer.parseInt(tStart[i].split(":")[1]);
				  //상영관의 하루 마감시간
				  int eTime=Integer.parseInt(tEnd[i].split(":")[0])*60
						  +Integer.parseInt(tEnd[i].split(":")[1]);
				  int rtime=sTime;
				  JSONArray runtimeS=new JSONArray();
				  JSONArray runtimeE=new JSONArray();
				  JSONArray saleTime=new JSONArray();
					while(rtime<=eTime){
						int[] stime=new int[2];
						int[] etime=new int[2];
						stime[0]=rtime/60;
						stime[1]=rtime%60;
						if(stime[0]<10 && stime[1]<10) runtimeS.add("0"+stime[0]+":0"+stime[1]);
						else if(stime[0]>=10 && stime[1]<10) runtimeS.add(stime[0]+":0"+stime[1]);
						else if(stime[0]<10 && stime[1]>=10) runtimeS.add("0"+stime[0]+":"+stime[1]);
						else runtimeS.add(stime[0]+":"+stime[1]);
						
						
						if(stime[0]<=9 || (stime[0]==10 && stime[1]==0) ) saleTime.add("조조");
						else if(stime[0]>=24) saleTime.add("심야");
						else saleTime.add("");
						rtime=rtime+mTime+10;//광고시간 10분
						
						etime[0]=rtime/60;
						etime[1]=rtime%60;
						if(etime[1]<10) runtimeE.add(etime[0]+":0"+etime[1]);
						else runtimeE.add(etime[0]+":"+etime[1]);
						rtime=(int) (Math.ceil(rtime/10)*10)+10;//다음 상영시작시간 10분차
					}
					
					//사용된 좌석 0으로 초기화
					int[] sSeat=new int[runtimeS.size()];
					for(int k=0; k<runtimeS.size();k++){ sSeat[k]=0;}
					//선택 날짜의 상영일이 같은 book정보 
					if(ticketList.size()!=0){
						for(int j=0; j<ticketList.size(); j++){//선택한 날짜에 예매 정보
							TicketDTO tdto=ticketList.get(j);
							JSONArray selectSeat=new JSONArray();
							//book DB 예매영화와 상영 영화 일치하는지 && 상영관 일치
						if(tdto.getMovie_num()==Integer.parseInt(cdto.getMovie_num().split(",")[i]) &&
							tdto.getCinema_num()==cdto.getCinema_num()){
							for(int z=0; z<runtimeS.size(); z++){
								//예매 정보의 상영시간일치
								if(tdto.getRunnging_time().equals(runtimeS.get(z)+"~"+runtimeE.get(z))){
									sSeat[z]+=tdto.getSeat().split(",").length;
									selectSeat.add(sSeat[z]); //있으면 자리 개수저장
								}else{//없으면 상영관 자리 개수 0개 예매
									sSeat[z]+=0;
									selectSeat.add(sSeat[z]);
								}
							}
						}else{//예매된 상영관이 없을때 0으로 초기화
							//System.out.println(movieList.getTitle());
							for(int z=0; z<runtimeS.size(); z++){
								selectSeat.add(sSeat[z]);
							}
						}
						jsonObj.put("selectSeat", selectSeat);
					}
				}else{//예매된 상영관이 없을때 0으로 초기화
					JSONArray selectSeat=new JSONArray();
					for(int z=0; z<runtimeS.size(); z++){
						selectSeat.add(sSeat[z]);
					}
					jsonObj.put("selectSeat", selectSeat);
				}
					
				jsonObj.put("runtimeS", runtimeS);
				jsonObj.put("runtimeE", runtimeE);
				jsonObj.put("saleTime", saleTime);
				cineList.add(jsonObj);
				}else if(todayCal.compareTo(startCal)!=-1//오늘 날짜의 영화관의 선택된 영화 정보를 저장 CineDTO
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
					  //todaydto.setMovie_num(cdto.getString("movie_num"));
					  //cineList.add(cdto); 
					  
					  //한 상영관의 하루 런타임
					  //runtimeList
					  
					  //영화의 런타임
					  int mTime=movieList.getRunning_time();
					  //상영관의 하루 시작시간
					  int sTime=Integer.parseInt(tStart[i].split(":")[0])*60
							  +Integer.parseInt(tStart[i].split(":")[1]);
					  //상영관의 하루 마감시간
					  int eTime=Integer.parseInt(tEnd[i].split(":")[0])*60
							  +Integer.parseInt(tEnd[i].split(":")[1]);
					  int rtime=sTime;
					  JSONArray runtimeS=new JSONArray();
					  JSONArray runtimeE=new JSONArray();
					  JSONArray saleTime=new JSONArray();
						while(rtime<=eTime){
							int[] stime=new int[2];
							int[] etime=new int[2];
							stime[0]=rtime/60;
							stime[1]=rtime%60;
							if(stime[0]<10 && stime[1]<10) runtimeS.add("0"+stime[0]+":0"+stime[1]);
							else if(stime[0]>=10 && stime[1]<10) runtimeS.add(stime[0]+":0"+stime[1]);
							else if(stime[0]<10 && stime[1]>=10) runtimeS.add("0"+stime[0]+":"+stime[1]);
							else runtimeS.add(stime[0]+":"+stime[1]);
							
							
							if(stime[0]<=9 || (stime[0]==10 && stime[1]==0) ) saleTime.add("조조");
							else if(stime[0]>=24) saleTime.add("심야");
							else saleTime.add("");
							rtime=rtime+mTime+10;//광고시간 10분
							
							etime[0]=rtime/60;
							etime[1]=rtime%60;
							if(etime[1]<10) runtimeE.add(etime[0]+":0"+etime[1]);
							else runtimeE.add(etime[0]+":"+etime[1]);
							rtime=(int) (Math.ceil(rtime/10)*10)+10;//다음 상영시작시간 10분차
						}
						
						//사용된 좌석 0으로 초기화
						int[] sSeat=new int[runtimeS.size()];
						for(int k=0; k<runtimeS.size();k++){ sSeat[k]=0;}
						//선택 날짜의 상영일이 같은 book정보 
						if(ticketList.size()!=0){
							for(int j=0; j<ticketList.size(); j++){//선택한 날짜에 예매 정보
								TicketDTO tdto=ticketList.get(j);
								JSONArray selectSeat=new JSONArray();
								//book DB 예매영화와 상영 영화 일치하는지 && 상영관 일치
							if(tdto.getMovie_num()==Integer.parseInt(cdto.getMovie_num().split(",")[i]) &&
								tdto.getCinema_num()==cdto.getCinema_num()){
								for(int z=0; z<runtimeS.size(); z++){
									//예매 정보의 상영시간일치
									if(tdto.getRunnging_time().equals(runtimeS.get(z)+"~"+runtimeE.get(z))){
										sSeat[z]+=tdto.getSeat().split(",").length;
										selectSeat.add(sSeat[z]); //있으면 자리 개수저장
									}else{//없으면 상영관 자리 개수 0개 예매
										sSeat[z]+=0;
										selectSeat.add(sSeat[z]);
									}
								}
							}else{//예매된 상영관이 없을때 0으로 초기화
								//System.out.println(movieList.getTitle());
								for(int z=0; z<runtimeS.size(); z++){
									selectSeat.add(sSeat[z]);
								}
							}
							jsonObj.put("selectSeat", selectSeat);
						}
					}else{//예매된 상영관이 없을때 0으로 초기화
						JSONArray selectSeat=new JSONArray();
						for(int z=0; z<runtimeS.size(); z++){
							selectSeat.add(sSeat[z]);
						}
						jsonObj.put("selectSeat", selectSeat);
					}
						
					jsonObj.put("runtimeS", runtimeS);
					jsonObj.put("runtimeE", runtimeE);
					jsonObj.put("saleTime", saleTime);
					cineList.add(jsonObj);
				}
			}
		}/*else{//선택한 영화관이 없으면
			
		}*/
		
		//영화관 좌석수 book DB에서 가져오기 

		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.write(cineList.toJSONString());
		return null;
	}

}
