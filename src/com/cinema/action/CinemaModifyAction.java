package com.cinema.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CinemaModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CinemaModifyAction execute()-----------------------------------------------------");
		
		//한글 처리
		request.setCharacterEncoding("UTF-8");
		
		//관리자 처리
		HttpSession session = request.getSession();
		
		int cinema_num = Integer.parseInt(request.getParameter("cinema_num"));
		
		//상영관 번호에 따른 좌석번호,시작시간,끝시간,시작날짜,끝날짜 분배
				// ','로 구분    좌석번호는 사이에 '-' 포함
				String room = request.getParameter("room");
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
				/*for(int i=1;i<=room_num;i++){
					if(i==room_num){// 마지막에 들어가는 데이터에 나누는','를 넣지 않음
						seat += request.getParameter("seat_line"+i)+" "+request.getParameter("seat_row"+i);
						start_times += request.getParameter("start_times"+i);
						end_times += request.getParameter("end_times"+i);
						start_priod += request.getParameter("end_priod"+i);
						end_priod += request.getParameter("end_priod"+i);
						movie_num += request.getParameter("movie"+i);
					}else{// 데이터를 나누는 ','를 입력
						seat += request.getParameter("seat_line"+i)+" "+request.getParameter("seat_row"+i)+",";
						start_times += request.getParameter("start_times"+i)+",";
						end_times += request.getParameter("end_times"+i)+",";
						start_priod += request.getParameter("end_priod"+i)+",";
						end_priod += request.getParameter("end_priod"+i)+",";
						movie_num += request.getParameter("movie"+i)+",";
					}
				}*/
				for(int i=1;i<=room_num;i++){
					
						System.out.println("동작");
					seat += request.getParameter("seat_line"+i)+" "+request.getParameter("seat_row"+i)+",";
					start_times += request.getParameter("start_times"+i)+",";
					end_times += request.getParameter("end_times"+i)+",";
					start_priod += request.getParameter("end_priod"+i)+",";
					end_priod += request.getParameter("end_priod"+i)+",";
					movie_num += request.getParameter("movie"+i)+",";
					
				
				}
		
				
				// 마지막에 붙는 ','제거
				seat = seat.substring(0, seat.length()-1);
				start_times = start_times.substring(0,start_times.length()-1);
				end_times = end_times.substring(0,end_times.length()-1);
				start_priod = start_priod.substring(0,start_priod.length()-1);
				end_priod = end_priod.substring(0,end_priod.length()-1);
				movie_num = movie_num.substring(0,movie_num.length()-1);
				
		
		// CineDTO 객체 생성 >> 정보 저장(form 태그에서 넘겨 받은 데이터를 저장)
		CineDTO cdto = new CineDTO();
		
		//지역 분류
		//1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구
		//6-경남/부산/울산, 7-강원, 8-제주
		int regionCode = Integer.parseInt(request.getParameter("region"));
		String region = "";
		if(regionCode==2){region="경기/인천";}
		else if(regionCode==3){region="충청/대전";}
		else if(regionCode==4){region="전라/광주";}
		else if(regionCode==5){region="경북/대구";}
		else if(regionCode==6){region="경남/부산/울산";}
		else if(regionCode==7){region="강원";}
		else if(regionCode==8){region="제주";}
		else{region="서울";}
		
		cdto.setCinema_num(cinema_num);
		cdto.setRegion_num(regionCode);
		cdto.setRegion(region);
		cdto.setName(request.getParameter("name"));
		cdto.setRoom(room);
		cdto.setSeat(seat);
		cdto.setAddr(request.getParameter("addr"));
		cdto.setTel(request.getParameter("tel"));
		cdto.setStart_times(start_times);
		cdto.setEnd_times(end_times);
		cdto.setStart_priod(start_priod);
		cdto.setEnd_priod(end_priod);
		cdto.setMovie_num(movie_num);
		
		// CineDAO 객체 생성
		// updateCinema(DTO)
		CineDAO cdao = new CineDAOImpl();
		cdao.updateCinema(cdto);
		
		// 페이지 이동(./CinemaDetail.ci)
		ActionForward forward = new ActionForward();
		forward.setPath("./CinemaAdminDetail.ci");
		forward.setRedirect(true);

		return forward;
	}
	
}
