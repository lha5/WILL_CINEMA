package com.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

//마이페이지
public class MemberFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestURI = req.getRequestURI();
		String contextPath=req.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/MyPage.me")){ //마이페이지([구매/예매, 문의내역, 회원(수정,탈퇴)])
			//action = new MyPageAction(); 
			
			try {
				forward=action.execute(req, resp);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/Main.me")){ //메인 페이지
			forward = new ActionForward();
			
			forward.setPath("./member/main.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberLogin.me")){ //로그인 페이지
			forward = new ActionForward();
			
			forward.setPath("./member/loginForm.jsp");
			forward.setRedirect(false);	
		}else if(command.equals("/MemberLoginAction.me")){ //로그인 페이지
			//action = new MemberLoginAction();
			
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberJoin.me")){ //회원가입 페이지
			forward = new ActionForward();
			
			forward.setPath("./member/joinForm.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberJoinAction.me")){ //회원가입 페이지
			//action = new MemberJoinAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberLogout.me")){ //로그아웃 처리 페이지
			//action = new MemberLogoutAction();
			
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberUpdate.me")){ //정보수정 페이지
			//action = new MemberUpdate();
			
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberUpdateAction.me")){ //정보수정 페이지
			//action = new MemberUpdateAction();
			
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberDelete.me")){ //회원 탈퇴 페이지
			forward = new ActionForward();
			
			forward.setPath("./member/deleteForm.jsp");
			forward.setRedirect(false);			
		}else if(command.equals("/MemberDeleteAction.me")){ //회원 탈퇴 페이지
			//action = new MemberDeleteAction();
			
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}else if(command.equals("/MemberList.me")){ //회원 관리 페이지(관리자 전용)
			//action = new MemberListAction();
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