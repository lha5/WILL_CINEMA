<%@page import="com.review.db.MovieReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="././css/review.css">
</head>
<body>
	
	
	<%	
		String id = (String) session.getAttribute("id");
		int movie_num = (int) request.getAttribute("movie_num");
		int count = (Integer) request.getAttribute("count");
		List<MovieReviewDTO> boardList = (List<MovieReviewDTO>) request.getAttribute("boardList");
		System.out.println("boardList : "+boardList+" id : "+id);
	%>

	<div id="Wrap">	
	 <table id="table" border="0">
	 <%for(int i=0;i<boardList.size();i++){ 
	 	MovieReviewDTO mrdto = boardList.get(i);
	 %>
     <tr>
       <td>평점</td><td colspan="7"><%=mrdto.getRating() %></td>
     </tr>
     <tr>
       <td colspan="6"><%=mrdto.getContent() %></td><td colspan="1"><%=mrdto.getId() %></td>
     </tr>
	     <%if(id.equals(mrdto.getId())){ %>
	     <tr>
	     	<td colspan="8">
	     	<div class="rightloat">
		     	<input type="button" id="button" value="수정하기" onclick="location.href='./MovieReviewUpdate.mr?movie_num=<%=movie_num %>&num=<%=mrdto.getNum() %>'">
				<input type="button" id="button" value="삭제하기" onclick="location.href='./MovieReviewDeleteAction.mr?movie_num=<%=movie_num %>&num=<%=mrdto.getNum() %>'">
	     	</div>
	     	</td>
	     </tr>
	    <%} %>
     <%} %>
	</table>
	
	</div>	
	
</body>
</html>