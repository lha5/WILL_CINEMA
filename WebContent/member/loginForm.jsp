<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 로그인</title>

<!-- CSS -->
<link rel="stylesheet" href="./css/login.css">

<!-- Kakao SDK -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
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
	
	<div id="kakao_login">
		<!-- <img alt="kakao-login" src="./img/kakao_account_login_btn.png"> -->
		<a id="kakao-login-btn"></a>
    	<a href="http://developers.kakao.com/logout"></a>
    	
    	<script type='text/javascript'>
      	//<![CDATA[
        // 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('28a0d30bd1293f762f5631e0fcb68f57');
        
        // 카카오 로그인 버튼을 생성합니다.
        Kakao.Auth.createLoginButton({
          container: '#kakao-login-btn',
          	success: function(authObj) {
          		console.log(authObj.access_token);
          		console.log(res.id);
            	/* alert(JSON.stringify(authObj)); */
          	},
          	fail: function(err) {
             	alert(JSON.stringify(err));
        	}
        });
        
        Kakao.Auth.setAccessToken(accessTokenFromServer);
		//]]>
		</script>
	</div>
	
	<div id="signup">
		아직 회원이 아니신가요?
		<br><br>
		<input type="button" value="회원 가입" onclick="location.href='./MemberJoin.me'">
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>