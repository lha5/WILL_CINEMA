<%@page import="com.member.db.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 비밀번호 찾기</title>

<!-- CSS -->
<style type="text/css">
@font-face {
	font-family: 'NanumGothic';
	src: url('../font/NanumGothic.ttf') format('truetype');
}

#container {
	width: 500px;
	margin: 100px auto 150px auto;
	text-align: center;
	font-family: NanumGothic;
	color: #240e04;
}

input[type=button] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #240e04;
	/* border-radius: 2px; */
	background-color: #ffffff;
	font-family: inherit;
	font-size: 16px;
	color: #240e04;
	letter-spacing: 2px;
}

p {
font-size: 12px;
}

#ctt {
line-height: 1.2em;
}
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<%
	// request.setAttribute("mdto", mdto);
	List<MemberDTO> passList = (List<MemberDTO>) request.getAttribute("passList");
	%>
	<div id="container">
	<%
	for (int i = 0; i < passList.size(); i++) {
		MemberDTO mdto = passList.get(i);
		
		// 비밀번호가 노출이 안되게 *로 치환
		int lengthOfPw = mdto.getPass().length();
		String pw1 = new String(new char[lengthOfPw / 2]).replace("\0", "*");
		String pw2 = mdto.getPass().substring(lengthOfPw/2);
	%>
		<span id="ctt">
		<h3><%=mdto.getId()%>님의 비밀번호는</h3>
		<%=pw1%><%=pw2%> 입니다.
		<br><br>
		<p>(개인 정보 보호를 위해 비밀번호 일부가 암호화 되었습니다.)</p>
		</span>
	<%
	}
	%>
	<br>
	<br>
	<input type="button" value="로그인" id="goLogin">
	</div>
	
	<!-- 로그인 버튼 -->
	<script type="text/javascript">
		document.querySelector('#goLogin').addEventListener('click', function() {
			location.href='./MemberLogin.me';
		});
	</script>

	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>