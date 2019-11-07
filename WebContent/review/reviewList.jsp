
<%@page import="com.review.db.MovieReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="./js/jquery-3.4.1.min.js"></script>
<!-- <link rel="stylesheet" href="./css/review.css"> -->
 

<title> 리뷰 페이지 </title>
	

</head>
<body>
	
	<div id="Wrap">
	<%	
		String id = (String) session.getAttribute("id");
		int movie_num = (int) request.getAttribute("movie_num");
		/* String id = (String)session.getAttribute("id"); */
		int count = (Integer) request.getAttribute("count");
		List<MovieReviewDTO> boardList = (List<MovieReviewDTO>) request.getAttribute("boardList");
		/* String pageNum = (String)request.getAttribute("pageNum"); */
		System.out.println("boardList : "+boardList+" id : "+id);
	%>
	
	 
	 <%for(int i=0;i<boardList.size();i++){ 
	 	MovieReviewDTO mrdto = boardList.get(i);
	 %>
	 <div id="review_content_update<%=mrdto.getNum() %>">
	 <table class="table accordion" border="1">
	 
     <tr>
       <td>평점</td><td><%=mrdto.getRating() %></td>
       <td>작성자</td><td><%=mrdto.getId() %></td>
    <%
	  if(id != null){
	     if(id.equals("admin") || id.equals(mrdto.getId())){ %>
	     
	     	<td rowspan="2">
		     	<input id="button" type="button" value="수정하기" onclick="review_modify(<%=movie_num%>,<%=mrdto.getNum() %>,'<%=mrdto.getId()%>')"><br>
				<input id="button" type="button" value="삭제하기" onclick="location.href='./MovieReviewDeleteAction.mr?movie_num=<%=movie_num %>&num=<%=mrdto.getNum() %>'">
	     	</td>	
	 <%}
	     }%>
     </tr>
     <tr>
       <td>내용</td><td colspan="5"><%=mrdto.getContent() %></td>
     </tr>
	
	  </table>
	 </div> 
     <%} %>
    
	</div>
	
	
	<!-- 수정하기 스크립트 -->
	<script>
			
		function review_modify(movie_num,num,out_id){
			$("#review_content_update"+num).load("./MovieReviewUpdate.mr?movie_num="+movie_num+"&num="+num+"&id="+out_id);  
		}
			
	</script>
	<!-- 수정하기 스크립트 -->
	
</body>
</html>