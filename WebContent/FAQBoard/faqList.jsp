<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
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

<h1>WebContent/FAQList.jsp</h1>


	<%
	int count = (Integer) request.getAttribute("count");
	List<AdminFAQDTO> FAQList = (List<AdminFAQDTO>)request.getAttribute("FAQList");
	String pageNum = (String)request.getAttribute("pageNum");
	
	int pageCount = (Integer) request.getAttribute("pageCount");
	int pageBlock = (Integer) request.getAttribute("pageBlock");
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");

	System.out.println("FAQList :"+FAQList.toString());
	
	
	%>
	<h1> 게시판 글 목록 [ 전체 글 개수 : <%=count %> 개] </h1>

	<h3><a href="./FAQWrite.af">글쓰기</a></h3>


	
   <table border="1">
     <tr>
       <td>번호</td>
       <td>카테고리</td>
       <td>제목</td>
       <td>내용</td>
		<td>이미지</td>
	</tr>
	
		<% 
		 for(int i=0;i<FAQList.size();i++){
			 AdminFAQDTO afdto = FAQList.get(i);
		 
		%>
	  	
	  	<tr>
			<td><%=afdto.getNum()%></td>
			<td><%=afdto.getCategory() %></td>
			<td><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">
           <%=afdto.getSubject() %>
           </a></td>
			<td><%=afdto.getContent()%></td>
			<td><%=afdto.getImage()%></td> 
			
			
		<%} %> 
		
	
	
	</table>
 <%
		if(count != 0) {
			// 이전
			if (startPage > pageBlock) {
			%>
			<a href="./FAQList.af?pageNum=<%=startPage - pageBlock%>">[이전]</a>
			<%
			}

			// 1...10  11..20  21...30
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="./FAQList.af?pageNum=<%=i%>">[<%=i%>]
			</a>
			<%
			}

			// 다음
			if (endPage < pageCount) {
			%>
			<a href="./FAQList.af?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
				}
		}
	%>

</body>
</html>