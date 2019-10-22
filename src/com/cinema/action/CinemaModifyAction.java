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

public class CinemaModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CinemaModifyAction execute()-----------------------------------------------------");
		
		//한글 처리
		request.setCharacterEncoding("UTF-8");
		
		// upload 생성 (영화관 관련 img폴더 생성?)
		// ★ upload 폴더를 생성 후 서버를 clean할 경우 해당 파일이 삭제될 수 있음
		
		// 파일 위치(가상 경로)
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		
		System.out.println("실제 저장 경로 : " + realPath);

		// 파일 크기
		int maxSize = 10 * 1024 * 1024;

		// MultipartRequest 객체 생성
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

		// CineDTO 객체 생성 >> 정보 저장(form 태그에서 넘겨 받은 데이터를 저장)
		CineDTO cdto = new CineDTO();
		
		//지역 분류
		//1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구
		//6-경남/부산/울산, 7-강원, 8-제주
		int regionCode = Integer.parseInt(multi.getParameter("region"));
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
		cdto.setLocation_num(Integer.parseInt(multi.getParameter("location_num")));
		cdto.setName(multi.getParameter("name"));
		cdto.setAddr(multi.getParameter("addr"));
		cdto.setTel(multi.getParameter("tel"));
		cdto.setRoom(multi.getParameter("room"));
		cdto.setCount_seat(Integer.parseInt(multi.getParameter("count_seat")));
		
		String image = multi.getFilesystemName("image");
		//이미지에 아무것도 들어가지 않았을경우 이전 사진을 그대로 사용
		if(image==null){
			image = multi.getParameter("prev_image");
		}
		cdto.setImage(image);
		
		System.out.println("image :"+image);
		
		// CineDAO 객체 생성
		// insertCinema(DTO)
		CineDAO cdao = new CineDAOImpl();
		cdao.updateCinema(cdto);
		
		// 페이지 이동(./CinemaDetail.ci)
		ActionForward forward = new ActionForward();
		forward.setPath("./CinemaAdminDetail.ci");
		forward.setRedirect(true);

		return forward;
	}
	
}
