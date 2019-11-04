<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 아이디 찾기</title>
</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<fieldset>
		<legend>아이디 찾기</legend>
		<form action="./MemberIdSearchAction.me" method="post">
			<table>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" placeholder="example@example.com"></td>
				</tr>
				<tr>
					<td><input type="submit" value="아이디 찾기"></td>
				</tr>
			</table>
		</form>
		
	</fieldset>


	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>