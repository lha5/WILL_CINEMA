package com.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;


public class MemberFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if(command.equals("/MyPage.me")){ //마이페이지([구매/예매, 문의내역, 회원(수정,탈퇴)])
			action = new MyPageAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			
			}
		}else if(command.equals("/Index.me")){ //메인 페이지
			action = new IndexAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
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
			action = new MemberLoginAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MemberLoginWithNaver.me")) {
			//action = new MemberLoginWithNaverAction();
		} else if(command.equals("/MemberJoin.me")){ //회원가입 페이지
			forward = new ActionForward();
			
			forward.setPath("./member/joinForm.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberJoinAction.me")){ //회원가입 처리 페이지
			action = new MemberJoinAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberLogout.me")){ //로그아웃 처리 페이지
			action = new MemberLogoutAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberUpdate.me")){ //정보수정 페이지
			action = new MemberUpdate();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberUpdateAction.me")){ //정보수정 처리
			action = new MemberUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberDelete.me")){ //회원 탈퇴 페이지
			forward = new ActionForward();
			
			forward.setPath("./member/deleteForm.jsp");
			forward.setRedirect(false);			
		}else if(command.equals("/MemberDeleteAction.me")){ //회원 탈퇴 페이지
			
			action = new MemberDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}else if(command.equals("/MemberList.me")){ //회원 관리 페이지(관리자 전용)
			action = new MemberListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberInfo.me")){ // 회원정보조회
			action = new MemberInfoAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MemberPassCheck.me")) {
			forward = new ActionForward();
			
			forward.setPath("./member/updatePass.jsp");
		} else if (command.equals("/MemberPassCheckAction.me")) {
			action = new MemberPassCheckAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MemberPassUpdate.me")) {
			forward = new ActionForward();
			
			forward.setPath("./member/updatePass2.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/MemberPassUpdateAction.me")) {
			action = new MemberPassUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/Membership.me")) {
			forward = new ActionForward();
			
			forward.setPath("./member/membership.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/MemberIdSearch.me")){
			forward = new ActionForward();
			
			forward.setPath("./member/idSearch.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/MemberIdSearchAction.me")){
			action = new MemberIdSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MemberPassSearch.me")){
			forward = new ActionForward();
			
			forward.setPath("./member/passSearch.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/MemberPassSearchAction.me")){
			action = new MemberPassSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}else if (command.equals("/NonMemberLogin.me")) {
			forward = new ActionForward();
			
			forward.setPath("./non_member/non_memberlogin.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/NonMemberLoginAction.me")){
			action = new NonMemberLoginAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberNaverLogin.me")){
			//네이버 로그인 callback.jsp 이동
			// 후에 수정하실 분 callback.jsp에 내용 
			// java파일로 옮겨도 사용가능할 것으로 보이니 참고 바람
			
			forward = new ActionForward();
			
			forward.setPath("./member/callback.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberNaverLoginAction.me")){
			action = new MemberNaverLoginAction();
			
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