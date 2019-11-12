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
import com.member.db.NonMemberDAO;

public class NonMemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("비회원 로그인 실행중!");
		
		request.setCharacterEncoding("UTF-8");

		ActionForward forward = new ActionForward();
		
		String name = request.getParameter("name");
		
		String birth = request.getParameter("birth");
		
		String email = request.getParameter("email");
		
		System.out.println(" name : "+name+" email : "+email+" birth : "+birth);
		
		// 디비 만들고   생성 하고 
		NonMemberDAO nmdao = new NonMemberDAO();
		MemberDAO mdao = new MemberDAOImpl();
		
		int num = nmdao.search(name);
		
		System.out.println(" num : "+num);
		
		if(num == 1){
		
			int check = mdao.emailCheck(name, email);
			List info = mdao.forPointLevel(name);
			
			System.out.println("로그인 정보 출력 : " + check);
			
			if(check == 0){
				
				response.setContentType("text/html; charset=UTF-8");
				
				PrintWriter out = response.getWriter();
				
				out.println("<script> ");
				out.println("  alert('이메일 인증이 안됐습니다!'); ");
				out.println("  history.back(); ");
				out.println("</script>");
				
				out.close();
				
				// actionForward를 사용한 페이지 이동 X
				return null;			
			} else if(check == -1) {
				response.setContentType("text/html; charset=UTF-8");
				
				PrintWriter out = response.getWriter();
				
				out.println("<script> ");
				out.println("  alert('이름 또는 이메일이 다릅니다.'); ");
				out.println("  history.back(); ");
				out.println("</script>");
				
				out.close();
				
				// actionForward를 사용한 페이지 이동 X
				return null;			
			}
			
			// 세션값을 가지고 간다 .
			HttpSession session = request.getSession();
			session.setAttribute("id", name);
			session.setAttribute("info", info);
			session.setAttribute("NonMember", "비회원");
					
			// 로그인 안되어 있음 회원가입으로 감
			forward.setPath("./Main.me");
			// 정보값 가져가지 않아서  true
			forward.setRedirect(true);
		
		}else if(num == -1){
			
			response.setContentType("text/html; charset=UTF-8");
			
			// 세션값을 가지고 간다 .
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			session.setAttribute("birth", birth);
			session.setAttribute("email", email);
			
			PrintWriter out = response.getWriter();
			
			out.println("<script> ");
			out.println("location.href = './non_member/userRegisterAction.jsp';");
			out.println("</script>");
			
			out.close();
			
		}
				
		return forward;
	}

}
