<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>WILL CINEMA - 로그인</title>

<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="./css/login.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<!-- <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> -->
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<%
	if (id != null) {
		response.sendRedirect("./Index.me");
	}
	
	String clientId = "zbWDmpR7Dt9oKkuZ8yzZ";//애플리케이션 클라이언트 아이디값"; // 후에 수정시 자신이 발급밭은 아이디로 변경
	// 후에 서버에 올라갈시 URL 변경 필요
    String redirectURI = URLEncoder.encode("http://localhost:8088/WillCinema/MemberNaverLogin.me", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
	
	%>
	
	<fieldset>
		<span id="inin">회원 로그인</span>
		<form action="./MemberLoginAction.me" method="post">
			<table>
				<tr>
					<td><label><i class="ri-user-line ri-1g"></i> 아이디</label></td>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<td><label><i class="ri-lock-password-fill ri-1g"></i> 비밀번호</label></td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td colspan="2">
<%-- <<<<<<< HEAD
						<input type="submit" value="로그인">
			<!-- 네이버 아이디 로그인 -->
			<a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
			<!-- /네이버 아이디 로그인 -->
			<!-- 카카오톡 로그인 -->
			<!-- <a id="custom-login-btn" href="javascript:loginWithKakao()">
			<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
			<input type="hidden" name="kakaoValue" value="">
			</a> -->
			<!-- /카카오톡 로그인 -->		
=======
>>>>>>> branch '박찬일' of https://github.com/lha5/WILL_CINEMA.git --%>
						<input type="submit" value="로그인">		

					</td>
				</tr>
			</table> 
		</form>
		
		<input type="button" value="비회원" onclick="location.href='./non_member/non_memberlogin.jsp'">
		
		
		<div id="forgot">
			<p>계정 아이디 또는 비밀번호를 잊으셨나요?</p>
			<br>
			<a href="./MemberIdSearch.me">아이디 찾기</a>
			&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="./MemberPassSearch.me">비밀번호 찾기</a>
		</div>
	</fieldset>
	
	<%-- <div id="socialLogin">
		<!-- 네이버 아이디 로그인 -->
		<a href="<%=apiURL%>"><img height="50" src="./img/Naver_login_btn.PNG" width="300"/></a>
		<!-- /네이버 아이디 로그인 -->
		<br><br>
		<!-- 카카오톡 로그인 -->
		<a id="custom-login-btn" href="javascript:loginWithKakao()">
			<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
		</a>
		<!-- /카카오톡 로그인 -->
	</div> --%>
	
	
	
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
	
	<!-- 카카오톡 로그인 스크립트 
		https://developers.kakao.com/docs/js/kakaologin
	-->
	<!-- <script type='text/javascript'>
		//<![CDATA[
		   // 사용할 앱의 JavaScript 키를 설정해 주세요.
		   Kakao.init('cd3590b07e55c69b37d015bdadb57b99');
		   function loginWithKakao() {
		     // 로그인 창을 띄웁니다.
		     Kakao.Auth.login({
		       success: function(authObj) {		    	   
		         //alert(JSON.stringify(authObj));
		       },
		       fail: function(err) {
		    	 alert("카카오톡 로그인이 실패하였습니다.");
		         //alert(JSON.stringify(err));
		       }
		     });
		   };
		// ]]> 
	</script> -->
	<!-- /카카오톡 로그인 스크립트 -->
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>