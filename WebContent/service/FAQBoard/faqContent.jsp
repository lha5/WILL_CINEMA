<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
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
			
AdminFAQDTO afdto = (AdminFAQDTO) request.getAttribute("afdto");
String pageNum = (String) request.getAttribute("pageNum");
			
%>
	

	<h1>글 내용 보기</h1>
	<table border="1">
	  <tr>
	   <%-- <td>글번호</td><td><%=afdto.getNum() %></td> --%>
	  </tr>
	  <tr>
			<td>글번호</td><td><%=afdto.getNum() %></td>
			<td>글쓴이</td><td><%=afdto.getName() %></td>
	  <tr> 
	     <td>글 제목</td><td colspan="3"><%=afdto.getSubject() %></td> 
	  </tr>
	  <tr> 
	    <td>이미지</td><td colspan="3"><img src="./upload/<%=afdto.getImage()%>"></td>
	    
	  </tr>
	  <tr> 
	     <td>FAQ 내용</td><td colspan="3"><%=afdto.getContent() %></td> 
	<td>카테고리</td><td colspan="3"><%=afdto.getCategory() %></td>	  
	  </tr>
	  <tr>

	  <tr>
	   <td colspan="4">
	   
	    <input type="button" value="수정하기"
	           onclick="location.href='./FAQUpdate.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum %>'" > 
	    
	    
	  
	    <input type="button" value="삭제하기"
	           onclick="location.href='./FAQDelete.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum %>'"> 
	    
	    
	    
	    <input type="button" value="목록보기" onclick="location.href='./FAQList.af?pageNum=<%=pageNum%>'">  
	    </td>	  
	  </tr>
	  
	
	</table>
	
	      	<%@ include file="../../include/footer.jsp" %>



</body>
</html>