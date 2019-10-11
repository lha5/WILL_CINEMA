package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberUpdateAction 실행중!!");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String pass = (String) session.getAttribute("pass");
		
		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 수정해야하니깐 한글
		
		request.setCharacterEncoding("UTF-8");
		MemberDTO mdto = new MemberDTO();
		
		// int - 우편번호만 
		mdto.setAddr(request.getParameter("addr"));
		mdto.setBirthday(request.getParameter("birthday"));
		mdto.setDetailaddr(request.getParameter("detailaddr"));
		mdto.setEmail(request.getParameter("email"));
		mdto.setMobile(request.getParameter("mobile"));
		mdto.setName(request.getParameter("name"));
		mdto.setPreference(request.getParameter("preference"));
		mdto.setReceive(request.getParameter("receive"));
		mdto.setZipcode(Integer.parseInt(request.getParameter("zipcode")));
		
		///////////////////////////////////
		mdto.setId(id);
		mdto.setPass(request.getParameter("pass"));
		
		MemberDAO mdao = new MemberDAOImpl();
		int update =  mdao.updateMember(mdto);
		response.setContentType("text/html; charset=UTF-8");
		
		
		if(update==-1){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("  alert('아이디 없음!');  ");
			out.println("  history.back(); ");
			out.println("</script>");	
			
			out.close();
			
			return null;
			
		}else if(update == 0){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("  alert('비밀번호가 다릅니다.');  ");
			out.println("  history.back(); ");
			out.println("</script>");	
			
			out.close();
			
			return null;
		}

		
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("  alert('정보수정 완료!');  ");
		out.println("  location.href='./Main.me'; ");
		out.println("</script>");	
		
		out.close();	

		return null;
	}

}
