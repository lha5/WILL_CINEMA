package com.member.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MemberJoinAction execute()--------------------------------------------");
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 자바빈(DTO) 객체를 생성해서 여기에 받아온 정보를 저장
		MemberDTO mdto = new MemberDTO();
		
		mdto.setId(request.getParameter("id"));
		mdto.setPass(request.getParameter("pass"));
		mdto.setName(request.getParameter("name"));
		mdto.setBirthday(request.getParameter("birthday"));
		mdto.setMobile(request.getParameter("mobile"));
		mdto.setEmail(request.getParameter("email"));
		mdto.setZipcode(Integer.parseInt(request.getParameter("zipcode")));
		mdto.setAddr(request.getParameter("addr") + " " + request.getParameter("refaddr"));
		mdto.setDetailaddr(request.getParameter("detailaddr"));
		mdto.setReceive(request.getParameter("receive"));
		mdto.setPreference(request.getParameter("preference"));
		mdto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		// DAO 객체를 생성하고 insertMember() 메소드로 처리
		MemberDAO mdao = new MemberDAOImpl();
		
		mdao.insertMember(mdto);
		
		// 페이지 이동("./MemberLogin.me") - ActionForward
		ActionForward forward = new ActionForward();
		
		forward.setPath("./MemberLogin.me");
		forward.setRedirect(true);
		
		return forward;
	}

}
