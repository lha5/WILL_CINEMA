<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

<%@ include file="../../include/header.jsp" %>

<%
	AdminEventDTO aedto = (AdminEventDTO)request.getAttribute("aedto");
%>
<table border="1">
	<tr>
		<td>제목</td><td>이벤트 기간</td>
	</tr>
	<tr>
		<td><%=aedto.getSubject() %></td>
		<td><%=aedto.getF_date() %>~<%=aedto.getE_date() %></td>
	</tr>
</table>
<%for(int i=1; i<aedto.getImage().split(",").length; i++){ 
	String image=aedto.getImage().split(",")[i];
	if(!image.equals("null")){
%>
<img src="./upload/<%=aedto.getImage().split(",")[i]%>">
	<%}
}%>
<br>
<a href="./EventContent.ae?item=<%=aedto.getCategory()%>">목록으로</a>

<%@ include file="../../include/footer.jsp" %>
</body>
</html>