<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 결제완료</title>
<style type="text/css">
@font-face {
	font-family: 'NanumGothic';
	src: url('../font/NanumGothic.ttf') format('truetype');
}

.ri-checkbox-circle-line {
	color: #2ae853;
}

#done {
	width: 700px;
	margin: 50px auto;
	text-align: center;
	font-family: NanumGothic;
	color: #1c1c1c;
}

span {
	font-size: 1.2em;
}

#thanks {
	font-size: 18px;
}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../include/header.jsp" %>
	<div id="done">
			<i class="ri-checkbox-circle-line ri-5x"></i>
			<br>
			<br>
			<h2>발권이 완료되었습니다.</h2>
			<br>
			<div id="thanks">저희 WILL CINEMA를 이용해주셔서 대단히 감사드립니다.</div>
			<br><br>
			<span><a href="./Main.me">마이시네마 페이지로 이동하기</a></span>
	</div>
		<%@ include file="../include/footer.jsp" %>
	</div>
</body>
</html>