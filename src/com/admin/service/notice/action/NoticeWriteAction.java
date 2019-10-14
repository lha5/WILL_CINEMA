package com.admin.service.notice.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAOImpl;
import com.admin.service.notice.db.AdminNoticeDTO;

public class NoticeWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		System.out.println("AdminNoticeWriteAction_execute()------------------------");
		
		// 한글 처리
		request.setCharacterEncoding("UFT-8");
		// 전달된 정보 객체
		// boardDTO 객체 생성 저장
		AdminNoticeDTO andto = new AdminNoticeDTO(); 
		
		andto.setName(request.getParameter("name"));
		andto.setPass(request.getParameter("pass"));
		andto.setSubject(request.getParameter("subject"));
		andto.setContent(request.getParameter("content"));
		
		// BoardDAOImpl 객체 생성
		AdminNoticeDAOImpl andao = new AdminNoticeDAOImpl();
		// insertBoard(DTO)
		andao.insertBoard(andto);
		
		// 페이지 이동
		// 글목록 보여주는 페이지로 이동
		// ./BoardList.bo
		
		ActionForward forward = new ActionForward();
		forward.setPath("./AdminNoticeWriteAction.an");
		forward.setRedirect(true);
		return forward;
	
	}

	
	
}
