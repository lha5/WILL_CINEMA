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
		// 주소줄에 있는 정보 받아오기
		String trans_num = request.getParameter("trans_num");
		%>
		
		<div>
			<h3>구매가 완료되었습니다.</h3>
			<h1>구매 번호 : <a href="./MallOrderDetail.mor?trans_num=<%=trans_num%>"><%=trans_num%></a></h1>
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
			</table>
		</div>
	
	
	
	

		<%@ include file="../include/footer.jsp" %>
	</div>
	
</body>
</html>