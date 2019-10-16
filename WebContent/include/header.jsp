<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>

<!-- CSS -->
<link rel="stylesheet" href="../css/header.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

</head>
<body>



	<%
	String id = (String) session.getAttribute("id");
	%>

	<header>
		
		<div id="social">
			<ul>
				<li><i class="fas fa-mobile-alt"></i> 모바일 APP</li>
				<li><i class="fab fa-facebook-square"></i> 페이스북</li>
				<li><i class="fab fa-youtube"></i> 유튜브</li>
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
				<li><a href="./FAQList.af">고객센터</a></li>
				<li>ENGLISH</li>
			</ul>
		</div>
		
		<div class="top_space"><!-- 구역 분리를 위한 태그 --></div>
		
		<div id="logo">
			<!-- <img alt="logo" src="img/logo.png" width="230"> -->
			<i class="fas fa-film fa-2x"></i> <span>WILL CINEMA</span>
		</div>
		
		
		
		<nav>
			<ul>
				<li>
					예매
					<ul>
						<li>예매하기</li>
						<li>상영시간표</li>
						<li>할인안내</li>
					</ul>
				</li>
				<li>
				영화
				<ul>
					<li>박스오피스</li>
					<li>기획전</li>
					<li>영화의전당</li>
				</ul>
				</li>
				<li>영화관
					<ul>
						<li>서울</li>
						<li>경기/인천</li>
						<li>충청/대전</li>
						<li>전라/광주</li>
						<li>경북/대구</li>
						<li>경남/부산/울산</li>
						<li>강원</li>
						<li>제주</li>
					</ul>
				</li>
				<li>
					<li><a href="./EventSummary.ae">이벤트</a></li>
				</li>
				<li><a href="./GoodsList.ml">매점</a></li>
				<li>VOD</li>
			</ul>
						
		</nav>
	</header>
	
	
	
</body>
</html>