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
	     <td>글 제목</td><td colspan="3"><%=afdto.getSubject() %></td> 
	  </tr>
	  <tr> 
	     <td>첨부파일</td>
	     <td colspan="3">
	     <a href="./upload/<%=afdto.getImage()%>">
	       <%=afdto.getImage() %>
	     </a>
	     </td> 
	  </tr>
	  <tr> 
	     <td>글 내용</td><td colspan="3"><%=afdto.getContent() %></td> 
	  </tr>
	  
	  <tr>
	   <td colspan="4">
	    <input type="button" value="수정하기"
	           onclick="location.href='./FAQUpdate.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum %>'"
	    >
	    <input type="button" value="삭제하기"
	           onclick="location.href='./FAQDeleteAction.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum %>'"
	    >
	    
	    <input type="button" value="목록보기" onclick="location.href='./FAQList.af?pageNum=<%=pageNum%>'">
	    </td>	  
	  </tr>
	  
	
	</table>
	
	      



</body>
</html>