package com.admin.service.notice.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAO;
import com.admin.service.notice.db.AdminNoticeDAOImpl;
import com.admin.service.notice.db.AdminNoticeDTO;

public class NoticeUpdate implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("NoticeUpdate_execute()------------------------");
		
		//한글 처리 
		request.setCharacterEncoding("UTF-8");

		// num, pageNum 저장
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		// AdminNoticeDAO 객체
		// 글번호 해당하는 정보를 가져오는 메서드 사용
		AdminNoticeDAOImpl andao = new AdminNoticeDAOImpl();
		AdminNoticeDTO andto = andao.getBoard(num);
		
		// 정보 저장 (글 정보 ,pageNum)
		request.setAttribute("andto", andto);
		request.setAttribute("pageNum", pageNum);
		
		// 페이지 이동(./notice/NoticeUpdateForm.jsp)
		ActionForward forward = new ActionForward();
		forward.setPath("./service/noticeBoard/NoticeUpdateForm.jsp");
		forward.setRedirect(false);	
		return forward;
		
	}

}
