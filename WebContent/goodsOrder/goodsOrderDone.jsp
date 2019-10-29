<%@page import="java.util.List"%>
<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 구매 완료</title>
</head>
<body>


	<div id="wrap">
		<%@ include file="../include/header.jsp" %>

		<%
		List<MallOrderDTO> orderDone = (List<MallOrderDTO>) request.getAttribute("doneCheck");
		
		System.out.println("구매 완료 값 확인 : " + orderDone);
		%>
		
		<div>
			<h1>구매가 완료되었습니다.</h1>
			<h3>구매한 내역은 아래와 같습니다.</h3>
		</div>
	
		<div>
			<table border="1">
				<tr>
					<td>구매 상품명</td>
					<td>구매 수량</td>
					<td>총 금액</td>
					<td>코드 번호</td>
					<td>구매 일자</td>
				</tr>
				<%
				for (int i = 0; i < orderDone.size(); i++) {
					MallOrderDTO modto = orderDone.get(i);
				%>
					<tr>
						<td><%=modto.getGoods_name()%></td>
						<td><%=modto.getGoods_amount()%></td>
						<td><%=modto.getPrice()%></td>
						<td><%=modto.getBarcode()%></td>
						<td><%=modto.getOrder_date()%></td>
					</tr>
				<%
				}
				%>
			</table>
		</div>
	
	
	
	

		<%@ include file="../include/footer.jsp" %>
	</div>
	
</body>
</html>