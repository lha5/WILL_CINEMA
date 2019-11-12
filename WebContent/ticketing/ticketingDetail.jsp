<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.ticketing.db.TicketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 예매 내역 상세</title>

<!-- CSS -->
<style type="text/css">
#container {
	/* border: 1px solid lime; */
	width: 910px;
	margin: 10px auto 50px auto;
}

#ttl {
	/* border: 1px solid aqua; */
	font-size: 1.5em;
	font-weight: bold;
	margin: 5px auto;
}

table {
	border-collapse: collapse;
	border: 2px solid #e6e6e6;
	width: 900px;
	margin: 20px auto;
}

td {
	padding: 20px 12px;
	height: 200px
}

td:NTH-CHILD(2) {
	width: 220px;
}

td:NTH-CHILD(3) {
	width: 350px;
}

#title {
	font-size: 1.5em;
}

#list li {
	margin: 5px;
	padding: 2px 2px 7px 2px;
	line-height: 2em;
}

.tag {
	border: 1px solid #1c1c1c;
	background-color: #1c1c1c;
	padding: 2px;
	color: #ffffff;
	width: 65px;
	letter-spacing: 1px;
	margin-right: 10px;
	text-align: center;
	font-size: 14px;
}

a>#goList {
	width: 100%;
	text-align: center;
	background-color: #d7282d;
	height: 20px;
	color: #ffffff;
	font-weight: 500;
	padding-top: 10px;
	padding-bottom: 10px;
}

#caution {
	padding: 15px;
}

#caution li {
	margin: 7px 2px;
}
</style>

</head>
<body>
	
	<div id="wrap">
	
	<%@ include file="../include/header.jsp" %>
	
	<%
	TicketDTO tdto  = (TicketDTO) request.getAttribute("tdto");
	AdminMovieDTO amdto = (AdminMovieDTO) request.getAttribute("amdto");
	CineDTO cdto = (CineDTO) request.getAttribute("cdto");
	String src = (String) request.getAttribute("src");
	%>
	
	<fmt:formatNumber type="number" var="price" maxFractionDigits="3" value="<%=tdto.getPrice()%>" />
	
	<div id="container">
		<span id="ttl">예매 내역 상세</span>
		<table id="list">
			<tr>
				<td>
					<img alt="poster" src="./upload/<%=amdto.getPoster()%>" width="170px">
				</td>
				<td>
					<span id="title"><a href="./DetailView.mo?movie_num=<%=tdto.getMovie_num()%>"><%=amdto.getTitle()%></a></span>
					<br>
					<br>
					<a href="./CinemaUserView.ci?cinema_num=<%=tdto.getCinema_num()%>">윌시네마 <%=cdto.getName()%></a>(<%=cdto.getRegion()%>)
				</td>
				<td>
					<ul>
						<li><div class="tag">예매번호</div><%=tdto.getBook_num()%></li>
						<li><div class="tag">관람일</div><%=tdto.getDate()%>&nbsp;<%=tdto.getDay()%>요일</li>
						<li><div class="tag">시&emsp;간</div><%=tdto.getRunnging_time() %></li>
						<li><div class="tag">인&emsp;원</div><%=tdto.getPerson_num()%></li>
						<li><div class="tag">가&emsp;격</div>${price}원</li>
						<li><div class="tag">좌석정보</div><%=tdto.getRoom()%>관 | <%=tdto.getSeat()%></li>
					</ul>
				</td>
			</tr>
		</table>
		<div id="caution">
			<h2>유의 사항</h2>
			<ul>
				<li>모바일티켓에는 티켓 수령에 필요한 내용이 안내되어있습니다.</li>
				<li>모바일티켓을 실물 티켓으로 대신할 수 있습니다.</li>
				<li>※예매번호로 발권 조회가 가능하므로 잃어버리지 않도록 주의하세요.</li>
			</ul>
		</div>
		<a href="./MyInfoPage.me"><div id="goList">뒤로 가기</div></a>
	</div>

	<%@ include file="../include/footer.jsp" %>
	
	</div>
</body>
</html>