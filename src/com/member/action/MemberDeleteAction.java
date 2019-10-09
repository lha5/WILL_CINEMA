package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MemberDeleteAction 실행하는중!!!");
		
		
		HttpSession session = request.getSession();
		String id =(String) session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		String pass= request.getParameter("pass");
		MemberDAO mdao = new MemberDAOImpl();
		
		int delete = mdao.deleteMember(id, pass);
		
response.setContentType("text/html; charset=UTF-8");
		
		if(delete == 0){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println(" alert('비밀번호 오류'); ");
			out.println(" history.back(); ");
			out.println("</script>");
			
			out.close();
			
			return null;
			
		}else if(delete == -1){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println(" alert('아이디 없음'); ");
			out.println(" history.back(); ");
			out.println("</script>");
			
			out.close();
			
			return null;
		}
		
		
		session.invalidate();
		
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println(" alert('회원정보 탈퇴 성공'); ");
		out.println(" location.href='./Main.me' ");
		out.println("</script>");
		
		out.close();	
		
		return null;
	}

}
