package com.cinema.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CinemaAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("CinemaAddAction execute()---------------------------------------------------");
		
		//관리자 
		
		
		//상영관 번호에 따른 좌석번호,시작시간,끝시간,시작날짜,끝날짜 분배
		// '|'로 구분    좌석번호는 사이에 '-' 포함
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
		
		for(int i=1;i<=room_num;i++){
			seat += request.getParameter("seat_line"+i)+"-"+request.getParameter("seat_row"+i)+"|";
			start_times += request.getParameter("start_times"+i)+"|";
			end_times += request.getParameter("end_times"+i)+"|";
			start_priod += request.getParameter("end_priod"+i)+"|";
			end_priod += request.getParameter("end_priod"+i)+"|";
			movie_num += request.getParameter("movie"+i)+"|";
		}
		
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
		
		
		
		
		// CineDAO 객체 생성
		// insertCinema(DTO)
		CineDAO cdao = new CineDAOImpl();
		cdao.insertCinema(cdto);

		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./CinemaAdminDetail.ci");
		forward.setRedirect(true);
		
		return forward;
	}

}
