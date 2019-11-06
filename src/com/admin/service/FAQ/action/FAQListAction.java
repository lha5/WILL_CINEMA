package com.admin.service.FAQ.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("FAQListAction ~~~~~!!");
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		int count = afdao.getFAQCount();
		int pageSize = 5;// 페이지에서 보여줄 글의 개수 설정
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		// 아이디 없을때 보내려면 
		
		
		String pageNum = request.getParameter("pageNum");
				if (pageNum == null ||pageNum.equals("null")) {
					pageNum = "1"; //  pageNum의 값이 없을경우 무조건 1페이지
				}// 시작행 구하는 
				
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;// 끝행 구하는 
						
					
		// getBoardList();
		List<AdminFAQDTO> FAQList = null;
				
		//if( count != 0 )
		FAQList = afdao.getFAQList(startRow,pageSize);
		// 전체 페이지수 계산
		int pageCount = count/pageSize+(count % pageSize == 0? 0:1); 

		int pageBlock = 2;

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
		
		
		if (id.equals("admin")) {
			forward.setPath("./service/FAQBoard/faqList.jsp");
			forward.setRedirect(false);
		} else {
			forward.setPath("./service/FAQBoard/faqUserList.jsp");
			forward.setRedirect(false);
		}		

		return forward;
	}

}