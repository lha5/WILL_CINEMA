<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 내 정보 관리</title>
</head>
<body>
<%
	String id = (String) session.getAttribute("id");
	String name = (String) session.getAttribute("name");

	if (id == null) {
		response.sendRedirect("./MemberLogin.me");
	}

	MemberDTO mdto = (MemberDTO) request.getAttribute("mdto");
%>

	<input type="button" value="회원 정보 수정" onclick="location.href='./MemberUpdate.me'">&nbsp;&nbsp;
	<input type="button" value="비밀번호 변경" onclick="location.href='./MemberPassCheck.me'">&nbsp;&nbsp;
	<input type="button" value="회원 계정 삭제" onclick="location.href='./MemberDelete.me'">


	<!-- 관리자전용 -->
	<%
	if (id != null) {
		if (id.equals("admin")) {
	%>
		<br><br>
	
		<hr>
		
		<a href="./MemberList.me">회원 목록 관리(관리자 전용)</a>
		<br><br>
		<a href="./NoticeWrite.an">공지사항 글쓰기(관리자 전용)</a>
		<br><br>
		<a href="./FAQList.af">FAQ 관리(관리자 전용)</a>
		<br><br>
		<a href="./EventWrite.ae">이벤트 글쓰기(관리자)</a>
		<br><br>
		<a href="./EventList.ae">이벤트 목록(관리자)</a>
		<br><br>
		<a href="#">예매 목록 관리(관리자 전용)</a>
		<br><br>
		<a href="#">매점 주문 관리(관리자 전용)</a>
		<br><br>
		<a href="./GoodsList.al">매점 관리(관리자 전용)</a>
		<br><br>
		<a href="./CinemaAdminDetail.ci">영화관 지점 관리(관리자 전용)</a>
		<br><br>
					
	<%	
		}
	}
	%>
</body>
</html>