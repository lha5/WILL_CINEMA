<%@page import="com.admin.service.notice.db.AdminNoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 공지사항</title>
</head>
<body>

	<%@ include file="../../include/header.jsp" %>

	<%
	AdminNoticeDTO andto = (AdminNoticeDTO) request.getAttribute("andto");
	String pageNum = (String) request.getAttribute("pageNum");
	String image = andto.getImage();
	%>

	<table border="1">
		<tr>
			<td>번호</td>
			<td><%=andto.getNum() %></td>
			<td>조회수</td>
			<td><%=andto.getReadcount() %></td>
		</tr>
		<tr>	
			<td>카테고리</td>
			<td><%=andto.getCategory()%></td>
			<td>작성일</td>
			<td><%=andto.getDate()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><%=andto.getSubject() %></td>
		</tr>
		<tr>
			<td>공지 내용</td>
			<td colspan="3">
				<%
				if (image != null) {
				%>
					<img alt="image" src="./upload/<%=andto.getImage() %>">
					<br>
				<%
				}
				%>
				<%=andto.getContent()%>
			</td>
		</tr>
		<%
		if (id != null) {
			if (id.equals("admin")) {
		%>
			<tr>
				<td colspan="4">
		    		<input type="button" value="수정하기" onclick="location.href='./NoticeUpdate.an?num=<%=andto.getNum() %>&pageNum=<%=pageNum %>'">
		    		<input type="button" value="삭제하기" onclick="location.href='./NoticeDelete.an?num=<%=andto.getNum() %>&pageNum=<%=pageNum %>'">
		    	</td>	  
			</tr>
		<%
			}
		}
		%>
	</table>
	<input type="button" value="목록으로" onclick="location.href='./NoticeList.an?pageNum=<%=pageNum%>'">
	<%@ include file="../../include/footer.jsp" %>
	
</body>
</html>