package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MemeberInfo action 실행중");
		
		HttpSession session = request.getSession();
		
		String id= (String)session.getAttribute("id");
		
		// 아이디 없으면 메인으로
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			 forward.setRedirect(true);
			 return forward;
		}
		
		MemberDAO mdao = new MemberDAOImpl();
		MemberDTO mdto = mdao.getMember(id);
		
		request.setAttribute("mdto", mdto);
		
		forward.setPath("./member/info.jsp");
		forward.setRedirect(false); //mdto 가지고 가자
		return forward;
		
		
	
	}

}
