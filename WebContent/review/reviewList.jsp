<%@page import="com.review.db.MovieReviewDTO"%>
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
	
	
	<%
		/* String id = (String)session.getAttribute("id"); */
		int count = (Integer) request.getAttribute("count");
		List<MovieReviewDTO> boardList = (List<MovieReviewDTO>) request.getAttribute("boardList");
		/* String pageNum = (String)request.getAttribute("pageNum"); */
		System.out.println("boardList : "+boardList);
	%>
	
	 <table border="1">
	 <%for(int i=0;i<boardList.size();i++){ 
	 	MovieReviewDTO mrdto = boardList.get(i);
	 %>
     <tr>
       <td>번호</td><td><%=mrdto.getNum() %></td>
       <td>평점</td><td><%=mrdto.getRating() %></td>
       <td>작성일</td><td><%=mrdto.getDate() %></td>
     </tr>
     <tr>
       <td>내용</td><td colspan="5"><%=mrdto.getContent() %></td>
     </tr>
     <tr>
     	<td colspan="6">
	     	<input type="button" value="수정하기" onclick="location.href='./MovieReviewUpdate.mr?movie_num=<%=mrdto.getMovie_num() %>&num=<%=mrdto.getNum() %>'">
			<input type="button" value="삭제하기" onclick="location.href='./MovieReviewDeleteAction.mr?movie_num=<%=mrdto.getMovie_num() %>&num=<%=mrdto.getNum() %>'">
     	</td>
     </tr>
     <%} %>

</body>
</html>