<%@page import="com.member.db.MemberDTO"%>
<%@page import="com.member.db.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 목록</title>
</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<%
		// String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");

		if (id == null) {
			response.sendRedirect("./MemberLogin.me");
		}

		MemberDTO mdto = (MemberDTO) request.getAttribute("mdto");
	%>

	<br>
	<br>
	
	<a href="./MemberInfo.me">회원 정보 조회</a>
	
	<br>
	<br>
	
	<a href="./MemberUpdate.me">회원 정보 수정</a>
	<!-- 정보 조회와 수정 합치기 의논 -->
	
	<br>
	<br>
	
	<a href="./MemberDelete.me">회원 계정 삭제</a>
	
	<br>
	<br>
	
	<hr>

	<!-- 관리자전용 -->
	<%
	if (id != null) {
		if (id.equals("admin")) {
	%>
			<a href="./MemberList.me">회원 목록 관리(관리자 전용)</a>
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
			<a href="#">영화관 지점 관리(관리자 전용)</a>
	<%	
		}
	}
	%>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>