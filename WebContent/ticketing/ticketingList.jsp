<%@page import="com.ticketing.db.TicketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 예매 내역 확인</title>
</head>
<body>

	<div id="wrap">
	
	<%@ include file="../include/header.jsp" %>
	
	<%
	List<TicketDTO> list = (List<TicketDTO>) request.getAttribute("bookList");
	%>
	
	<div id="container">
		<table border="1">
			<tr>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>

</body>
</html>