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
<h1>WebContent/costomGoods/costomGoodsDetail.jsp</h1>

<%
	request.setCharacterEncoding("UTF-8");

	//DTO 객체 저장
	MallDTO mdto = (MallDTO)request.getAttribute("mdto");
	
	//제품 상세 페이지 작성
%>

<h1> 제품 상세 페이지</h1>
<form action="" method="post">
	
<table border="1">
	<tr>
		<td><img src="./goodsImageUpload/<%=mdto.getImage()%>" width="300" height="300"></td>
		<td>
			상품명 : <%=mdto.getName() %><br> 
			판매가격 : <%=mdto.getPrice() %><br>
			상품상세 : <%=mdto.getContent() %><br>
			<!-- 구매수량 관련 db컬럼 생성 필요 -->
			구매수량 : <input type="text" name="amount" value="1"><br>
			
				
				<a href="#">[구매하기]</a><br>
				<a href="./GoodsList.ml">[상품 리스트]</a><br>
		</td>
	</tr>
	
</table>
</form>

</body>
</html>