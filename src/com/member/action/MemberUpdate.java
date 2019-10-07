package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MemberUpdate 실행됩니다~");
		
		// id값이 없으면 -> 메인페이지로 가기
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./Main.me");
			forward.setRedirect(true);
			return forward;
		}
		
		
		MemberDAO mdao = new MemberDAOImpl();
	/*	MemberDTO mdto = mdao.getMember(id);*/
		
		//request.setAttribute("", );

		
		forward.setPath("./member/updateForm.jsp");
		forward.setRedirect(false);		
		
		return forward;
		
		
	}

}
