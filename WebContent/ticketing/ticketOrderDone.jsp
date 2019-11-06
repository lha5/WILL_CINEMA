<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
		<%@ include file="../include/header.jsp" %>

		<%
		// 주소줄에 있는 정보 받아오기
		// String trans_num = request.getParameter("trans_num");
		%>
		
		<div>
			<h2>구매가 완료되었습니다.</h2>
			<h2>저희 WILL CINEMA를 이용해주셔서 대단히 감사드립니다.</h2>
			<h3><a href="./Main.me">마이시네마 페이지로 이동하기</a></h3>
			<%-- <h2>구매 번호 : <a href="./MallOrderDetail.mor?trans_num=<%=trans_num%>"><%=trans_num%></a></h2> --%>
		</div>
		<%@ include file="../include/footer.jsp" %>
	</div>
</body>
</html>