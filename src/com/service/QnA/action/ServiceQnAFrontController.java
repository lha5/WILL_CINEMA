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

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		System.out.println("URI : "+requestURI);
		System.out.println("contextPath : "+contextPath);
		System.out.println("command(이동할 가상주소) : "+command);
		
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/QnAWrite.sq")){ //QnA 쓰기 
			forward = new ActionForward();
			forward.setPath("./board/QnAWrite.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/QnAWriteAction.sq")){ //QnA 리스트 페이지
			action = new QnAWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAList.sq")){ //QnA 리스트 페이지
			action = new QnAListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAUpdate.sq")){ //QnA 수정 페이지
			//QnAUpdate() -> QnAUpdateForm -> QnAUpdateAction()
			action = new QnAUpdate();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAUpdateAction.sq")){ //QnA 수정 페이지
			action = new QnAUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnADelete.sq")){ //QnA 삭제 페이지
			action = new QnADelete();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnADeleteAction.sq")){ //QnA 삭제 페이지
			action = new QnADeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/QnAContent.sq")){ //QnA 내용 페이지
			action = new QnAContentAction();
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