<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 구매 확인</title>
<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS -->
<style type="text/css">
#list {
	border-collapse: collapse;
	border: 1px solid #1c1c1c;
	width: 700px;
	margin: 50px auto;
}
</style>

</head>
<body>
	
	<%
	String id = (String) request.getAttribute("id");
	
	List<MallOrderDTO> orderList = (List<MallOrderDTO>) request.getAttribute("orderList");
	%>


	<div id="wrap">
	
		<table id="list">
			<tr>
				<td id="transcNo">주문 번호</td>
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
					<td><a href="./MallOrderDetail.mor?trans_num=<%=modto.getTrans_num()%>"><%=modto.getTrans_num()%></a></td>
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
	
</body>
</html>