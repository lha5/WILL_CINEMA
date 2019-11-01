package com.admin.service.notice.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAO;
import com.admin.service.notice.db.AdminNoticeDAOImpl;
import com.admin.service.notice.db.AdminNoticeDTO;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class NoticeListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("AdminNoticeListAction_execute()---------------------");
		
		// 세션값 가져가기 위한 작업
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		// DB 처리객체 생성
		AdminNoticeDAO andao = new AdminNoticeDAOImpl();

		
		int count = andao.getBoardCount();
		
		/*********************************************************/
		// 페이지에서 보여줄 글의 개수 설정
		int pageSize = 10;

		// 페이지가 몇페이지 인지를 가져오기
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum.equals("null")) {
			pageNum = "1"; // pageNum의 값이 없을경우 무조건 1페이지
		}
		System.out.println("pageNum 값 : " + pageNum);
		// 시작행 구하는 작업
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		// => 1 11 21 31 ....
		// 끝행 구하는 작업
		int endRow = currentPage * pageSize;
		// => 10 20 30 40....	

		/*********************************************************/
		// DB에서 글 가져오기
		// getBoardList();
		List<AdminNoticeDTO> boardList = null;

		//if (count != 0) {
		boardList = andao.getBoardList(startRow, pageSize);
		//}
		// 페이지 출력
		// if (count != 0) {
		// 전체 페이지수 계산
		// 글 : 50개 -> 페이지당 10개씩 출력 5페이지
		// 글 : 56개 -> 페이지당 10개씩 출력 6페이지

		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

		// 한화면에 보여줄 페이지 번호 계산
		int pageBlock = 2;
		// 시작페이지
		// 1~10 =>1 11~20 => 11 21~30 => 21
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
		// 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		// 이름값 가져가기
		MemberDAO mdao = new MemberDAOImpl();
		List info = mdao.forPointLevel(id);

		request.setAttribute("count", count);
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("info", info);
		
		// 페이지 이동 (./notice/noticeList.jsp)
		ActionForward forward = new ActionForward();
		forward.setPath("./service/noticeBoard/NoticeList.jsp");
		forward.setRedirect(false);	

		return forward;
	}

}
