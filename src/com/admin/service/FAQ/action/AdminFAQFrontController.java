package com.admin.service.FAQ.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

//FAQ관리 페이지(관리자)
public class AdminFAQFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/FAQWrite.af")){ //FAQ쓰기 
			forward = new ActionForward();
			forward.setPath("./board/FAQWrite.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/FAQWriteAction.af")){ //FAQ리스트 페이지
			//action = new FAQWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FAQList.af")){ //FAQ리스트 페이지
			//action = new FAQListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FAQUpdate.af")){ //FAQ수정 페이지
			//FAQUpdate() -> FAQUpdateForm -> FAQUpdateAction()
			//action = new FAQUpdate();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FAQUpdateAction.af")){ //FAQ수정 페이지
			//action = new FAQUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FAQDelete.af")){ //FAQ삭제 페이지
			//action = new FAQDelete();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FAQDeleteAction.af")){ //FAQ삭제 페이지
			//action = new FAQDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FAQContent.af")){ //FAQ내용 페이지
			//action = new FAQContentAction();
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
		doProcess(request,response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
}