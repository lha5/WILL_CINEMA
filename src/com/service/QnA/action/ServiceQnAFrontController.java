package com.service.QnA.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class ServiceQnAFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestURI = req.getRequestURI();
		String contextPath=req.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/QnAList.sq")){ //공지 리스트 페이지
			
		}else if(command.equals("/QnAUpdate.sq")){ //공지 수정 페이지
			
		}else if(command.equals("/QnADelete.sq")){ //공지 삭제 페이지
			
		}else if(command.equals("/QnAContent.sq")){ //공지 내용 페이지
			
		}else if(command.equals("/QnAWrite.sq")){ //공지 작성 페이지
			
		}
		
		if(command.equals("/QnAWrite.sq")){ //QnA 쓰기 
			forward = new ActionForward();
			forward.setPath("./board/QnAWrite.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/QnAWriteAction.sq")){ //QnA 리스트 페이지
			//action = new QnAWriteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAList.sq")){ //QnA 리스트 페이지
			//action = new QnAListAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAUpdate.sq")){ //QnA 수정 페이지
			//QnAUpdate() -> QnAUpdateForm -> QnAUpdateAction()
			//action = new QnAUpdate();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAUpdateAction.sq")){ //QnA 수정 페이지
			//action = new NoticeUpdateAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnADelete.sq")){ //QnA 삭제 페이지
			//action = new QnADelete();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnADeleteAction.sq")){ //QnA 삭제 페이지
			//action = new QnADeleteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAContent.sq")){ //QnA 내용 페이지
			//action = new QnAContentAction();
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