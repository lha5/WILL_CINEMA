package com.member.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.action.Action;
import com.action.ActionForward;

import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberLoginAction! 실행문 나옵니다.");
		
		//id,pass
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		// 디비 만들고   생성 하고 
		MemberDAO mdao = new MemberDAOImpl();
		
		// 아이디 비번 으로 체크하고 
		int check = mdao.idCheck(id, pass);
		List info = mdao.forPointLevel(id);
			
		System.out.println("로그인 정보 출력 : " + check);
		
		if(check == 0){
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("  alert('아이디 또는 비밀번호가 다릅니다!'); ");
			out.println("  history.back(); ");
			out.println("</script>");
			
			out.close();
			
			// actionForward를 사용한 페이지 이동 X
			return null;			
		} else if(check == -1) {
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("  alert('아이디 또는 비밀번호가 다릅니다.'); ");
			out.println("  history.back(); ");
			out.println("</script>");
			
			out.close();
			
			// actionForward를 사용한 페이지 이동 X
			return null;			
		}
		
		
		
		
		// 세션값을 가지고 간다 .
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		session.setAttribute("info", info);
		
		
		ActionForward forward = new ActionForward();
		
		// 로그인 안되어 있음 회원가입으로 감
		forward.setPath("./MyInfoPage.me");
		// 정보값 가져가지 않아서  true
		forward.setRedirect(true);
		
		return forward;
	
		
	}
}
