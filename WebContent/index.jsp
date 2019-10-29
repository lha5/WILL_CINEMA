<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	response.sendRedirect("Index.me");
	%>

	<%@ include file="include/header.jsp" %>

	<div id="wrap">

	<!-- 수정완료 -->
	
		<section>

			<div id="center">
				<article id="list">
					예매 순위
				</article>
				<article id="image">
					<%@include file="./movie/screening.jsp" %>
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