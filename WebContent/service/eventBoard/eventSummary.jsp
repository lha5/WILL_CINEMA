<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 이벤트</title>
<!-- CSS -->
<link rel="stylesheet" href="././css/eventsummary.css">
<style type="text/css">
.ctgr {
	padding: 5px;
	padding-left: 3px;
	letter-spacing: 2px;
	font-size: 1.3em;
	font-weight: 500;
}
</style>

</head>
<body>
	
	<%@ include file="/include/header.jsp" %>

	<%
	List eventMovieList = (List)request.getAttribute("eventMovieList");
	List eventPreviewList = (List)request.getAttribute("eventPreviewList");
	List eventNeventList = (List)request.getAttribute("eventNeventList");
	List eventCollaboList = (List)request.getAttribute("eventCollaboList");
	%>


	<div class="event_cwrap"> 
		<div class="more">
			<span class="ctgr">영화</span><span><a href="./EventContent.ae?item=movie">더보기</a></span>
		</div>
			<ul class="event_list">
				<%for(int i=0; i<eventMovieList.size(); i++){ //영화 카테고리 리스트
					AdminEventDTO aedto=(AdminEventDTO)eventMovieList.get(i);
					if(i>3){break;}//4줄까지만 보여주기
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
			<br>
			<br>
			<div class="more">
				<span class="ctgr">시사회/무대인사</span><span><a href="./EventContent.ae?item=preview">더보기</a></span>
			</div>
			<ul class="event_list">
				<%for(int i=0; i<eventPreviewList.size(); i++){ //시사회 카테고리 리스트
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
			<br>
			<br>
			<div class="more">
				<span class="ctgr">윌시 NOW</span><span><a href="./EventContent.ae?item=nevent">더보기</a></span>
			</div>
			<ul class="event_list">
				<%for(int i=0; i<eventNeventList.size(); i++){ //윌시NOW 카테고리 리스트
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
			<br>
			<br>
			<div class="more">
				<span class="ctgr">제휴 할인</span><span><a href="./EventContent.ae?item=collabo">더보기</a></span>
			</div>
			<ul class="event_list">
				<%
				for(int i=0; i<eventCollaboList.size(); i++){ //제휴할인 카테고리 리스트
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
		<br>
		<br>
			<input type="button" value="지난 이벤트" id="old" onclick="location.href='./EventPast.ae'">
		</div>
		
		<div id="clear"></div>
		
	<%@ include file="/include/footer.jsp" %>
</body>
</html>