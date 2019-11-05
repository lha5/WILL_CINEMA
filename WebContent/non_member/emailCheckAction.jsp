
<%@page import="com.member.db.NonMemberDAO"%>
<%@page import="java.io.PrintWriter"%>

<%@page import="util.SHA256"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");

	String code = request.getParameter("code");

	NonMemberDAO nonMemberDAO = new NonMemberDAO();

	String name = null;

	if(session.getAttribute("name") != null) {

		name = (String) session.getAttribute("name");

	}

	if(name == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 해주세요.');");

		script.println("location.href = 'userLogin.jsp'");

		script.println("</script>");

		script.close();

		return;

	}

	String email = nonMemberDAO.getUserEmail(name);

	boolean rightCode = (new SHA256().getSHA256(email).equals(code)) ? true : false;

	if(rightCode == true) {

		nonMemberDAO.setUserEmailChecked(name);

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('인증에 성공했습니다.');");

		script.println("location.href = 'non_memberlogin.jsp'");

		script.println("</script>");

		script.close();		

		return;

	} else {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('유효하지 않은 코드입니다.');");

		script.println("location.href = 'non_memberlogin.jsp'");

		script.println("</script>");

		script.close();		

		return;

	}

%>