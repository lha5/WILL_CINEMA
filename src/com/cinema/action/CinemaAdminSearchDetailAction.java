package com.cinema.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;

public class CinemaAdminSearchDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("CinemaAdminSearchDetailAction execute()-----------------------------------------------------");
		
		request.setCharacterEncoding("UTF-8");
		
		// CineDAO 객체 생성
		CineDAO cdao = new CineDAOImpl();
		// 지점 수 확인 매서드
		int count = cdao.getCount();
		
		/*********************************************************/
		// 페이징 처리

		// 한 페이지에서 보여줄 글의 개수 설정
		int pageSize = 4;
		
		// 현 페이지가 몇페이지 인지를 가져오기
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum.equals("null")) {
			pageNum = "1"; // pageNum의 값이 없을경우 무조건 1페이지
		}
		// 시작행 구하는 작업
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		// => 1 11 21 31 ....
		// 끝행 구하는 작업
		int endRow = currentPage * pageSize;
		// => 10 20 30 40....

		/*********************************************************/
		
		// getCineList(); >> List 형태의 데이터를 리턴
		List<CineDTO> cineList =null;
		
		// 검색 결과
		String search = request.getParameter("search");
		String category = request.getParameter("category");
		
		System.out.println(search+","+category);
		
		if(search != null || count != 0){
			cineList = cdao.getCineList(startRow, pageSize, category, search);
		}
		
		// 페이지 출력
		// if (count != 0) {
		// 전체 페이지수 계산
		
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

		// 한화면에 보여줄 페이지 번호 계산
		int pageBlock = 5;

		// 시작페이지
		// 1~10 =>1 11~20 => 11 21~30 => 21
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
		// 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		
		
		// DB에서 가져온 정보를 저장
		request.setAttribute("count", count);
		request.setAttribute("cineList", cineList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageSize", pageSize);
		
		// 페이지 이동(./CinemaDetail.ci)
		
		ActionForward forward = new ActionForward();
		forward.setPath("./adminCinema/cinemaAdminList.jsp");
		forward.setRedirect(false);	// 가상주소에서 실제 jsp로 가야하기 때문에 false(forwarding 방식)
		
		
		return forward;
	}

}
