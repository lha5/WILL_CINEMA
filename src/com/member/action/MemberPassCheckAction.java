package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class MemberPassCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MemberPassCheckAction execute()-----------------------------------");
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		MemberDAO mdao = new MemberDAOImpl();
				
		int check = mdao.idCheck(id, pass);
		
		if (check == 0) {
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("alert('비밀번호가 다릅니다.');");
			out.println("history.back();");
			out.println("</script>");
			
			out.close();
			
			// actionForward를 사용한 페이지 이동 X
			return null;			
		} else if(check == -1) {
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("alert('아이디가 존재하지 않습니다.');");
			out.println("history.back(); ");
			out.println("</script>");
			
			out.close();
			
			// actionForward를 사용한 페이지 이동 X
			return null;			
		}
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./MemberPassUpdate.me");
		forward.setRedirect(true);
		
		
		return forward;
	}

}
