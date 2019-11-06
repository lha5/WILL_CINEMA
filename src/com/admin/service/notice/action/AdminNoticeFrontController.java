package com.admin.service.notice.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.service.QnA.action.QnASearchAction;

public class AdminNoticeFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/NoticeWrite.an")){ //공지 쓰기
			forward = new ActionForward();
			forward.setPath("./service/noticeBoard/NoticeWrite.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/NoticeWriteAction.an")){ //공지 리스트 페이지
			action = new NoticeWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/NoticeList.an")){ //공지 리스트 페이지
			action = new NoticeListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/NoticeUpdate.an")){ //공지 수정 페이지
			//NoticeUpdate() -> noticeUpdateForm -> NoticeUpdateAction()
			//action = new NoticeUpdate();
			action = new NoticeUpdate();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/NoticeUpdateAction.an")){ //공지 수정 페이지
			//action = new NoticeUpdateAction();	
			action = new NoticeUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/NoticeDelete.an")){ //공지 삭제 페이지
			forward = new ActionForward();
			forward.setPath("./service/noticeBoard/NoticeDelete.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/NoticeDeleteAction.an")){ //공지 삭제 페이지
			action = new NoticeDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/NoticeContent.an")){ //공지 내용 페이지
			action = new NoticeContentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/NoticeSearchAction.an")){
			action = new NoticeSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		

		//가상주소를 가지고 이동
		if(forward !=null){
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}