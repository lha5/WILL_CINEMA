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

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
</head>
<body>
<%
	// response.sendRedirect("./EventSummary.ae");
	// response.sendRedirect("./Main.me");
	// response.sendRedirect("./EventWrite.ae");
	
	// String id = (String) session.getAttribute("id");
	
%>
	<div id="wrap">
	
	<%-- <jsp:include page="include/header.jsp"/> --%>
	
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
				<li>고객센터</li>
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
					이벤트
					<ul>
						<li>영화</li>
						<li>시사회/무대인사</li>
						<li>제휴할인</li>
						<li>진행중이벤트</li>
					</ul>
				</li>
				<li>매점</li>
				<li>VOD</li>
			</ul>
						
		</nav>
	</header>
	
	
	
	<section>
		<div id="center">
			<article id="list">
				예매 순위
			</article>
		
			<article id="image">
				현재 상영작 이미지
			</article>
		</div>
		<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
		<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
		
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
	
	
	
	<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
	
	<br>
	<br>
	
	<%-- <%@ include file="include/footer.jsp" %> --%>
	
	<br>
	<footer>
		<div id="sub_logo">
			<i class="fas fa-film fa-2x"></i> <span>WILL CINEMA</span>
		</div>
		
		<div id="family_site">
			<select>
				<option selected>패밀리 사이트</option>
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
				<li>고객센터 0000-0000&nbsp;&nbsp;대표이사 아이티&nbsp;&nbsp;개인정보 보호책임자 아이티&nbsp;&nbsp;사업자등록번호 000-00-00000&nbsp;&nbsp;통신판매업신고번호 제 0000호</li>
			</ul>
		</div>
		
		<div id="copy">
			COPYRIGHT© WILL CINEMA ALL RIGHT RESERVED SINCE 2019
		</div>
	</footer>
	</div>
</body>
</html>