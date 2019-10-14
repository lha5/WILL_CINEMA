package com.cinema.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

//영화관 페이지
public class CinemaFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/CinemaDetail.ci")){ //영화관 메인 페이지(현재 상영작/상영 예정작 탭 이동)
			//예매 - 상영시간표 - 영화관별 상영시간표와 같음
			//action = new CinemaDetailAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/CinemaAdd.ci")) { //영화관 등록 페이지(관리자)
			forward = new ActionForward();
			forward.setPath("./adminCinema/cinemaAdd.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/CinemaAddAction.ci")) { //영화관 등록 페이지(관리자)
			//action = new CinemaAddAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/CinemaDelete.ci")) { //영화관 삭제 페이지(관리자)
			//action = new CinemaDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/CinemaModify.ci")) { //영화관 수정 페이지(관리자)
			forward = new ActionForward();
			forward.setPath("./adminCinema/cinemaModify.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/CinemaModifyAction.ci")) { //영화관 수정 페이지(관리자)
			//action = new CinemaModifyAction();
			
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
