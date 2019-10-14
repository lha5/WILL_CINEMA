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
<%
	List eventList = (List)request.getAttribute("eventList");
	String title=request.getParameter("item");
	String keyward=(String)request.getAttribute("keyward");
	if(keyward==null){
		keyward="";
	}
%>
<body>
	<!-- 
		CSS li줄바꿈 처리
		li{float:left;width:100px;height:100px;background:#000;color:#fff;}
		li:nth-of-type(4n-3){background:red;display:block;content:"";clear:left;}
	 -->
	<div>
		<h2>
		<%if(title.equals("movie") ){%>
			영화
		<%}else if(title.equals("preview") ){%>
			시사회/무대인사
		<%}else if(title.equals("nevnet") ){%>
			윌시 NOW
		<%}else if(title.equals("collabo") ){%>
			제휴할인
		<%} %>
		</h2>
		<form action="./EventConSearch.ae?item=<%=title %>" method="post">
		<input type="text" name="keyward" value="<%=keyward%>">
		<input type="submit" value="검색">
		</form>
	</div>
	<ul>
		<%
		if(eventList.size()!=0){
			for(int i=0; i<eventList.size(); i++){ //카테고리 리스트
				AdminEventDTO aedto=(AdminEventDTO)eventList.get(i);
		%>
		<li>
			<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
				<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
			</a>
			<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
		</il>
		<%	}
		}else{%>
			진행되는 이벤트가 없습니다.
		<%}%>
	</ul>
	<br>
	<a href="./EventSummary.ae">이벤트 목록</a>
</body>
</html>