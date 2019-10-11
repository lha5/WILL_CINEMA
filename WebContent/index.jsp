<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>
<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS 연결 -->
<link rel="stylesheet" href="./css/main.css">
</head>
<body>
<%
	// response.sendRedirect("./Main.me");
	// response.sendRedirect("./EventWrite.ae");
%>
<div id="wrap">
	
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
				<li>로그인</li>
				<li>회원가입</li>
				<li>멤버십</li>
				<li>고객센터</li>
				<li>ENGLISH</li>
			</ul>
		</div>
		<div id="logo">
			로고 이미지
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
	
	
	<section>
		
		<article id="list">
			예매 순위
		</article>
		
		<article id="image">
			현재 상영작 이미지
		</article>
		
		<div id="clear">
			<!-- 구역 분리를 위한 태그 -->
		</div>
		
		<div id="event">
			이벤트
		</div>
		
		<div id="service">
			멤버십이나 포인트 같은 서비스 모음
		</div>
		
		<div id="notice">
			공지사항
		</div>
		
	</section>
	
	
	
	<div id="clear">
		<!-- 구역 분리를 위한 태그 -->
	</div>
	
	
	
	<br>
	<br>
	
	
	
	<footer>
		<div id="sub_logo">
			로고 이미지
		</div>
		
		<div id="family_site">
			<select>
				<option selected disabled>패밀리 사이트</option>
				<option>아이티윌 그룹</option>
				<option>아이티윌 강남센터</option>
				<option>아이티윌 부산센터</option>
			</select>
		</div>
		
		<div id="sub_menu">
			<ul>
				<li>회원약관</li>
				<li>개인정보처리방침</li>
				<li>이메일무단수집거부</li>
				<li>운영·관리방침</li>
				<li>W.POINT회원안내</li>
				<li>채용안내</li>
				<li>기업정보</li>
				<li>윤리경영</li>
			</ul>
		</div>
		
		<div id="sub_info">
			<ul>
				<li>부산광역시 부산진구 동천로 109 삼한골든게이트 7층 아이티윌 부산센터</li>
				<li>고객센터 0000-0000</li>
				<li>대표이사 아이티</li>
				<li>사업자등록번호 000-00-00000</li>
				<li>통신판매업신고번호 제 0000호</li>
				<li>개인정보 보호책임자 아이티</li>
			</ul>
		</div>
		
		<div id="copy">
			COPYRIGHT© WILL CINEMA ALL RIGHT RESERVED SINCE 2019
		</div>
	</footer>
</div>
</body>
</html>