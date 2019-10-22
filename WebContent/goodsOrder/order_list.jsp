<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 주문 확인</title>
</head>
<body>
	
	<%
	List<MallOrderDTO> orderList = (List<MallOrderDTO>) request.getAttribute("orderList");
	%>

	<%@ include file="../include/header.jsp" %>

	<div id="wrap">
	
		<h2>주문한 내역</h2>
		
		<table border="1">
			<tr>
				<td>주문 번호</td>
				<td>구매 상품</td>
				<td>주문 갯수</td>
				<td>금액</td>
				<td>주문 일시</td>
			</tr>
			<%
			for (int i = 0; i < orderList.size(); i++) {
				MallOrderDTO modto = orderList.get(i);
			%>
				<tr>
					<td><a href="./MallOrderDetail.mor?order_num=<%=modto.getOrder_num()%>"><%=modto.getOrder_num()%></a></td>
					<td><%=modto.getGoods_name()%></td>
					<td><%=modto.getGoods_amount()%></td>
					<td><%=modto.getPrice() %>원</td>
					<td><%=modto.getOrder_date()%></td>
				</tr>			
			<%
			}
			%>
		</table>
	
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>