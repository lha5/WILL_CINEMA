<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>

<!-- CSS -->
<link rel="stylesheet" href="../css/header.css">

</head>
<body>



	<%
	String id = (String) session.getAttribute("id");
	%>

	<header>
		<div id="social">
			<ul>
				<li>모바일 APP</li>
				<li>페이스북</li>
				<li>유튜브</li>
			</ul>
		</div>
		<div id="my">
			<ul>
				<%if (id != null) {%>
				<li><a href="./MemberLogout.me">로그아웃</a></li>
				<%} else {%>
				<li><a href="./MemberLogin.me">로그인</a></li>
				<%}%>
				<%if (id != null) {%>
				<li><a href="./Main.me">마이시네마</a></li>
				<%} else {%>
				<li><a href="./MemberJoin.me">회원가입</a></li>
				<%}%>
				<li>멤버십</li>
				<li><a href="./FAQContent.af">고객센터</a> </li>
				<li>ENGLISH</li>
			</ul>
		</div>
		<div id="logo">
			(logo image)
		</div>
		
		<hr>
		
		<nav>
			<ul>
				<li>예매</li>
				<li>영화</li>
				<li>영화관</li>
				<li>이벤트</li>
				<li>매점</li>
				<li>VOD</li>
			</ul>
		</nav>
	</header>
	
	
	<hr>
	
	
	
</body>
</html>