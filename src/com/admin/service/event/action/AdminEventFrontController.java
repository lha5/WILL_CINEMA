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

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/EventWrite.ae")){ //이벤트 글 쓰기 
			forward = new ActionForward();
			forward.setPath("./service/eventBoard/eventWrite.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/EventWriteAction.ae")){ //이벤트 글 쓰기 액션 
			action = new EventWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventList.ae")){ //Event리스트 페이지(관리자)
			action = new EventListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventListSearch.ae")){ //Event리스트 페이지(관리자)
			action = new EventListSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventUpdate.ae")){ //Event수정 페이지(관리자)
			//EventUpdate() -> eventUpdateForm -> EventUpdateAction()
			action = new EventUpdate();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventUpdateAction.ae")){ //Event수정 페이지(관리자)
			action = new EventUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventDelete.ae")){ //Event 삭제 페이지
			action = new EventDelete();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventSummary.ae")){ //전체 Event 리스트 요약 페이지(사용자)
			action = new EventSummaryAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventPast.ae")){ //지난 Event 리스트 페이지(사용자)
			action = new EventPastAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventContent.ae")){ //카테고리 선택한 Event 전체 리스트 페이지(사용자)
			action = new EventContentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventDetail.ae")){ //Event 상세 내용 페이지
			action = new EventDetailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventMore.ae")){ //Event 내용 더보기
			action = new EventMoreAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/PastMore.ae")){ //Event 내용 더보기
			action = new PastMoreAction();
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