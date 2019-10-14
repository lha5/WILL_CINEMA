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
	// response.sendRedirect("./EventSummary.ae");
	response.sendRedirect("./Main.me");
	// response.sendRedirect("./EventWrite.ae");
	
	// String id = (String) session.getAttribute("id");
	
%>
	<div id="wrap">
	
	<jsp:include page="include/header.jsp"/>
	
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
	
	<%@ include file="include/footer.jsp" %>
	</div>
</body>
</html>