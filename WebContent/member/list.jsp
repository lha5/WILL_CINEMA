<%@page import="java.util.ArrayList"%>
<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ include file="../include/header.jsp" %>

	
	<hr>
	
	<%
	// String id = (String)session.getAttribute("id");
	// 관리자가 로그인 했을 때만 진행
	if (id == null || !id.equals("admin")) {
		response.sendRedirect("./Main.me");
	}
	
	// 저장된 회원 목록 가져오기
	// request.setAttribute("mdto", mdto);
	ArrayList<MemberDTO> memberList = (ArrayList<MemberDTO>) request.getAttribute("memberList");
	
	// 표를 생성하여 회원 정보를 출력
	%>
	
	<table border="1">
		<tr>
			<td>아이디</td>
			<td>성함</td>
			<td>생년월일</td>
			<td>전화번호</td>
			<td>이메일</td>
			<td>우편번호</td>
			<td>주소</td>
			<td>보유 포인트</td>
			<td>등급</td>
			<td>광고성 메일 수신 여부</td>
			<td>가입 일자</td>
		</tr>
	<%
		for (int i = 0; i < memberList.size(); i++) {
			MemberDTO mdto = memberList.get(i);
	%>
		<tr>
			<td><%= mdto.getId() %></td>
			<td><%= mdto.getName() %></td>
			<td><%= mdto.getBirthday() %></td>
			<td><%= mdto.getMobile() %></td>
			<td><%= mdto.getEmail() %></td>
			<td><%= mdto.getZipcode() %></td>
			<td><%= mdto.getAddr() + " " + mdto.getDetailaddr()%></td>
			<td><%= mdto.getPoint() %></td>
			<td><%= mdto.getLevel() %></td>
			<td><%= mdto.getReceive() %></td>
			<td><%= mdto.getReg_date() %></td>
		</tr>
	<%
		}
	%>
	</table>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>