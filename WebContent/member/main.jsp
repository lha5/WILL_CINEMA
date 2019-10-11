<%@page import="com.member.db.MemberDAOImpl"%>
<%@page import="com.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- CSS -->
<link rel="stylesheet" href="../css/mypage.css">

<title>WILL CINEMA - 마이 페이지</title>
</head>
<body>

<%

	String id = (String) session.getAttribute("id");

	if (id == null) {
		response.sendRedirect("./MemberLogin.me");
	}

%>
	<div id="wrap">
	
	<jsp:include page="../include/header.jsp"/>
	
	<section id="sec01">
		<h2 class="mc">마이시네마</h2>
		<table>
			<tr>
				<td colspan="2">
					<%=id%>님, 환영합니다!
				</td>
			</tr>
			<tr>
				<td>
					<h3>W.POINT</h3>
					<div id="look_point">조회하기</div><!-- ajax로 구현 -->
					<div id="availability">가능하면[사용가능]/불가하면[사용불가]</div>
					<div id="left_point">조회하기누르면뜨게</div>
					<ul>
						<li>남은 W.POINT가 100P 이상이면 즉시 사용할 수 있습니다.</li>
						<li>본인 카드에 한하여 등록 및 포인트 조회가 가능합니다.</li>
					</ul>
				</td>
				<td>
					<div id="ranking">
						<h2><%=id%>님의 현재 등급은<br>OOO입니다.</h2>
					</div>
				</td>
			</tr>
		</table>
	</section>
	
	
	
	<!-- 각 메뉴를 클릭하면 페이지가 달라지게 Ajax로 구현하기 -->
	<section id="sec02">
		<div id="my_menu">
			<ul>
				<li><a href="#">예매내역</a></li>
				<li><a href="#">구매내역</a></li>
				<li><a href="#">멤버십</a></li>
				<li><a href="#">내가 본 영화</a></li>
				<li><a href="#">내 정보 관리</a></li>
			</ul>
		</div>
	</section>

	<div id="contents">
		(내용 들어오는 곳)
	</div>
	
	<jsp:include page="../include/footer.jsp"/>
	</div>
</body>
</html>