package com.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAOImpl;

import com.member.db.MemberDAO;
import com.member.db.MemberDTO;

public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberListAction execute()-------------------------------------------------------");
		
		// 세션값 제어(로그인 상태이면서 관리자 계정일때만 처리 가능)
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null || !id.equals("admin")) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);

			return forward;
		}
		
		// DB 처리 객체 MemberDAO 생성
		// getMemberList(); >> 회원 정보 목록
		MemberDAO mdao = new MemberDAOImpl();
		List<MemberDTO> memberList =  mdao.getMemberList();

		// 회원 목록을 저장
		request.setAttribute("memberList", memberList);

		// 페이지 이동
		// ./member/list.jsp
		forward.setPath("./member/list.jsp");
		forward.setRedirect(false);

		return forward;
	}

}
