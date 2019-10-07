package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberLoginAction! 실행문 나옵니다.");
		
		//id,pass
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
	//String id = 
		
		// 디비 만들고   생성 하고 
	
		
		// 아이디 비번 으로 체크하고 
		
		//이프문 써서 아이디 체크하기 
		
		// 세션값을 가지고 간다 .
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./MemberJoin.me"); // 로그인 안되어 있음 회원가입으로 감
		forward.setRedirect(true);
		 // 정보값 가져가지 않아서  true
		return forward;
	}

}
