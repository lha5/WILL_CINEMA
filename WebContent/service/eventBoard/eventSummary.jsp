<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	List eventMovieList = (List)request.getAttribute("eventMovieList");
	List eventPreviewList = (List)request.getAttribute("eventPreviewList");
	List eventNeventList = (List)request.getAttribute("eventNeventList");
	List eventCollaboList = (List)request.getAttribute("eventCollaboList");
%>
	<div>
		<h2>영화</h2> <a href="./EventContent.ae?item=movie">더보기</a>
	</div>
	<ul>
		<%for(int i=0; i<eventMovieList.size(); i++){ //영화 카테고리 리스트
			AdminEventDTO aedto=(AdminEventDTO)eventMovieList.get(i);
			if(i>3){break;}
		%>
		<li>
			<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
				<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
			</a>
			<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
		</il>
		<%} %>
	</ul>
	<br>
	<div>
		<h2>시사회/무대인사</h2> <a href="./EventContent.ae?item=preview">더보기</a>
	</div>
	<ul>
		<%for(int i=0; i<eventPreviewList.size(); i++){ //영화 카테고리 리스트
			AdminEventDTO aedto=(AdminEventDTO)eventPreviewList.get(i);
			if(i>3){break;}
		%>
		<li>
			<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
				<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
			</a>
			<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
		</il>
		<%} %>
	</ul>
	<br>
	<div>
		<h2>윌시 NOW</h2> <a href="./EventContent.ae?item=nevent">더보기</a>
	</div>
	<ul>
		<%for(int i=0; i<eventNeventList.size(); i++){ //영화 카테고리 리스트
			AdminEventDTO aedto=(AdminEventDTO)eventNeventList.get(i);
			if(i>3){break;}
		%>
		<li>
			<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
				<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
			</a>
			<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
		</il>
		<%} %>
	</ul>
	<br>
	<div>
		<h2>제휴 할인</h2> <a href="./EventContent.ae?item=collabo">더보기</a>
	</div>
	<ul>
		<%for(int i=0; i<eventCollaboList.size(); i++){ //영화 카테고리 리스트
			AdminEventDTO aedto=(AdminEventDTO)eventCollaboList.get(i);
			if(i>3){break;}
		%>
		<li>
			<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
				<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
			</a>
			<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
		</il>
		<%} %>
	</ul>
	<br>
	<a href="./EventWrite.ae">이벤트 글쓰기</a>
</body>
</html>