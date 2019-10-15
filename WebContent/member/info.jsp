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

<%

String id = (String) session.getAttribute("id");  

if (id == null) {
	response.sendRedirect("./MemberLogin.me");
}

MemberDTO mdto = (MemberDTO) request.getAttribute("mdto");

%>

< <table border="1">
	<tr>
		<td>아이디</td>
		<td><%=mdto.getId() %></td>
		<td>성명</td>
		<td><%=mdto.getName() %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td></td>
		<td>생년월일</td>
		<td><%=mdto.getBirthday() %></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><%=mdto.getMobile() %></td>
		<td>이메일</td>
		<td><%=mdto.getEmail() %></td>
	</tr>
	<tr>
		<td>주소</td><!-- null값 치환하기 -->
		<td colspan="3"><%=mdto.getZipcode() %> <%=mdto.getAddr() %> <%=mdto.getDetailaddr() %></td>
	</tr>
	<tr>
		<td>회원 등급</td>
		<td><%=mdto.getLevel() %></td>
		<td>포인트</td>
		<td><%=mdto.getPoint() %></td>
	</tr>
	<tr>
		<td>선호 장르</td>
		<td><%=mdto.getPreference() %></td>
		<td>가입 날짜</td>
		<td><%=mdto.getReg_date() %></td>
	</tr>
</table> 

<br>
	
	<br>
	<a href="./MemberUpdate.me">회원 정보 수정</a>
	<!-- 정보 조회와 수정 합치기 의논 -->
	<br>
	<br>
	<a href="./MemberDelete.me">회원 계정 삭제</a>
	<br>
	<br>
	<a href="./QnAList.sq">1:1 문의하기</a>
	<br>
	<br>
	<hr>

	<!-- 관리자전용 -->

	<%
	if (id != null) {
		if (id.equals("admin")) {
			%>
			<a href="./MemberList.me">회원 목록 관리(관리자 전용)</a>
			<%	
		}
	}
	%>





</body>
</html>