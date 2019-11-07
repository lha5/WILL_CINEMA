package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class MemberPassUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberPassUpdateAction execute()---------------------------------");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		String pass = request.getParameter("pass");
		
		MemberDAO mdao = new MemberDAOImpl();
		
		mdao.updatePass(id, pass);
		
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('비밀번호 변경이 완료되었습니다.');");
		out.println("location.href='./Main.me';");
		out.println("</script>");	
		
		out.close();	

		return null;
	}

}
