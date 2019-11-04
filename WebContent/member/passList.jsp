<%@page import="com.member.db.MemberDTO"%>
<%@page import="java.util.List"%>
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

<%
	// request.setAttribute("mdto", mdto);
	List<MemberDTO> passList = (List<MemberDTO>) request.getAttribute("passList");
	
	// 표를 생성하여 회원 정보를 출력
%>

	<table border="1">
	<%
		for (int i = 0; i < passList.size(); i++) {
			MemberDTO mdto = passList.get(i);
	%>
		<tr>
			<td><%= mdto.getPass() %></td>
		</tr>
	<%
		}
	%>
	</table>
	
	<input type="button" value="로그인" onclick="location.href='./MemberLogin.me'">

	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>