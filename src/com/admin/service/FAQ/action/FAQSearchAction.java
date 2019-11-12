package com.admin.service.FAQ.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		// 한글처리 
		request.setCharacterEncoding("UTF-8");
				
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		
		//noticeList에서 검색결과를 받아옴
		String search = request.getParameter("search");
		
		System.out.println("검색어 : "+search);
		
		int count = afdao.getBoardCount();
		
		int pageSize = 5;
		
		// 현 페이지가 몇페이지 인지를 가져오기
		String pageNum = request.getParameter("pageNum");
		
		if (pageNum == null) {
			pageNum = "1"; // pageNum의 값이 없을경우 무조건 1페이지
		}
		
		// 시작행 구하는 작업
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		
		// 끝행 구하는 작업
		int endRow = currentPage * pageSize;
		
		List<AdminFAQDTO> FAQList = null;
		
		if( count != 0 ){ 
			  FAQList = afdao.getSearch(search, startRow, pageSize);
		}
		
		// 전체 페이지수 계산
		int pageCount = count/pageSize+(count % pageSize == 0? 0:1); 
							
		int pageBlock = 1;
							
		// 시작페이지
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
		// 끝페이지
		int endPage = startPage+pageBlock-1;
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
				
		request.setAttribute("count", count);
		request.setAttribute("FAQList", FAQList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
				
		ActionForward forward = new ActionForward();
		forward.setPath("./service/FAQBoard/faqUserList.jsp");
		forward.setRedirect(false);
				
		return forward;
	}

}
