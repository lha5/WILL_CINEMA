<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 자주 묻는 질문(관리자)</title>
</head>
<body>

	<%@ include file="../../include/header.jsp" %>
	
	<%		
	AdminFAQDTO afdto = (AdminFAQDTO) request.getAttribute("afdto");
	String pageNum = (String) request.getAttribute("pageNum");		
	%>
	

	<table border="1">
		<tr>
			<td>번호</td><td><%=afdto.getNum() %></td>
			<td>카테고리</td>
			<td><%=afdto.getCategory() %></td>	
		<tr> 
	     <td>제목</td><td colspan="3"><%=afdto.getSubject() %></td> 
		</tr>
		<tr> 
	    	<td>이미지</td><td colspan="3"><img src="./upload/<%=afdto.getImage()%>"></td>
		</tr>
		<tr> 
			<td>FAQ 내용</td>
			<td colspan="3"><%=afdto.getContent() %></td>   
		</tr>
		<tr>
		<tr>
			<td colspan="4">
		   		<input type="button" value="수정하기" onclick="location.href='./FAQUpdate.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum %>'" > 
				<input type="button" value="삭제하기" onclick="location.href='./FAQDelete.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum %>'"> 
		    	<input type="button" value="목록보기" onclick="location.href='./FAQList.af?pageNum=<%=pageNum%>'">  
	    	</td>	  
		</tr>
	</table>
	
	<%@ include file="../../include/footer.jsp" %>

</body>
</html>