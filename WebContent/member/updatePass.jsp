<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 비밀번호 변경</title>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<%
		if (id == null) {
			response.sendRedirect("./MemberLogin.me");
		}
	%>
	
	<form action="./MemberPassCheckAction.me" method="post">
		<table border="1">
			<tr>
				<td>회원 정보 보호를 위해 지금 사용중이신 비밀번호를 한번 더 입력해주세요.</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="id" value="<%=id%>">
					<input type="password" name="pass">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="확인">
					&nbsp;&nbsp;
					<input type="button" value="뒤로 가기" onclick="history.back();">
				</td>
			</tr>
		</table>
	</form>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>