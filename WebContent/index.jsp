<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>
<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS 연결 -->
<link rel="stylesheet" href="css/main.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

</head>
<body>

	<%@ include file="include/header.jsp" %>

	<div id="wrap">

	<!-- 수정완료 -->
	<%
	// String id = (String) session.getAttribute("id");
	%>
	


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
	
	</div>
	
	<%@ include file="include/footer.jsp" %>
</body>
</html>