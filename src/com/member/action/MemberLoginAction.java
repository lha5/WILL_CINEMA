package com.member.action;

import java.io.PrintWriter;

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
	//String id = 
		
		// 디비 만들고   생성 하고 
		
		MemberDAO mdao = new MemberDAOImpl();
		
		// 아이디 비번 으로 체크하고 
		
		//이프문 써서 아이디 체크하기 
		int login = mdao.idcheck(id,pass);
		
		//경고창
		
		if(login == 0){
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("  alert('비밀번호 오류!!'); ");
			out.println("  history.back(); ");
			out.println("</script>");
			
			out.close();
			
			// actionForward를 사용한 페이지 이동 X
			return null;			
		}else if(login == -1){
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("  alert('아이디 없음!!'); ");
			out.println("  history.back(); ");
			out.println("</script>");
			
			out.close();
			
			// actionForward를 사용한 페이지 이동 X
			return null;			
		}
		
		// check == 1
		// 로그인 -> id값을 세션객체에 저장
		
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		// 세션값을 가지고 간다 .
		
		ActionForward forward = new ActionForward();
		forward.setPath("./MemberJoin.me"); // 로그인 안되어 있음 회원가입으로 감
		forward.setRedirect(true);
		 // 정보값 가져가지 않아서  true
		return forward;
	}

}
