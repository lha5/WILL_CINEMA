package com.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberIdSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberIdSearchAction_execute()-------------------------");
		
		response.setContentType("text/html; charset=UTF-8");
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// 자바빈(DTO) 객체를 생성해서 여기에 받아온 정보를 저장
		MemberDTO mdto = new MemberDTO();
		
		System.out.println("name : "+request.getParameter("name")+"birthday : "+request.getParameter("birthday"));
		
		mdto.setName(request.getParameter("name"));
		mdto.setBirthday(request.getParameter("birthday"));
		
		MemberDAO mdao = new MemberDAOImpl();
		
		List<MemberDTO> idList = mdao.searchId(mdto);
		
		// 회원 목록을 저장
		request.setAttribute("idList", idList);
		
		System.out.println("아이디 목록 이동하기");
		
		// 페이지 이동
		// ./member/list.jsp
		ActionForward forward = new ActionForward();
		
		forward.setPath("./member/idList.jsp");
		forward.setRedirect(false);

		return forward;
	}

}
