package com.admin.service.notice.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAO;
import com.admin.service.notice.db.AdminNoticeDAOImpl;
import com.admin.service.notice.db.AdminNoticeDTO;

public class NoticeContentAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardContentAction_execute()---------------------------");

		// DB에서 글번호 해당하는 글의 정보를 보여주는 페이지

		// 전달 정보를 저장(num,numpage)
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");

		System.out.println("num : " + num + ", pageNum : " + pageNum);

		// AdminNoticeDAO 객체 생성
		AdminNoticeDAO andao = new AdminNoticeDAOImpl();

		// readcount 1증가 => updateReadcount(num);
		andao.updateReadcount(num);
			
		// 글번호에 해당하는 글정보를 가져오기
		AdminNoticeDTO andto = andao.getBoard(num);

		// 정보 저장 (글정보,pageNum)
		request.setAttribute("andto", andto);
		request.setAttribute("pageNum", pageNum);

		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./service/noticeBoard/NoticeContent.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
