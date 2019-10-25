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

<!-- CSS -->
<link rel="stylesheet" href="./css/login.css">

</head>
<body>
	<%@ include file="../include/header.jsp" %>

	<fieldset>
		<legend> 로그인 </legend>
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
	
	<%
	    String clientId = "Mr5O2cXhrQAjllHFhU3X";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    session.setAttribute("state", state);
	%>
	
	<div id="socialLogin">
		<a href="<%=apiURL%>"><img height="50px" alt="네이버로그인 버튼" src="./img/Naver_login_btn.PNG"/></a>
	</div>
	
	<div id="signup">
		아직 회원이 아니신가요?
		<br><br>
		<input type="button" value="회원 가입" id="signUpBtn">
	</div>
	
	<script type="text/javascript">
		const upBtn = document.querySelector('input[type=button]');
		
		upBtn.addEventListener('click', function() {
			location.href='./MemberJoin.me';
		});
	</script>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>