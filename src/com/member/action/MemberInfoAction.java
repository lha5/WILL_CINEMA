package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class MemberInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MemeberInfo action 실행중");
		
		HttpSession session = request.getSession();
		
		String id= (String)session.getAttribute("id");
		
		// 아이디 없으면 메인으로
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./Main.me");
			 forward.setRedirect(true);
			 return forward;
		
		
		
		}
		
		
		
		
		return null;
	}

}
