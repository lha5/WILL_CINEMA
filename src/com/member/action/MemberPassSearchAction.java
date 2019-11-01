package com.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberPassSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
System.out.println("MemberIdSearchAction_execute()-------------------------");
		
		response.setContentType("text/html; charset=UTF-8");
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// 자바빈(DTO) 객체를 생성해서 여기에 받아온 정보를 저장
		MemberDTO mdto = new MemberDTO();
		
		System.out.println("id : "+request.getParameter("id")+" name : "+request.getParameter("name"));
		
		mdto.setId(request.getParameter("id"));
		mdto.setName(request.getParameter("name"));
		
		MemberDAO mdao = new MemberDAOImpl();
		
		List<MemberDTO> passList = mdao.searchPass(mdto);
		
		// 회원 목록을 저장
		request.setAttribute("passList", passList);
		
		System.out.println("아이디 목록 이동하기");
		
		// 페이지 이동
		// ./member/list.jsp
		ActionForward forward = new ActionForward();
		
		forward.setPath("./member/passList.jsp");
		forward.setRedirect(false);

		return forward;
	}

}
