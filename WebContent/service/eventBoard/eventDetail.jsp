<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 이벤트</title>

<!-- CSS -->
<style type="text/css">
#container {
	width: 890px;
	margin: 50px auto;
}

#eventContent {
	width: 100%;
	margin: 10px auto;
	border-collapse: collapse;
	background-color: #ffffff;
}

tr:NTH-CHILD(1)>td, tr:NTH-CHILD(2)>td {
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	height: 50px;
	letter-spacing: 2px;
}

tr:NTH-CHILD(3)>td {
	padding: 20px 0 20px 5px;
}

tr:NTH-CHILD(1)>td:NTH-CHILD(1), tr:NTH-CHILD(2)>td:NTH-CHILD(1) {
	width: 12%;
	text-align: center;
}

tr:NTH-CHILD(1)>td:NTH-CHILD(2), tr:NTH-CHILD(2)>td:NTH-CHILD(2) {
	padding-left: 10px;
}

tr:NTH-CHILD(4)>td {
	text-align: center;
	padding: 20px;
	border-top: 1px solid #e6e6e6;
}

td>a {
	background-color: #d7282d;
	color: #ffffff;
	font-size: 16px;
	letter-spacing: 2px;
	font-family: inherit;
	font-weight: 500;
	padding: 10px 20px;
}

</style>

</head>
<body>
	<div id="bodyWrap">
	<%@ include file="../../include/header.jsp" %>
	<div id="container">
	<%
	AdminEventDTO aedto = (AdminEventDTO)request.getAttribute("aedto");
	%>
	
	<table id="eventContent">
		<tr>
			<td>제목</td>
			<td><%=aedto.getSubject() %></td>
		</tr>
		<tr>
			<td>이벤트 기간</td>
			<td><%=aedto.getF_date() %> ~ <%=aedto.getE_date() %></td>
		</tr>
		<tr>
			<%
			for (int i=1; i<aedto.getImage().split(",").length; i++) { 
				String image=aedto.getImage().split(",")[i];
				if(!image.equals("null")) {
			%>
					<td colspan="2"><img src="./upload/<%=aedto.getImage().split(",")[i]%>"></td>
			<%
				}
			}
			%>
		</tr>
		<tr>
			<td colspan="2"><a href="./EventContent.ae?item=<%=aedto.getCategory()%>">목록으로</a></td>
		</tr>
	</table>
	
	</div>
	</div>
	<%@ include file="../../include/footer.jsp" %>
</body>
</html>