package com.cinema.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;

public class CinemaDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CinemaDeleteAction execute()-----------------------------------------------------");
		
		//한글 처리
		request.setCharacterEncoding("UTF-8");
		
		//관리자 처리
		HttpSession session = request.getSession();
		
		//삭제 적용 코드 받기 
		// 0 - 전체 삭제
		// 1 - 상영관 삭제
		int check_del = Integer.parseInt(request.getParameter("check_del"));
		//영화관 번호 가져오기
		int cinema_num = Integer.parseInt(request.getParameter("cinema_num"));
		
		
		System.out.println("상영관 삭제 적용 코드 : "+check_del);
		
		ActionForward forward = new ActionForward();
		
		// 상영관 삭제
		if(check_del==1){
			
			//상영관 번호에 따른 좌석번호,시작시간,끝시간,시작날짜,끝날짜 분배
			// ','로 구분    좌석번호는 사이에 '-' 포함
			String room = request.getParameter("before_room");
			String change_room = request.getParameter("room");
			System.out.println("room : "+change_room);
			int room_num = Integer.parseInt(room);
			String seat = "";
			String start_times = "";
			String end_times = "";
			String start_priod = "";
			String end_priod = "";
			
			// 영화번호는 영화번호가지고올것
			//영화 번호 가져오기
				//MovieDAO moviedao = new MovieDAOImpl();
				//moviedao.번호가져올 매서드 사용
				//
			String movie_num = ""; 
			
			//관 마다 들어가는 영화,시작끝시간,시작끝기간,좌석 을 넣는 for문
			for(int i=1;i<=room_num;i++){
					if(request.getParameter("movie"+i)==null){ // 없어진 관의 데이터를 넘기고 저장
						System.out.println("체크");
						continue;
					}
					else{
						System.out.println("동작");
					seat += request.getParameter("seat_line"+i)+" "+request.getParameter("seat_row"+i)+",";
					start_times += request.getParameter("start_times"+i)+",";
					end_times += request.getParameter("end_times"+i)+",";
					start_priod += request.getParameter("start_priod"+i)+",";
					end_priod += request.getParameter("end_priod"+i)+",";
					movie_num += request.getParameter("movie"+i)+",";
					}
				
			}
			
			int regionCode = 0;					
			String region = request.getParameter("region");
			if(region.equals("경기/인천")){regionCode=2; }
			else if(region.equals("충청/대전")){regionCode=3;}
			else if(region.equals("전라/광주")){regionCode=4;}
			else if(region.equals("경북/대구")){regionCode=5;}
			else if(region.equals("경남/부산/울산")){regionCode=6;}
			else if(region.equals("강원")){regionCode=7;}
			else if(region.equals("제주")){regionCode=8;}
			else{regionCode=1;}
			
			//System.out.println(seat);	
				
			// 마지막에 붙는 ','제거
			seat = seat.substring(0, seat.length()-1);
			start_times = start_times.substring(0,start_times.length()-1);
			end_times = end_times.substring(0,end_times.length()-1);
			start_priod = start_priod.substring(0,start_priod.length()-1);
			end_priod = end_priod.substring(0,end_priod.length()-1);
			movie_num = movie_num.substring(0,movie_num.length()-1);
				
			
			// CineDTO 객체 생성 >> 정보 저장(form 태그에서 넘겨 받은 데이터를 저장)
			CineDTO cdto = new CineDTO();
			
			cdto.setCinema_num(cinema_num);
			cdto.setRegion_num(regionCode);
			cdto.setRegion(region);
			cdto.setName(request.getParameter("name"));
			cdto.setRoom(change_room);
			cdto.setSeat(seat);
			cdto.setAddr(request.getParameter("addr"));
			cdto.setTel(request.getParameter("tel"));
			cdto.setStart_times(start_times);
			cdto.setEnd_times(end_times);
			cdto.setStart_priod(start_priod);
			cdto.setEnd_priod(end_priod);
			cdto.setMovie_num(movie_num);
			
			System.out.println(cdto.toString());
			
			// CineDAO 객체 생성
			// updateCinema(DTO)
			CineDAO cdao = new CineDAOImpl();
			cdao.updateCinema(cdto);
			
			
			// 페이지 이동(./CinemaDetail.ci)
			
			forward.setPath("./CinemaAdminDetail.ci");
			forward.setRedirect(true);
			
			//return forward
		}//상영관 삭제
		//지점 전체 삭제
		else if(check_del==0){
		
		
			
		// CineDAO 객체 생성
		CineDAO cdao = new CineDAOImpl();
		// deleteCinema() 영화관 삭제 매서드
		cdao.deleteCinema(cinema_num);
		
		
		// 페이지 이동(./CinemaDetail.ci)
		
		forward.setPath("./CinemaAdminDetail.ci");
		forward.setRedirect(true);	
		
		//return forward;
		
		}//지점 전체 삭제
		
		
		
		return forward;
	}
	
}
