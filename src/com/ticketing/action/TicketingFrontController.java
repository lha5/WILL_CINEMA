package com.ticketing.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class TicketingFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/TicketingAction.ti")){//예매 페이지(시간, 영화관, 영화 선택)
			//action = new TicketingAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ShowTime.ti")){ //좌석 선택 페이지
			action = new ShowTimeAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/Ticketing.ti")){ //좌석 선택 페이지
			action = new Ticketing(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/SeatSelect.ti")){ //좌석 선택 페이지 이동
			//action = new SeatSelect(); 
			action = new SeatSelect();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/SeatSelectAction.ti")){ //좌석 선택 페이지 처리
			//action = new SeatSelectAction(); 
			action = new SeatSelectAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/TicketOrderAction.ti")){ //티켓 결제 페이지
			//결제 내역은 마이페이지-구매내역 확인
			//action = new TicketOrderAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MovieScheAction.ti")){ //상영 시간표 페이지
			//action = new MovieScheAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/TestSendEmailAction.ti")){ //이메일 발송 페이지
				//action = new ActionSendMessageAction
				
			try {
				forward=action.execute(request, response);
			} catch (Exception e){
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