<%@page import="com.mall.db.MallDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 상품 상세 보기</title>

<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS -->
<style type="text/css">
nav>ul>li:NTH-CHILD(5)>ul {
	display: block;
}

#goShopping, #contents {
	border: 1px solid red;
	width: 900px;
	margin: 50px auto;
}

#details {
	border-collapse: collapse;
	width: 100%;
}

#goShopping li {
	margin-top: 15px;
}
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<%
	request.setCharacterEncoding("UTF-8");

	//DTO 객체 저장
	MallDTO mdto = (MallDTO) request.getAttribute("mdto");
	
	%>

	<form action="./MallOrderStar.mor" method="post" id="goShopping">
		<input type="hidden" name="goods_num" value="<%=mdto.getGoods_num()%>">
		<table id="details">
			<tr>
				<td><img src="./upload/<%=mdto.getImage()%>" width="300" height="300"></td>
				<td>
					<ul>
						<li><h2><%=mdto.getName()%></h2></li>
						<li><%=mdto.getPrice()%> 원</li>
						<hr>
						<li>구성<br><%=mdto.getContent()%></li>
						<li>유효기간<br>관람권 6개월 / 상품권 6개월</li>
						<li>
							<input type="number" name="amount" value="1" min="1" max="5" step="1">
							&nbsp;
							<input type="submit" value="구매 하기">
						</li>
						<li><input type="button" value="상품 목록" id="goList"></li>
					</ul>
				</td>
			</tr>
		</table>
	</form>
	
	<div id="contents">
		<span>상세정보</span>
	</div>
	
	<script type="text/javascript">
		document.querySelector('#goList').addEventListener('click', function() {
			location.href = './GoodsList.ml';
		});
	</script>

	<%@ include file="../include/footer.jsp" %>
</body>
</html>