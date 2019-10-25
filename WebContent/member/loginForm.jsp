<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 로그인</title>

<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="./css/login.css">

</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<%
	if (id != null) {
		response.sendRedirect("./Main.me");
	}
	%>
	
	<fieldset>
		<legend>로그인</legend>
		<form action="./MemberLoginAction.me" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="로그인"></td>
				</tr>
			</table>
		</form>
	</fieldset>
	
	<!-- --------------------------------------------------------------------------- -->
	
	<div id="socialLogin">
		
	</div>
	
	<!-- --------------------------------------------------------------------------- -->
	
	<div id="signup">
		아직 회원이 아니신가요?
		<br><br>
		<input type="button" value="회원 가입" id="signUpBtn">
	</div>
	
	<!-- 회원 가입 버튼 연결 -->
	<script type="text/javascript">
		const upBtn = document.querySelector('#signUpBtn');
		
		upBtn.addEventListener('click', function() {
			location.href='./MemberJoin.me';
		});
	</script>
	
	<!-- --------------------------------------------------------------------------- -->
	
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>