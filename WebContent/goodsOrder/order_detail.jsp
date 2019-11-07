<%@page import="com.mall.db.MallDTO"%>
<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 구매 내역 상세</title>

<!-- CSS -->
<style type="text/css">
#sec {
	border: 1px solid red;
	width: 800px;
	margin: 50px auto;
}

#sec>table {
	border-collapse: collapse;
	border: 1px solid #1c1c1c;
	width: 700px;
	margin: 50px auto;
}

/* 티켓 만들기
#tkSec {
	width: 500px;
	height: 200px;
	margin: 50px auto;
	border: 1px solid #d7282d;
	background-color: #d7282d;
}

#ttl {
	float: right;
	margin: 15px;
	font-family: Jalnan;
	font-size: 1.4em;
	color: #ffffff;
	letter-spacing: 1px;
}

#inf {
	margin: 50px 0px 10px 35px;
	color: #ffcf33;
}

#inf>span {
	font-family: NanumGothic;
	font-size: 1.2em;
	font-weight: 500;
} 
*/
</style>

</head>
<body>

	<%
	List mallOrderDetail = (List) request.getAttribute("mallOrderDetail");
	String imgSrc = "";
	MallDTO mdto = (MallDTO) request.getAttribute("mdto");
	%>


	<div id="wrap">
	
	<%@ include file="../include/header.jsp" %>
	
	<section id="sec">
	<h2>구매 상세 내역</h2>
	<table>
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
			//imgSrc = modto.getBarcode_img().substring(42);	// 주소 필요한 만큼 잘라내기
		%>
		<tr>
		
			<td><%=modto.getTrans_num()%></td>
			<td><%=modto.getOrder_date()%></td>
			<td><%=modto.getGoods_name() %></td>
			<td><%=modto.getGoods_amount()%></td>
			<td>카카오페이</td>
			<td><%=modto.getPrice()%>원</td>
			<td>
				<%-- <img alt="바코드 교환권" src=".<%=imgSrc%>"> --%>
				<br>
				<%=modto.getBarcode()%>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	</section>
	
	<!-- <div id="tkSec">
		<div id="ttl">WILL CINEMA</div>
		<div id="inf">
			<i class="ri-vidicon-2-line ri-5x"></i><br>
			<span>MOVIE TICKET</span><br>
			<span>영화관람권</span>
		</div>
	</div> -->
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>