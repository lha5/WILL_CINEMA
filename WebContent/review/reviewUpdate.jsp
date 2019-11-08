<%@page import="com.review.db.MovieReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<link rel="stylesheet" href="./css/review.css">
<title>Insert title here</title>
<script type="text/javascript">
	function reviewNonCheck() { 
		if(document.reviewAddfr.content.value == ""){
			alert("리뷰를 입력해 주십시오.");
			document.reviewAddfr.content.focus();
			return false;
		}
		
	}

</script>
</head>
<body>
	<div>
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		String id = (String)session.getAttribute("id");
		MovieReviewDTO mrdto = (MovieReviewDTO)request.getAttribute("mrdto");
		
		
		System.out.println("id : "+id);
		if(id == null){
			response.sendRedirect("./MemberLogin.me");
		}		
	%>
	
	
	
		<form action="./MovieReviewUpadatAction.mr?movie_num=<%=movie_num %>&num=<%=num %>" 
			name="reviewAddfr" method="post" onsubmit="return reviewNonCheck()">
			<table class="table accordion" border="1">
				<tr>
					<td>평점</td>
					<td>
						<select name="rating">
							<option value=1 <%if(mrdto.getRating()==1) {%> selected<%} %> >1</option>
							<option value=2 <%if(mrdto.getRating()==2) {%> selected<%} %> >2</option>
							<option value=3 <%if(mrdto.getRating()==3) {%> selected<%} %> >3</option>
							<option value=4 <%if(mrdto.getRating()==4) {%> selected<%} %> >4</option>
							<option value=5 <%if(mrdto.getRating()==5) {%> selected<%} %> >5</option>
						</select>
					</td>
					<td>작성자</td>
					<td><%=mrdto.getId() %></td>
				</tr>
				<tr><td>내용</td>
					<td colspan="4">
						<textarea name="content" row="10" cols="50"><%=mrdto.getContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input id="button" type="submit" value="글수정">
						<input id="button" type="button" value="취소" onclick="location.href='./DetailView.mo?movie_num=<%=movie_num%>'">
					</td>
				</tr>
			</table>

		</form>
</div>
		
</body>
</html>