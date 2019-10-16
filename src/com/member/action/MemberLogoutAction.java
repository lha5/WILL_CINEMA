package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		
System.out.println("MemberLogoutAction 실행됩니다 ");
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		
		response.setContentType("text/html; charset=UTF-8");
		
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("  alert('로그아웃 성공!!');");
		out.println("  location.href='./Main.me'; ");
		out.println("</script>");
		
		
		return null;
	}

}
