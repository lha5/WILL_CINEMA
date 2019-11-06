<%@page import="java.util.List"%>
<%@page import="com.member.db.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 아이디 찾기</title>

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
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<%
	// request.setAttribute("mdto", mdto);
	List<MemberDTO> idList = (List<MemberDTO>) request.getAttribute("idList");
	%>

	<div id="container">
	<%
		for (int i = 0; i < idList.size(); i++) {
			MemberDTO mdto = idList.get(i);
	%>
		<h3><%=mdto.getName()%>님의 아이디는</h3>
		<h3><%= mdto.getId()%> 입니다.</h3>
			
	<%
		}
	%>
		
		<br><br>
	
		<input type="button" value="로그인" id="goLogin">
		&nbsp;&nbsp;
		<input type="button" value="비밀번호 찾기" id="figureOutPassword">
	</div>
	
	
	<!-- 로그인, 비밀번호 찾기 이동 -->
	<script type="text/javascript">
		document.querySelector('#goLogin').addEventListener('click', function() {
			location.href='./MemberLogin.me';
		});
		
		document.querySelector('#figureOutPassword').addEventListener('click', function() {
			location.href='./MemberPassSearch.me';
		});
	</script>
	
	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>