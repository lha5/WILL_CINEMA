package com.admin.service.FAQ.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// DB 처리객체 생성
				AdminFAQDAO afdao = new AdminFAQDAOImpl();
					
				int count = afdao.getFAQCount();
				
				/*********************************************************/
				// 페이지에서 보여줄 글의 개수 설정
				int pageSize = 5;
				
				// 페이지가 몇페이지 인지를 가져오기
				String pageNum = request.getParameter("pageNum");
				if (pageNum == null ) {
					pageNum = "1"; //|| pageNum.equals("null") pageNum의 값이 없을경우 무조건 1페이지
				}
				// 시작행 구하는 작업
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
						// => 1 11 21 31 ....
						// 끝행 구하는 작업
			int endRow = currentPage * pageSize;
						
					
						/*********************************************************/
						// DB에서 글 가져오기
						// getBoardList();
						List<AdminFAQDTO> FAQList = null;
				
						if( count != 0 ){ 
							FAQList = afdao.getFAQList(startRow,pageSize);
						}
						System.out.println("갯수:"+FAQList.size());
						// getFAQList(int startRow,int pageSize);
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
		forward.setPath("./FAQBoard/faqList1.jsp");
		forward.setRedirect(false);		

		return forward;
	}

}