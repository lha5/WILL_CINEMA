package com.admin.service.event.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

//이벤트 관리 페이지(관리자)
public class AdminEventFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestURI = req.getRequestURI();
		String contextPath=req.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/EventWrite.ae")){ //이벤트 글 쓰기 
			forward = new ActionForward();
			forward.setPath("./service/eventBoard/eventWrite.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/EventWriteAction.ae")){ //Event리스트 페이지
			//action = new EventWriteAction();
			try {
				forward = action.execute(req, resp);
				//수정
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventList.ae")){ //Event리스트 페이지
			//action = new EventListAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventUpdate.ae")){ //Event수정 페이지
			//EventUpdate() -> eventUpdateForm -> EventUpdateAction()
			//action = new FAQUpdate();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventUpdateAction.ae")){ //Event수정 페이지
			//action = new EventUpdateAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventDelete.ae")){ //Event 삭제 페이지
			//action = new EventDelete();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventDeleteAction.ae")){ //Event 삭제 페이지
			//action = new EventDeleteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventContent.ae")){ //Event 내용 페이지
			//action = new EventContentAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//가상주소를 가지고 이동
		if(forward !=null){
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dis = req.getRequestDispatcher(forward.getPath());
				dis.forward(req, resp);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
}