<%@page import="com.movie.db.MovieDTO"%>
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
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
	%>
	
	<div id="Wrap">
	
	<fieldset class="accordion">
		<form action="./MovieReviewWriteAction.mr?movie_num=<%=movie_num %>" method="post">
			<table>
				<tr>
					<td>리뷰</td>
					<td>
						<textarea name="content" row="10" cols="50">summernote넣기</textarea>		<select name="rating">
																									<option value=1>1</option>
																									<option value=2>2</option>
																									<option value=3>3</option>
																									<option value=4>4</option>
																									<option value=5>5</option>
																								</select>  <input type="submit"  value="글쓰기">
					</td>
				</tr>
			</table>

		</form>
	</fieldset>
	
	</div>

</body>
</html>