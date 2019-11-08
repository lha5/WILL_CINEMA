package com.service.QnA.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.service.QnA.db.QnADAO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnAListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnAListAction_execute()-------------------");
		
		QnADAO qadaoImpl = new QnADAOImpl();
		
		int count = qadaoImpl.getBoardCount();
		
		int pageSize = 10;
		
		System.out.println("pageNum - 1 : " + request.getParameter("pageNum"));
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 현 페이지가 몇페이지 인지를 가져오기
		String pageNum = request.getParameter("pageNum");
		
		System.out.println("pageNum - 2 : "+pageNum);
		
		if (pageNum == null) {
			pageNum = "1"; // pageNum의 값이 없을경우 무조건 1페이지
		}
		
		// 시작행 구하는 작업
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		// 끝행 구하는 작업
		int endRow = currentPage * pageSize;
		
		
		List<QnADTO> boardList = null;
		
		if( count != 0 ){ 
			  boardList = qadaoImpl.getBoardList(startRow,pageSize);
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
		
		// 회원 이름 가져가기
		MemberDAO mdao = new MemberDAOImpl();
		List info = mdao.forPointLevel(id);
		String name = String.valueOf(info.get(0));
		System.out.println("접속자 : " + name);
		
		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", startPage);
		request.setAttribute("name", name);
		
		if (id.equals("admin")) {
			forward.setPath("./service/QnABoard/QnAList.jsp");
			forward.setRedirect(false);
		} else {
			forward.setPath("./service/QnABoard/QnAUserList.jsp");
			forward.setRedirect(false);
		}
		
		return forward;
	}

}
