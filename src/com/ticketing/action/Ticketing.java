package com.ticketing.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.movie.db.AdminMovieDTO;
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
		Calendar todayCal=null;
		Calendar endCal = Calendar.getInstance();
		Calendar startCal = Calendar.getInstance();
		
		//영화관DB 정보 다 가져오기
		TicketDAO tdao=new TicketDAOImpl();
		List<CineDTO> cineList = tdao.getCinemaList();
		//List<CineDTO> todayCine = new ArrayList<CineDTO>(); //ajax
		
		//영화DB 정보 다 가져오기
		List<AdminMovieDTO> bookRatingList=tdao.bookRatingList();//예매순
		List<AdminMovieDTO> totalRatingList=tdao.totalRatingList();//평점순
		
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
				
				while(todayCal.compareTo(startCal)!=-1
						&&todayCal.compareTo(endCal)!=1){//상영관의 영화 종료일이 오늘날짜와 같거나 클때
					//오늘부터 종료일까지 날짜를 저장
					allDate.add(sdf.format(todayCal.getTime()));
					todayCal.add(Calendar.DATE, 1);
				}
				//System.out.println("=========================");
			}
		}

		//전체 지역 리스트
		List allRegion=new ArrayList<>();		
		List arr=new ArrayList();
		arr.add("1"); arr.add("서울");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("2"); arr.add("경기/인천");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("3"); arr.add("충청/대전");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("4"); arr.add("전라/광주");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("5"); arr.add("경북/대구");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("6"); arr.add("경남/부산/울산");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("7"); arr.add("강원");
		allRegion.add(arr);
		arr=new ArrayList();
		arr.add("8"); arr.add("제주");
		allRegion.add(arr);
		
		/*HashSet regionList= new HashSet();
		for(int i=0; i<cineList.size(); i++){
			allRegion = new ArrayList();
			CineDTO cdto=cineList.get(i);
			allRegion.add(cdto.getCinema_num());
			allRegion.add(cdto.getRegion());
			regionList.add(allRegion);
		}
		allRegion = new ArrayList(regionList);
		
		Comparator<List> com = new Comparator<List>() {
			@Override
			public int compare(List o1, List o2) {
				
				return o1.toString().compareTo(o2.toString());
			}
		};
		Collections.sort(allRegion,com);
*/

		System.out.println(allRegion.get(0).toString());
		//영화관 상영 날짜순 정렬
		List<String> allDay = new ArrayList(allDate);
		Collections.sort(allDay);
		int[] cineCnt=new int[allRegion.size()];
	    for(int i=0; i<allRegion.size(); i++){ 
	    	int cnt=0;
	    	//지역번호
	    	String temp=allRegion.get(i).toString().split(",")[0];
	    	temp=temp.substring(1);
	    	int num=Integer.parseInt(temp);
	    	//지역명
	    	temp=allRegion.get(i).toString().split(",")[1];
	    	temp=temp.split("]")[0];
	    	String name=temp.substring(1);
	    	for(int j=0; j<cineList.size(); j++){
	    	CineDTO cdto=cineList.get(j);
	    		if(cdto.getRegion().equals(name)){
	    			cnt++;
	    		}
	    	}
	    	   cineCnt[i]=cnt;
	     }
		//view 페이지로 값 전달
		request.setAttribute("cineList", cineList);
		request.setAttribute("bookRatingList", bookRatingList);
		request.setAttribute("totalRatingList", totalRatingList);
		request.setAttribute("allRegion", allRegion);//전체 지역
		request.setAttribute("cineCnt", cineCnt);
		request.setAttribute("allDay", allDay);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./ticketing/ticketing.jsp");
		forward.setRedirect(false);
		return forward;
		
		
	}
}
