<%@page import="com.ticketing.db.TicketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 예매 내역 확인</title>

<style type="text/css">
table {
	border-collapse: collapse;
}
</style>
</head>
<body>

	<div id="wrap">
	
	<%
	List<TicketDTO> list = (List<TicketDTO>) request.getAttribute("bookList");
	%>
	
	<div id="container">
		<table>
			<tr>
				<td>예매 번호</td>
				<td>예매 날짜</td>
				<td>관람일</td>
			</tr>
			<%
			for (int i = 0; i < list.size(); i++) {
				TicketDTO tdto = list.get(i);
			%>
			<tr>
				<td><a href="./TicketingDetail.ti?book_num=<%=tdto.getBook_num()%>"><%=tdto.getBook_num()%></a></td>
				<td><%=tdto.getSell_date()%></td>
				<td><%=tdto.getDate()%></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	
	</div>

</body>
</html>