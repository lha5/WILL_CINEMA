<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.ticketing.db.TicketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 예매 내역 상세</title>
</head>
<body>
	
	<div id="wrap">
	
	<%@ include file="../include/header.jsp" %>
	
	<%
	TicketDTO tdto  = (TicketDTO) request.getAttribute("tdto");
	AdminMovieDTO amdto = (AdminMovieDTO) request.getAttribute("amdto");
	CineDTO cdto = (CineDTO) request.getAttribute("cdto");
	%>

	<div id="container">
		<table border="1">
			<tr>
				<td>
					<img alt="poster" src="<%=amdto.getPoster()%>" width="170px">
				</td>
				<td>
					<span id="title"><%=amdto.getTitle()%></span>
					<br>
					<br>
					윌시네마 - <%=cdto.getName()%>
				</td>
				<td>
					<ul>
						<li><span id="tag">예매번호</span><%=tdto.getBook_num()%></li>
						<li><span id="tag">관람일</span><%=tdto.getDate()%>&nbsp;<%=tdto.getDay()%></li>
						<li><span id="tag">시간</span><%=tdto.getRunnging_time() %></li>
						<li><span id="tag">인원</span><%=tdto.getPerson_num()%></li>
						<li><span id="tag">가격</span><%=tdto.getPrice()%>원</li>
						<li><span id="tag">좌석정보</span><%=tdto.getRoom()%>관 / <%=tdto.getSeat()%></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>

	<%@ include file="../include/footer.jsp" %>
	
	</div>
</body>
</html>