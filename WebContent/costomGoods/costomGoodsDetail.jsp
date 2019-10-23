<%@page import="com.mall.db.MallDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ include file="../include/header.jsp" %>



	<%
	request.setCharacterEncoding("UTF-8");

	//DTO 객체 저장
	MallDTO mdto = (MallDTO) request.getAttribute("mdto");
	
	//제품 상세 페이지 작성
	%>


	<h1> 제품 상세 페이지</h1>
	<form action="./MallOrderStar.mor" method="post">
		<input type="hidden" name="goods_num" value="<%=mdto.getGoods_num()%>">
		<%-- 
		<input type="hidden" name="goods_name" value="<%=mdto.getName()%>">
		<input type="hidden" name="goods_price" value="<%=mdto.getPrice()%>"> 
		--%>
		<table border="1">
			<tr>
				<td><img src="./goodsImageUpload/<%=mdto.getImage()%>" width="300" height="300"></td>
				<td>
					상품명 : <%=mdto.getName()%><br> 
					판매가격 : <%=mdto.getPrice()%><br>
					상품상세 : <%=mdto.getContent()%><br>
					구매수량 : <input type="number" name="amount" value="1" min="1"><br>
					<br>
					<br>
					<input type="submit" value="구매 하기"><br>
					<input type="button" onclick="location.href='./GoodsList.ml'" value="상품 목록"><br>
				</td>
			</tr>
		</table>
	</form>

	<%@ include file="../include/footer.jsp" %>
</body>
</html>