<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 구매 내역 상세</title>
</head>
<body>

	<%
	List mallOrderDetail = (List) request.getAttribute("mallOrderDetail");
	System.out.println("mallOrderDetail 작동 테스트" + mallOrderDetail.get(0));
	%>

	<%@ include file="../include/header.jsp" %>

	<div id="wrap">
	
	<h2>구매 상세 내역</h2>
	
	<table border="1">
		<tr>
			<td>구매 번호</td>
			<td>구매 일자</td>
			<td>구매한 상품</td>
			<td>수량</td>
			<td>지불 방식</td>
			<td>총 가격</td>
			<td>주문 코드 번호</td>
		</tr>
		<%
		for (int i = 0; i < mallOrderDetail.size(); i++) {
			MallOrderDTO modto = (MallOrderDTO) mallOrderDetail.get(i);
			
			String payment = "";
			if (modto.getPayment().equals("Kakao")) {
				payment = "카카오페이";
			}
		%>
		<tr>
		
			<td><%=modto.getTrans_num()%></td>
			<td><%=modto.getOrder_date()%></td>
			<td><%=modto.getGoods_name() %></td>
			<td><%=modto.getGoods_amount()%></td>
			<td><%=payment%></td>
			<td><%=modto.getPrice()%>원</td>
			<td>
				<%=modto.getBarcode()%>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>