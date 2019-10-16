<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.event_cwrap {
    	width: 980px;
    	margin: 0 auto;
   		padding: 55px 0 50px;
	}
	.event_list {
    	margin-left: -60px;
    	width: 1000px;
	}
	
	.event_list li{
		position: relative;
	    float: left;
	    width: 230px;
	    height: 234px;
	    margin: 0 0 30px 20px;
	    border: 1px solid #dedede;
	    background: #fff;
	    box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	}
	
	li {
		float: left;
		border: solid black 1px;
		width: 228px;
		height: 229px;
		list-style: none;
		margin: 0px 0px 30px 20px;
	}
	li>p {
		margin-top: 4px;
		text-align: center;
		font-size: 0.8em;
	}
	
	li>img {
		width: 228px;
		height: 129px;
	}
	
	.btn_view a{
		clear: both;
		display: block;
		width: 100%;
		height: 40px;
		padding: 8px 0;
		background: #efefef;
		border: 1px solid #dedede;
		text-align: center;
		font-size: 14px;
		color: #231f20;
		font-weight: bold;
		box-sizing: border-box; /* -webkit-box-sizing:border-box; */
		-moz-box-sizing: border-box;
	}
	
	.btn_view span {
    	padding-bottom: 6px;
	}
	
	a {
    	text-decoration: none;
    	color: #555;
	}
	.clear{
		clear: both;
	}
</style>
</head>
<body>
<%
	List eventMovieList = (List)request.getAttribute("eventMovieList");
	List eventPreviewList = (List)request.getAttribute("eventPreviewList");
	List eventNeventList = (List)request.getAttribute("eventNeventList");
	List eventCollaboList = (List)request.getAttribute("eventCollaboList");
%>
	<div class="event_cwrap">
		<input type="button" value="지난 이벤트" onclick="location.href='./EventPast.ae'"> 
		<div class="clear">
			<h2>영화</h2> <a href="./EventContent.ae?item=movie">더보기</a>
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
			<div class="clear">
				<h2>시사회/무대인사</h2> <a href="./EventContent.ae?item=preview">더보기</a>
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
			<div class="clear">
				<h2>윌시 NOW</h2> <a href="./EventContent.ae?item=nevent">더보기</a>
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
			<div class="clear">
				<h2>제휴 할인</h2> <a href="./EventContent.ae?item=collabo">더보기</a>
			</div>
			<ul class="event_list">
				<%for(int i=0; i<eventCollaboList.size(); i++){ //제휴할인 카테고리 리스트
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
		<br class="clear">
		<a href="./EventWrite.ae">이벤트 글쓰기(관리자)</a><br>
		<a href="./EventList.ae">이벤트 목록(관리자)</a>
	</div>
</body>
</html>